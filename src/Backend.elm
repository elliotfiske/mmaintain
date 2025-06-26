module Backend exposing (app, app_)

import Effect.Command as Command exposing (BackendOnly, Command)
import Effect.Lamdera
import Effect.Subscription as Subscription exposing (Subscription)
import GameObjectIds exposing (..)
import GameObjectTypes exposing (ActionOnGamestate(..), ActionWithMetadata)
import GameState
import GameStateManipulation exposing (executeActionOnGameState)
import Lamdera
import List
import PersonUtil
import RelicUtil
import SeqDict
import Types exposing (..)
import Util


type alias Model =
    BackendModel


app =
    Effect.Lamdera.backend
        Lamdera.broadcast
        Lamdera.sendToFrontend
        app_


app_ =
    { init = init
    , update = update
    , updateFromFrontend = updateFromFrontend
    , subscriptions = subscriptions
    }


subscriptions : Model -> Subscription BackendOnly BackendMsg
subscriptions _ =
    Subscription.batch
        [ Effect.Lamdera.onConnect ClientConnected
        , Effect.Lamdera.onDisconnect ClientDisconnected
        ]


init : ( Model, Command BackendOnly ToFrontend BackendMsg )
init =
    ( { connectedClients = []
      , sessionIdToPersonId = SeqDict.empty
      , gameState = GameState.empty
      , biggestId = 0
      , bigRandom = 46296
      , debugDirtParams =
            { minX = 5
            , maxX = 10
            , minY = 5
            , maxY = 10
            }
      }
    , Command.none
    )


update : BackendMsg -> Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Command.none )

        ClientConnected sessionId clientId ->
            handleClientConnected sessionId clientId model

        ClientDisconnected _ clientId ->
            ( { model | connectedClients = List.filter (\c -> c /= clientId) model.connectedClients }, Command.none )


handleClientConnected : Effect.Lamdera.SessionId -> Effect.Lamdera.ClientId -> Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )
handleClientConnected sessionId clientId model =
    let
        ( newModel, newPersonCmd, personId ) =
            createPersonIfNeeded sessionId clientId model

        updatedModel =
            { newModel
                | connectedClients = clientId :: newModel.connectedClients
                , sessionIdToPersonId = SeqDict.insert sessionId personId newModel.sessionIdToPersonId
            }

        newState : BackendToFrontendState
        newState =
            { gameState = updatedModel.gameState
            , myId = personId
            , debugDirtParams = updatedModel.debugDirtParams
            }

        dumpStateToNewClientCmd =
            Effect.Lamdera.sendToFrontend clientId (UpdateFullState newState)
    in
    ( updatedModel, Command.batch [ newPersonCmd, dumpStateToNewClientCmd ] )


createPersonIfNeeded : Effect.Lamdera.SessionId -> Effect.Lamdera.ClientId -> Model -> ( Model, Command BackendOnly ToFrontend BackendMsg, PersonId )
createPersonIfNeeded sessionId clientId model =
    case SeqDict.get sessionId model.sessionIdToPersonId of
        Just existingPersonId ->
            ( model, Command.none, existingPersonId )

        Nothing ->
            createPerson clientId model


createPerson : Effect.Lamdera.ClientId -> Model -> ( Model, Command BackendOnly ToFrontend BackendMsg, PersonId )
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


createDirt : CreateDirtArgs -> Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )
createDirt args model =
    let
        ( newId, incrementedModel ) =
            getAndIncrementBiggestId model

        newDirt : GameObjectTypes.DirtData
        newDirt =
            { position = args.point, amount = args.amount, maxAmount = args.amount, id = DirtId newId }

        ( finalModel, _ ) =
            executeActionOnModel Server incrementedModel (AddDirt newDirt)
    in
    ( finalModel, Effect.Lamdera.broadcast (ServerAction Server (AddDirt newDirt)) )


handleClientPerformedAction : PersonId -> ActionWithMetadata -> Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )
handleClientPerformedAction personId actionWithMetadata model =
    let
        ( newGameState, trigger ) =
            model.gameState
                |> executeActionOnGameState (Client personId) actionWithMetadata.action

        newModel =
            { model | gameState = newGameState }

        -- Updates model with the triggered "Backend Triggers" and potentially send a new action to send back to the client.
        ( newerModel, actionFromTrigger ) =
            executeBackendTrigger (Client personId) trigger newModel
    in
    ( newerModel
    , Command.batch
        [ -- Send confirmation of the action to all clients
          Effect.Lamdera.broadcast (ActionConfirmed actionWithMetadata)

        -- Send any server-triggered actions that resulted from this player action
        , if actionFromTrigger /= GameStateNoOp then
            Effect.Lamdera.broadcast (ServerAction Server actionFromTrigger)

          else
            Command.none
        ]
    )


updateFromFrontend : Effect.Lamdera.SessionId -> Effect.Lamdera.ClientId -> ToBackend -> Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )
updateFromFrontend sessionId clientId msg model =
    -- todo: currently we allow anybody to do anything. Need to check "legality" of action (a client could
    -- currently move other characters, for instance)
    case msg of
        NoOpToBackend ->
            ( model, Command.none )

        ClientPerformsAction actionWithMetadata ->
            let
                maybePersonId =
                    SeqDict.get sessionId model.sessionIdToPersonId
            in
            case maybePersonId of
                Nothing ->
                    ( model, Command.none )

                Just personId ->
                    handleClientPerformedAction personId actionWithMetadata model

        PleaseMakeMeDirty ->
            addSomeDirt model

        PleaseGenerateRelic ->
            debugAddRelic model

        PleaseNukeBackend ->
            let
                emptyGameState =
                    { personDict = model.gameState.personDict
                    , relicsByLocation = SeqDict.empty
                    , dirtByLocation = SeqDict.empty
                    , relicIdToLocationIndex = SeqDict.empty
                    }
            in
            ( { model | gameState = emptyGameState }
            , Effect.Lamdera.broadcast (UpdateFullState { gameState = emptyGameState, myId = model.sessionIdToPersonId |> SeqDict.values |> List.head |> Maybe.withDefault (PersonId 0), debugDirtParams = model.debugDirtParams })
            )

        UpdateDebugDirtParams params ->
            let
                newModel =
                    { model | debugDirtParams = params }

                newState =
                    { gameState = newModel.gameState, myId = model.sessionIdToPersonId |> SeqDict.values |> List.head |> Maybe.withDefault (PersonId 0), debugDirtParams = params }
            in
            ( newModel
            , Effect.Lamdera.broadcast (UpdateFullState newState)
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


getRandomRelicRarityAndType : PersonId -> GameObjectTypes.DirtData -> Model -> ( Maybe GameObjectTypes.RelicRarity, GameObjectTypes.RelicType, Model )
getRandomRelicRarityAndType who killedDirt model =
    let
        ( randomRarity, newModel ) =
            getRandomValue model

        ( randomTypeValue, newModel2 ) =
            getRandomValue newModel

        randomType =
            RelicUtil.relicTypeRoll randomTypeValue

        maybeFinder =
            SeqDict.get who model.gameState.personDict

        playerBoost =
            case maybeFinder of
                Just person ->
                    GameStateManipulation.relicRarityBoostForPlayer model.gameState person

                Nothing ->
                    0

        dirtBoost =
            RelicUtil.dirtSizeBoostForAmount killedDirt.maxAmount

        totalBoost =
            playerBoost + dirtBoost

        maybeRarity =
            RelicUtil.rarityRoll randomRarity totalBoost
    in
    ( maybeRarity, randomType, newModel2 )


doRelicRoll : PersonId -> GameObjectTypes.DirtData -> Model -> ( Model, ActionOnGamestate )
doRelicRoll who killedDirt model =
    let
        ( randomRarity, randomType, newModel ) =
            getRandomRelicRarityAndType who killedDirt model
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


debugAddRelic : Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )
debugAddRelic model =
    let
        ( newId, incModel ) =
            getAndIncrementBiggestId model

        arbitraryPosition =
            { x = 2, y = 2 }

        newRelic : GameObjectTypes.RelicData
        newRelic =
            { id = RelicId newId
            , relicType = GameObjectTypes.DropAndDouble []
            , rarity = GameObjectTypes.Legendary
            , exp = 0
            }

        action =
            AddRelic newRelic arbitraryPosition

        ( newModel, _ ) =
            executeActionOnModel Server incModel action
    in
    ( newModel, Effect.Lamdera.broadcast (ServerAction Server action) )


addSomeDirt : Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )
addSomeDirt model =
    List.foldl andThenAddDirtToSpot
        ( model, Command.none )
        (Util.generateGridOfPoints
            { minX = model.debugDirtParams.minX
            , maxX = model.debugDirtParams.maxX
            , minY = model.debugDirtParams.minY
            , maxY = model.debugDirtParams.maxY
            }
        )


andThenAddDirtToSpot : GameObjectTypes.Point -> ( Model, Command BackendOnly ToFrontend BackendMsg ) -> ( Model, Command BackendOnly ToFrontend BackendMsg )
andThenAddDirtToSpot point ( model, msg ) =
    let
        ( randomValue, newModel ) =
            getRandomValue model

        extraBigOrSmall =
            modBy 5 randomValue

        dirtAmount =
            if extraBigOrSmall == 0 then
                modBy 10000 randomValue + 1000

            else if extraBigOrSmall == 1 then
                modBy 50 randomValue + 10

            else
                modBy 800 randomValue + 300
    in
    andThenModel (createDirt { point = point, amount = dirtAmount }) ( newModel, msg )



--- Commonly used utilities ----


getAndIncrementBiggestId : Model -> ( Int, Model )
getAndIncrementBiggestId model =
    ( model.biggestId, { model | biggestId = model.biggestId + 1 } )


forwardToEveryoneButMe : ActionOnGamestate -> ActionPerformer -> Effect.Lamdera.ClientId -> Model -> Command BackendOnly ToFrontend BackendMsg
forwardToEveryoneButMe action performer myClientId model =
    model.connectedClients
        |> List.filter (\c -> c /= myClientId)
        |> List.map (\id -> Effect.Lamdera.sendToFrontend id (ServerAction performer action))
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


andThenModel : (Model -> ( Model, Command BackendOnly ToFrontend BackendMsg )) -> ( Model, Command BackendOnly ToFrontend BackendMsg ) -> ( Model, Command BackendOnly ToFrontend BackendMsg )
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
