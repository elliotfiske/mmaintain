module Backend exposing (app)

import Dict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate(..), PersonData, PersonId(..))
import GameState
import Lamdera as L
import List
import Relic
import Types exposing (..)
import Util


type alias Model =
    BackendModel


app =
    L.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : a -> Sub BackendMsg
subscriptions _ =
    Sub.batch
        [ L.onConnect ClientConnected
        , L.onDisconnect ClientDisconnected
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


handleClientConnected : L.SessionId -> L.ClientId -> Model -> ( Model, Cmd BackendMsg )
handleClientConnected sessionId clientId model =
    let
        ( newModel, newPersonCmd, personId ) =
            createPersonIfNeeded sessionId clientId model

        updatedModel =
            { newModel
                | connectedClients = clientId :: newModel.connectedClients
                , sessionIdToPersonId = Dict.insert sessionId personId newModel.sessionIdToPersonId
            }

        newState : FrontendPlayingState
        newState =
            { gameState = updatedModel.gameState
            , myId = personId
            , targetPosition = Nothing
            }

        dumpStateToNewClientCmd =
            L.sendToFrontend clientId (UpdateFullState newState)
    in
    ( updatedModel, Cmd.batch [ newPersonCmd, dumpStateToNewClientCmd ] )


createPersonIfNeeded : L.SessionId -> L.ClientId -> Model -> ( Model, Cmd BackendMsg, PersonId )
createPersonIfNeeded sessionId clientId model =
    case Dict.get sessionId model.sessionIdToPersonId of
        Just existingPersonId ->
            ( model, Cmd.none, existingPersonId )

        Nothing ->
            createPerson clientId model


createPerson : L.ClientId -> Model -> ( Model, Cmd BackendMsg, PersonId )
createPerson clientId model =
    let
        ( newPersonId, incModel ) =
            getAndIncrementBiggestId model

        newPerson =
            GameObject.createPerson (PersonId newPersonId) "Person"

        createPersonAction =
            AddPerson newPerson

        ( finalModel, _ ) =
            executeActionOnModel incModel createPersonAction
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
            executeActionOnModel incrementedModel (AddDirt newDirt)
    in
    ( finalModel, L.broadcast (OtherClientPerformedAction Server (AddDirt newDirt)) )


updateFromFrontend : L.SessionId -> L.ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend _ clientId msg model =
    -- todo: currently we allow anybody to do anything. Need to check "legality" of action (a client could
    -- currently move other characters, for instance)
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        ClientPerformsAction actionOnGamestate ->
            let
                ( newGameState, trigger ) =
                    model.gameState
                        |> executeActionOnGameState actionOnGamestate

                newModel =
                    { model | gameState = newGameState }

                -- Updates model with the triggered "Backend Triggers" and potentially send a new action to send back to the client.
                --   This will include the original client!
                ( newerModel, actionsFromTrigger ) =
                    executeBackendTrigger trigger newModel
            in
            ( newerModel
            , Cmd.batch
                [ -- "everyone but me" needs to know about the action "I" performed
                  forwardToEveryoneButMe actionOnGamestate clientId model

                -- but even "I" need to know about the backend trigger fired by "my" action
                , L.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
                ]
            )

        PleaseMakeMeDirty ->
            addSomeDirt model

        PleaseGenerateRelic ->
            debugAddRelic model

        PleaseActivateRelic personId relicId ->
            let
                actionsFromActivation =
                    Relic.createActionOnGameStateFromRelicActivation personId relicId model.gameState

                ( newModel, relicBackendTriggers ) =
                    executeActionOnModel model actionsFromActivation

                ( newModel2, actionsFromTrigger ) =
                    executeBackendTrigger relicBackendTriggers newModel
            in
            ( newModel2
            , Cmd.batch
                [ L.broadcast (OtherClientPerformedAction Server actionsFromActivation)
                , L.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
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
            , position = GameObjectTypes.OnFloor position
            , rarity = rarity
            , exp = 0
            }
    in
    ( incModel, AddRelic newRelic )


debugAddRelic : Model -> ( Model, Cmd BackendMsg )
debugAddRelic model =
    let
        ( newId, incModel ) =
            getAndIncrementBiggestId model

        newRelic : GameObjectTypes.RelicData
        newRelic =
            { id = GameObjectTypes.RelicId newId
            , relicType = GameObjectTypes.DropAndDouble []
            , position = GameObjectTypes.OnFloor { x = 2, y = 2 }
            , rarity = GameObjectTypes.Legendary
            , exp = 0
            }

        action =
            AddRelic newRelic

        ( newModel, _ ) =
            executeActionOnModel incModel action
    in
    ( newModel, L.broadcast (OtherClientPerformedAction Server (AddRelic newRelic)) )


addSomeDirt : Model -> ( Model, Cmd BackendMsg )
addSomeDirt model =
    List.foldl andThenAddDirtToSpot
        ( model, Cmd.none )
        (Util.generateGridOfPoints
            { minX = 5
            , maxX = 20
            , minY = 5
            , maxY = 15
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
    andThenModel (addDirtToSpot point dirtAmount) ( newModel, msg )


addDirtToSpot : GameObjectTypes.Point -> Int -> Model -> ( Model, Cmd BackendMsg )
addDirtToSpot point amount model =
    createDirt { point = point, amount = amount } model



--- Commonly used utilities ----


getAndIncrementBiggestId : Model -> ( Int, Model )
getAndIncrementBiggestId model =
    ( model.biggestId, { model | biggestId = model.biggestId + 1 } )


forwardToEveryoneButMe : ActionOnGamestate -> L.ClientId -> Model -> Cmd BackendMsg
forwardToEveryoneButMe action myClientId model =
    model.connectedClients
        |> List.filter (\c -> c /= myClientId)
        |> List.map (\id -> L.sendToFrontend id (OtherClientPerformedAction (Client id) action))
        |> Cmd.batch


executeBackendTrigger : BackendTrigger -> Model -> ( Model, ActionOnGamestate )
executeBackendTrigger trigger model =
    let
        ( newModel, newAction ) =
            updateModelFromTrigger trigger model

        ( finalModel, _ ) =
            executeActionOnModel newModel newAction
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


executeActionOnModel : Model -> ActionOnGamestate -> ( Model, BackendTrigger )
executeActionOnModel model action =
    let
        ( newGameState, backendTrigger ) =
            model.gameState
                |> executeActionOnGameState action
    in
    ( { model | gameState = newGameState }, backendTrigger )
