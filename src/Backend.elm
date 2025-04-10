module Backend exposing (app)

import Dict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate(..), PersonId(..))
import GameState
import Lamdera
import List
import Relic
import Types exposing (..)
import Util


type alias Model =
    BackendModel


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : a -> Sub BackendMsg
subscriptions _ =
    Sub.batch
        [ Lamdera.onConnect ClientConnected
        , Lamdera.onDisconnect ClientDisconnected
        ]


init : ( Model, Cmd BackendMsg )
init =
    ( { connectedClients = []
      , sessionIdToPersonId = Dict.empty
      , gameState = GameState.empty
      , biggestId = 0
      , bigRandom = 46296
      }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )

        ClientConnected sessionId clientId ->
            handleClientConnected sessionId clientId model

        ClientDisconnected _ clientId ->
            ( { model | connectedClients = List.filter (\c -> c /= clientId) model.connectedClients }, Cmd.none )


handleClientConnected : Lamdera.SessionId -> Lamdera.ClientId -> Model -> ( Model, Cmd BackendMsg )
handleClientConnected sessionId clientId model =
    let
        ( newModel, newPersonCmd, personId ) =
            createPersonIfNeeded sessionId clientId model

        updatedModel =
            { newModel
                | connectedClients = clientId :: newModel.connectedClients
                , sessionIdToPersonId = Dict.insert sessionId personId newModel.sessionIdToPersonId
            }

        newState : BackendToFrontendState
        newState =
            { gameState = updatedModel.gameState
            , myId = personId
            }

        dumpStateToNewClientCmd =
            Lamdera.sendToFrontend clientId (UpdateFullState newState)
    in
    ( updatedModel, Cmd.batch [ newPersonCmd, dumpStateToNewClientCmd ] )


createPersonIfNeeded : Lamdera.SessionId -> Lamdera.ClientId -> Model -> ( Model, Cmd BackendMsg, PersonId )
createPersonIfNeeded sessionId clientId model =
    case Dict.get sessionId model.sessionIdToPersonId of
        Just existingPersonId ->
            ( model, Cmd.none, existingPersonId )

        Nothing ->
            createPerson clientId model


createPerson : Lamdera.ClientId -> Model -> ( Model, Cmd BackendMsg, PersonId )
createPerson clientId model =
    let
        ( newPersonId, incModel ) =
            getAndIncrementBiggestId model

        newPerson =
            GameObject.createPerson (PersonId newPersonId) "Person"

        createPersonAction =
            AddPerson newPerson

        ( finalModel, _ ) =
            executeActionOnModel (Client (PersonId newPersonId)) incModel createPersonAction
    in
    ( finalModel
    , forwardToEveryoneButMe createPersonAction clientId model
    , newPerson.id
    )


type alias CreateDirtArgs =
    { point : GameObjectTypes.Point, amount : Int }


createDirt : CreateDirtArgs -> Model -> ( Model, Cmd BackendMsg )
createDirt args model =
    let
        ( newId, incrementedModel ) =
            getAndIncrementBiggestId model

        newDirt : GameObjectTypes.DirtData
        newDirt =
            { position = args.point, amount = args.amount, id = GameObjectTypes.DirtId newId }

        ( finalModel, _ ) =
            executeActionOnModel Server incrementedModel (AddDirt newDirt)
    in
    ( finalModel, Lamdera.broadcast (OtherClientPerformedAction Server (AddDirt newDirt)) )


handleClientPerformedAction : PersonId -> Lamdera.ClientId -> ActionOnGamestate -> Model -> ( Model, Cmd BackendMsg )
handleClientPerformedAction personId clientId actionOnGamestate model =
    let
        ( newGameState, trigger ) =
            model.gameState
                |> executeActionOnGameState (Client personId) actionOnGamestate

        newModel =
            { model | gameState = newGameState }

        -- Updates model with the triggered "Backend Triggers" and potentially send a new action to send back to the client.
        ( newerModel, actionsFromTrigger ) =
            -- todo: "Server" is incorrect here (placeholder)
            executeBackendTrigger Server trigger newModel
    in
    ( newerModel
    , Cmd.batch
        [ -- "everyone but me" needs to know about the action "I" performed
          forwardToEveryoneButMe actionOnGamestate clientId model

        -- but even "I" need to know about the backend trigger fired by "my" action
        , Lamdera.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
        ]
    )


updateFromFrontend : Lamdera.SessionId -> Lamdera.ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    -- todo: currently we allow anybody to do anything. Need to check "legality" of action (a client could
    -- currently move other characters, for instance)
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        ClientPerformsAction actionOnGamestate ->
            let
                maybePersonId =
                    Dict.get sessionId model.sessionIdToPersonId
            in
            case maybePersonId of
                Nothing ->
                    ( model, Cmd.none )

                Just personId ->
                    handleClientPerformedAction personId clientId actionOnGamestate model

        PleaseMakeMeDirty ->
            addSomeDirt model

        PleaseGenerateRelic ->
            debugAddRelic model

        PleaseActivateRelic personId relicId ->
            let
                actionsFromActivation =
                    Relic.createActionOnGameStateFromRelicActivation personId relicId model.gameState

                ( newModel, relicBackendTriggers ) =
                    executeActionOnModel (Client personId) model actionsFromActivation

                ( newModel2, actionsFromTrigger ) =
                    executeBackendTrigger (Client personId) relicBackendTriggers newModel
            in
            ( newModel2
            , Cmd.batch
                [ Lamdera.broadcast (OtherClientPerformedAction Server actionsFromActivation)
                , Lamdera.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
                ]
            )


{-| Given a backend trigger, update the model and return the action that should be performed on the gamestate.

(so far the "update model" is just incrementing our random number and ID generators)

-}
updateModelFromTrigger : BackendTrigger -> Model -> ( Model, ActionOnGamestate )
updateModelFromTrigger trigger model =
    case trigger of
        NoOpBackendTrigger ->
            ( model, GameStateNoOp )

        -- TODO: unimplemented
        BatchTrigger _ ->
            ( model, GameStateNoOp )

        ClearedPollution personId dirtData ->
            doRelicRoll personId dirtData model

        NuhUh personId ->
            -- TODO: Unimplemented
            ( model, GameStateNoOp )


getRandomRelicRarityAndType : Model -> ( Maybe GameObjectTypes.RelicRarity, GameObjectTypes.RelicType, Model )
getRandomRelicRarityAndType model =
    let
        ( randomRarity, newModel ) =
            getRandomValue model

        ( randomTypeValue, newModel2 ) =
            getRandomValue newModel

        randomType =
            Relic.relicTypeRoll randomTypeValue

        maybeRarity =
            Relic.rarityRoll randomRarity
    in
    ( maybeRarity, randomType, newModel2 )


doRelicRoll : PersonId -> GameObjectTypes.DirtData -> Model -> ( Model, ActionOnGamestate )
doRelicRoll who killedDirt model =
    let
        ( randomRarity, randomType, newModel ) =
            getRandomRelicRarityAndType model
    in
    case randomRarity of
        Nothing ->
            -- unlucky! no relic for you
            ( newModel, GameStateNoOp )

        Just rarity ->
            addRelic killedDirt.position randomType rarity newModel


addRelic : GameObjectTypes.Point -> GameObjectTypes.RelicType -> GameObjectTypes.RelicRarity -> Model -> ( Model, ActionOnGamestate )
addRelic position relicType rarity model =
    let
        ( newId, incModel ) =
            getAndIncrementBiggestId model

        newRelic =
            { id = GameObjectTypes.RelicId newId
            , relicType = relicType
            , rarity = rarity
            , exp = 0
            }
    in
    ( incModel, AddRelic newRelic position )


debugAddRelic : Model -> ( Model, Cmd BackendMsg )
debugAddRelic model =
    let
        ( newId, incModel ) =
            getAndIncrementBiggestId model

        arbitraryPosition =
            { x = 2, y = 2 }

        newRelic : GameObjectTypes.RelicData
        newRelic =
            { id = GameObjectTypes.RelicId newId
            , relicType = GameObjectTypes.DropAndDouble []
            , rarity = GameObjectTypes.Legendary
            , exp = 0
            }

        action =
            AddRelic newRelic arbitraryPosition

        ( newModel, _ ) =
            executeActionOnModel Server incModel action
    in
    ( newModel, Lamdera.broadcast (OtherClientPerformedAction Server action) )


addSomeDirt : Model -> ( Model, Cmd BackendMsg )
addSomeDirt model =
    List.foldl andThenAddDirtToSpot
        ( model, Cmd.none )
        (Util.generateGridOfPoints
            { minX = 5
            , maxX = 45
            , minY = 5
            , maxY = 45
            }
        )


andThenAddDirtToSpot : GameObjectTypes.Point -> ( Model, Cmd BackendMsg ) -> ( Model, Cmd BackendMsg )
andThenAddDirtToSpot point ( model, msg ) =
    let
        ( randomValue, newModel ) =
            getRandomValue model

        dirtAmount =
            if modBy 4 randomValue == 0 then
                modBy 10000 randomValue + 1000

            else
                modBy 800 randomValue + 300
    in
    andThenModel (createDirt { point = point, amount = dirtAmount }) ( newModel, msg )



--- Commonly used utilities ----


getAndIncrementBiggestId : Model -> ( Int, Model )
getAndIncrementBiggestId model =
    ( model.biggestId, { model | biggestId = model.biggestId + 1 } )


forwardToEveryoneButMe : ActionOnGamestate -> Lamdera.ClientId -> Model -> Cmd BackendMsg
forwardToEveryoneButMe action myClientId model =
    model.connectedClients
        |> List.filter (\c -> c /= myClientId)
        |> List.map (\id -> Lamdera.sendToFrontend id (OtherClientPerformedAction Server action))
        |> Cmd.batch


executeBackendTrigger : ActionPerformer -> BackendTrigger -> Model -> ( Model, ActionOnGamestate )
executeBackendTrigger performer trigger model =
    let
        ( newModel, newAction ) =
            updateModelFromTrigger trigger model

        -- todo: currently we ignore recursive triggers, but they may
        -- be useful in the future
        ( finalModel, _ ) =
            executeActionOnModel performer newModel newAction
    in
    ( finalModel, newAction )


{-| Return a "random enough" number.
todo: use the actual random Generator instead
-}
getRandomValue : Model -> ( Int, Model )
getRandomValue model =
    let
        nextRandom =
            modBy 2301875097 (model.bigRandom * 348987 + 174039)
    in
    ( model.bigRandom, { model | bigRandom = nextRandom } )


andThenModel : (Model -> ( Model, Cmd msg )) -> ( Model, Cmd msg ) -> ( Model, Cmd msg )
andThenModel updateFunc ( model, cmd ) =
    let
        ( newModel, newCmd ) =
            updateFunc model
    in
    ( newModel, Cmd.batch [ newCmd, cmd ] )


executeActionOnModel : ActionPerformer -> Model -> ActionOnGamestate -> ( Model, BackendTrigger )
executeActionOnModel actorId model action =
    let
        ( newGameState, backendTrigger ) =
            model.gameState
                |> executeActionOnGameState actorId action
    in
    ( { model | gameState = newGameState }, backendTrigger )
