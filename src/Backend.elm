module Backend exposing (app)

import Dict
import Effect.Command as Command exposing (Command)
import Effect.Lamdera
import Effect.Subscription as Subscription exposing (Subscription)
import GameObjectIds exposing (..)
import GameObjectTypes exposing (ActionOnGamestate(..))
import GameState
import GameStateManipulation exposing (executeActionOnGameState)
import List
import PersonUtil
import RelicUtil
import SeqSet
import Types exposing (..)
import Util


type alias Model =
    BackendModel


app =
    Effect.Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : a -> Subscription restriction BackendMsg
subscriptions _ =
    Subscription.batch
        [ Effect.Lamdera.onConnect ClientConnected
        , Effect.Lamdera.onDisconnect ClientDisconnected
        ]


init : ( Model, Command restriction toMsg BackendMsg )
init =
    ( { connectedClients = []
      , sessionIdToPersonId = Dict.empty
      , gameState = GameState.empty
      , biggestId = 0
      , bigRandom = 46296
      }
    , Command.none
    )


update : BackendMsg -> Model -> ( Model, Command restriction toMsg BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Command.none )

        ClientConnected sessionId clientId ->
            handleClientConnected sessionId clientId model

        ClientDisconnected _ clientId ->
            ( { model | connectedClients = List.filter (\c -> c /= clientId) model.connectedClients }, Command.none )


handleClientConnected : Lamdera.SessionId -> Lamdera.ClientId -> Model -> ( Model, Command restriction toMsg BackendMsg )
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
            Effect.Lamdera.sendToFrontend clientId (UpdateFullState newState)
    in
    ( updatedModel, Command.batch [ newPersonCmd, dumpStateToNewClientCmd ] )


createPersonIfNeeded : Lamdera.SessionId -> Lamdera.ClientId -> Model -> ( Model, Command restriction toMsg BackendMsg, PersonId )
createPersonIfNeeded sessionId clientId model =
    case Dict.get sessionId model.sessionIdToPersonId of
        Just existingPersonId ->
            ( model, Command.none, existingPersonId )

        Nothing ->
            createPerson clientId model


createPerson : Lamdera.ClientId -> Model -> ( Model, Command restriction toMsg BackendMsg, PersonId )
createPerson clientId model =
    let
        ( newPersonId, incModel ) =
            getAndIncrementBiggestId model

        newPerson =
            PersonUtil.createPerson (PersonId newPersonId) "Person"

        createPersonAction =
            AddPerson newPerson

        ( finalModel, _ ) =
            executeActionOnModel (Client (PersonId newPersonId)) incModel createPersonAction
    in
    ( finalModel
    , forwardToEveryoneButMe createPersonAction Server clientId model
    , newPerson.id
    )


type alias CreateDirtArgs =
    { point : GameObjectTypes.Point, amount : Int }


createDirt : CreateDirtArgs -> Model -> ( Model, Command restriction toMsg BackendMsg )
createDirt args model =
    let
        ( newId, incrementedModel ) =
            getAndIncrementBiggestId model

        newDirt : GameObjectTypes.DirtData
        newDirt =
            { position = args.point, amount = args.amount, id = DirtId newId }

        ( finalModel, _ ) =
            executeActionOnModel Server incrementedModel (AddDirt newDirt)
    in
    ( finalModel, Effect.Lamdera.broadcast (OtherClientPerformedAction Server (AddDirt newDirt)) )


handleClientPerformedAction : PersonId -> Lamdera.ClientId -> ActionOnGamestate -> Model -> ( Model, Command restriction toMsg BackendMsg )
handleClientPerformedAction personId clientId actionOnGamestate model =
    let
        ( newGameState, trigger ) =
            model.gameState
                |> executeActionOnGameState (Client personId) actionOnGamestate

        newModel =
            { model | gameState = newGameState }

        -- Updates model with the triggered "Backend Triggers" and potentially send a new action to send back to the client.
        ( newerModel, actionFromTrigger ) =
            -- todo: "Server" is incorrect here (placeholder)
            executeBackendTrigger (Client personId) trigger newModel
    in
    ( newerModel
    , Command.batch
        [ -- "everyone but me" needs to know about the action "I" performed
          forwardToEveryoneButMe actionOnGamestate (Client personId) clientId model

        -- but even "I" need to know about the backend trigger fired by "my" action
        , Effect.Lamdera.broadcast (OtherClientPerformedAction Server actionFromTrigger)
        ]
    )


updateFromFrontend : Lamdera.SessionId -> Lamdera.ClientId -> ToBackend -> Model -> ( Model, Command restriction toMsg BackendMsg )
updateFromFrontend sessionId clientId msg model =
    -- todo: currently we allow anybody to do anything. Need to check "legality" of action (a client could
    -- currently move other characters, for instance)
    case msg of
        NoOpToBackend ->
            ( model, Command.none )

        ClientPerformsAction actionOnGamestate ->
            let
                maybePersonId =
                    Dict.get sessionId model.sessionIdToPersonId
            in
            case maybePersonId of
                Nothing ->
                    ( model, Command.none )

                Just personId ->
                    handleClientPerformedAction personId clientId actionOnGamestate model

        PleaseMakeMeDirty ->
            addSomeDirt model

        PleaseGenerateRelic ->
            debugAddRelic model

        PleaseActivateRelic personId relicId ->
            let
                actionsFromActivation =
                    GameStateManipulation.createActionOnGameStateFromRelicActivation personId relicId model.gameState

                ( newModel, relicBackendTriggers ) =
                    executeActionOnModel (Client personId) model actionsFromActivation

                ( newModel2, actionsFromTrigger ) =
                    executeBackendTrigger (Client personId) relicBackendTriggers newModel
            in
            ( newModel2
            , Command.batch
                [ Effect.Lamdera.broadcast (OtherClientPerformedAction Server actionsFromActivation)
                , Effect.Lamdera.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
                ]
            )


{-| Given a backend trigger, update the model and return the action that should be performed on the gamestate.

(so far the "update model" is just incrementing our random number and ID generators)

-}
updateModelFromTrigger : ActionPerformer -> BackendTrigger -> Model -> ( Model, ActionOnGamestate )
updateModelFromTrigger performer trigger model =
    case trigger of
        NoOpBackendTrigger ->
            ( model, GameStateNoOp )

        BatchTrigger triggers ->
            handleBatchedTriggers performer triggers model

        ClearedPollution personId dirtData ->
            doRelicRoll personId dirtData model


{-| Process a list of triggers, updating the model and collecting the resulting actions.
Returns the final model and a single action (either GameStateNoOp, the single resulting action, or a BatchAction).
-}
handleBatchedTriggers : ActionPerformer -> List BackendTrigger -> Model -> ( Model, ActionOnGamestate )
handleBatchedTriggers performer triggers model =
    let
        ( finalModel, actions ) =
            List.foldl
                (processSingleTrigger performer)
                ( model, [] )
                triggers
    in
    case actions of
        [] ->
            ( finalModel, GameStateNoOp )

        [ singleAction ] ->
            ( finalModel, singleAction )

        multipleActions ->
            ( finalModel, BatchAction multipleActions )


{-| Process a single trigger and collect its resulting action.
If the action is GameStateNoOp, it won't be added to the collection.
-}
processSingleTrigger : ActionPerformer -> BackendTrigger -> ( Model, List ActionOnGamestate ) -> ( Model, List ActionOnGamestate )
processSingleTrigger performer batchedTrigger ( accModel, accActions ) =
    let
        ( newModel, newAction ) =
            updateModelFromTrigger performer batchedTrigger accModel
    in
    ( newModel
    , if newAction == GameStateNoOp then
        accActions

      else
        newAction :: accActions
    )


getRandomRelicRarityAndType : Model -> ( Maybe GameObjectTypes.RelicRarity, GameObjectTypes.RelicType, Model )
getRandomRelicRarityAndType model =
    let
        ( randomRarity, newModel ) =
            getRandomValue model

        ( randomTypeValue, newModel2 ) =
            getRandomValue newModel

        randomType =
            RelicUtil.relicTypeRoll randomTypeValue

        maybeRarity =
            RelicUtil.rarityRoll randomRarity
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
            { id = RelicId newId
            , relicType = relicType
            , rarity = rarity
            , exp = 0
            }
    in
    ( incModel, AddRelic newRelic position )


debugAddRelic : Model -> ( Model, Command restriction toMsg BackendMsg )
debugAddRelic model =
    let
        ( newId, incModel ) =
            getAndIncrementBiggestId model

        arbitraryPosition =
            { x = 2, y = 2 }

        newRelic : GameObjectTypes.RelicData
        newRelic =
            { id = RelicId newId
            , relicType = GameObjectTypes.GuestBook SeqSet.empty
            , rarity = GameObjectTypes.Legendary
            , exp = 0
            }

        action =
            AddRelic newRelic arbitraryPosition

        ( newModel, _ ) =
            executeActionOnModel Server incModel action
    in
    ( newModel, Effect.Lamdera.broadcast (OtherClientPerformedAction Server action) )


addSomeDirt : Model -> ( Model, Command restriction toMsg BackendMsg )
addSomeDirt model =
    List.foldl andThenAddDirtToSpot
        ( model, Command.none )
        (Util.generateGridOfPoints
            { minX = 5
            , maxX = 10
            , minY = 5
            , maxY = 10
            }
        )


andThenAddDirtToSpot : GameObjectTypes.Point -> ( Model, Command restriction toMsg BackendMsg ) -> ( Model, Command restriction toMsg BackendMsg )
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


forwardToEveryoneButMe : ActionOnGamestate -> ActionPerformer -> Lamdera.ClientId -> Model -> Command restriction toMsg BackendMsg
forwardToEveryoneButMe action performer myClientId model =
    model.connectedClients
        |> List.filter (\c -> c /= myClientId)
        |> List.map (\id -> Effect.Lamdera.sendToFrontend id (OtherClientPerformedAction performer action))
        |> Command.batch


executeBackendTrigger : ActionPerformer -> BackendTrigger -> Model -> ( Model, ActionOnGamestate )
executeBackendTrigger performer trigger model =
    let
        ( newModel, newAction ) =
            updateModelFromTrigger performer trigger model

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


andThenModel : (Model -> ( Model, Command restriction toMsg msg )) -> ( Model, Command restriction toMsg msg ) -> ( Model, Command restriction toMsg msg )
andThenModel updateFunc ( model, cmd ) =
    let
        ( newModel, newCmd ) =
            updateFunc model
    in
    ( newModel, Command.batch [ newCmd, cmd ] )


executeActionOnModel : ActionPerformer -> Model -> ActionOnGamestate -> ( Model, BackendTrigger )
executeActionOnModel actorId model action =
    let
        ( newGameState, backendTrigger ) =
            model.gameState
                |> executeActionOnGameState actorId action
    in
    ( { model | gameState = newGameState }, backendTrigger )
