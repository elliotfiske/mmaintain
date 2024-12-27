module Backend exposing (app)

import Dict
import DirtDict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate(..), PersonData, PersonId(..))
import GameState exposing (updateGameStateDirtDict, updateGameStatePersonDict, updateGameStateRelicDict)
import Lamdera exposing (ClientId, SessionId, sendToFrontend)
import List
import PersonDict
import Relic
import RelicDict
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
            let
                ( newModel, cmd, personId ) =
                    createPersonIfNeeded sessionId clientId model
            in
            ( newModel, cmd )
                |> andThenModel (addClientToList clientId sessionId personId)

        ClientDisconnected _ clientId ->
            ( { model | connectedClients = List.filter (\c -> c /= clientId) model.connectedClients }, Cmd.none )


andThenModel : (Model -> ( Model, Cmd msg )) -> ( Model, Cmd msg ) -> ( Model, Cmd msg )
andThenModel updateFunc ( model, cmd ) =
    let
        ( newModel, newCmd ) =
            updateFunc model
    in
    ( newModel, Cmd.batch [ newCmd, cmd ] )


addClientToList : ClientId -> SessionId -> PersonId -> Model -> ( Model, Cmd BackendMsg )
addClientToList clientId sessionId personId model =
    let
        newState : FrontendPlayingState
        newState =
            { gameState = model.gameState
            , myId = personId
            , targetPosition = Nothing
            }
    in
    ( { model
        | sessionIdToPersonId = Dict.insert sessionId personId model.sessionIdToPersonId
        , connectedClients = clientId :: model.connectedClients
      }
    , sendToFrontend clientId (UpdateFullState newState)
    )


createPersonIfNeeded : SessionId -> ClientId -> Model -> ( Model, Cmd BackendMsg, PersonId )
createPersonIfNeeded sessionId clientId model =
    case Dict.get sessionId model.sessionIdToPersonId of
        Just personId ->
            ( model, Cmd.none, personId )

        Nothing ->
            createPerson clientId model


createPerson : ClientId -> Model -> ( Model, Cmd BackendMsg, PersonId )
createPerson clientId model =
    let
        newPerson : PersonData
        newPerson =
            GameObject.createPerson (PersonId model.biggestId) "Person"

        newPersonDict =
            PersonDict.insert newPerson.id newPerson model.gameState.personDict

        newGamestate =
            updateGameStatePersonDict newPersonDict model.gameState

        incrementedModel =
            incrementBiggestId model
    in
    ( { incrementedModel | gameState = newGamestate }
    , forwardToEveryoneButMe (AddPerson newPerson) clientId model
    , newPerson.id
    )


type alias CreateDirtArgs =
    { x : Int, y : Int, amount : Int }


createDirt : CreateDirtArgs -> Model -> ( Model, Cmd BackendMsg )
createDirt args model =
    -- todo: we manaually tweak the dirtDict here for no good reason. We should just use the GameState functions.
    let
        newDirt : GameObjectTypes.DirtData
        newDirt =
            { x = args.x, y = args.y, amount = args.amount, id = GameObjectTypes.DirtId model.biggestId }

        newDirtDict =
            DirtDict.insert newDirt.id newDirt model.gameState.dirtDict

        newGameState =
            updateGameStateDirtDict newDirtDict model.gameState

        incrementedModel =
            incrementBiggestId model
    in
    ( { incrementedModel | gameState = newGameState }, Lamdera.broadcast (OtherClientPerformedAction Server (AddDirt newDirt)) )


incrementBiggestId : Model -> Model
incrementBiggestId model =
    { model | biggestId = model.biggestId + 1 }


getAndIncrementBiggestId : Model -> ( Int, Model )
getAndIncrementBiggestId model =
    ( model.biggestId, incrementBiggestId model )


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


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
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
                , Lamdera.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
                ]
            )

        PleaseMakeMeDirty ->
            addSomeDirt model

        PleaseGenerateRelic ->
            debugAddRelic model

        PleaseActivateRelic personId relicId ->
            let
                actionsFromActivation =
                    model.gameState
                        |> Relic.createActionOnGameStateFromRelicActivation personId relicId

                ( newGameState, backendTriggers ) =
                    model.gameState
                        |> executeActionOnGameState actionsFromActivation

                newModel =
                    { model | gameState = newGameState }

                ( newModel2, actionsFromTrigger ) =
                    executeBackendTrigger backendTriggers newModel
            in
            ( newModel2
            , Cmd.batch
                [ Lamdera.broadcast (OtherClientPerformedAction Server actionsFromActivation)
                , Lamdera.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
                ]
            )


executeBackendTrigger : BackendTrigger -> Model -> ( Model, ActionOnGamestate )
executeBackendTrigger trigger model =
    case trigger of
        NoOpBackendTrigger ->
            ( model, GameStateNoOp )

        -- TODO: unimplemented
        BatchTrigger _ ->
            ( model, GameStateNoOp )

        ClearedPollution personId dirtData ->
            doRelicRoll personId dirtData model


doRelicRoll : PersonId -> GameObjectTypes.DirtData -> Model -> ( Model, ActionOnGamestate )
doRelicRoll who killedDirt model =
    let
        ( randomRarity, newModel ) =
            getRandomValue model

        ( randomTypeIndex, newModel2 ) =
            getRandomValue newModel

        randomType =
            relicTypeRoll randomTypeIndex

        maybeRarity =
            randomRarity
                |> modBy 100
                |> rarityRoll

        ( newId, incModel ) =
            getAndIncrementBiggestId newModel2

        maybeNewRelic =
            Maybe.map
                (\rarity ->
                    { id = GameObjectTypes.RelicId newId
                    , relicType = randomType
                    , position = GameObjectTypes.OnFloor killedDirt.x killedDirt.y
                    , rarity = rarity
                    , exp = 0
                    }
                )
                maybeRarity

        newRelicDict =
            case maybeNewRelic of
                Nothing ->
                    model.gameState.relicDict

                Just newRelic ->
                    RelicDict.insert newRelic.id newRelic model.gameState.relicDict

        finalModel =
            { incModel | gameState = updateGameStateRelicDict newRelicDict incModel.gameState }

        action =
            case maybeNewRelic of
                Nothing ->
                    GameStateNoOp

                Just relic ->
                    AddRelic relic
    in
    ( finalModel, action )


rarityRoll : Int -> Maybe GameObjectTypes.RelicRarity
rarityRoll randomValue =
    if randomValue < 2 then
        Just GameObjectTypes.Legendary

    else if randomValue < 10 then
        Just GameObjectTypes.Epic

    else if randomValue < 20 then
        Just GameObjectTypes.Rare

    else if randomValue < 50 then
        Just GameObjectTypes.Uncommon

    else if randomValue < 70 then
        Just GameObjectTypes.Common

    else
        Nothing


relicWeights : List ( Int, GameObjectTypes.RelicType )
relicWeights =
    [ ( 60, GameObjectTypes.CleanFast )
    , ( 5, GameObjectTypes.DropAndDouble [] )
    , ( 30, GameObjectTypes.MoreXP )
    ]


relicTypeRoll : Int -> GameObjectTypes.RelicType
relicTypeRoll rawRandomValue =
    let
        totalWeights =
            List.sum (List.map Tuple.first relicWeights)

        randomValue =
            modBy totalWeights rawRandomValue
    in
    List.foldl
        (\( weight, relicType ) ( acc, chosenRelicType ) ->
            if acc < randomValue then
                ( acc + weight, relicType )

            else
                ( acc, chosenRelicType )
        )
        ( 0, GameObjectTypes.CleanFast )
        relicWeights
        |> Tuple.second


debugAddRelic : Model -> ( Model, Cmd BackendMsg )
debugAddRelic model =
    let
        ( newId, incModel ) =
            getAndIncrementBiggestId model

        newRelic : GameObjectTypes.RelicData
        newRelic =
            { id = GameObjectTypes.RelicId newId
            , relicType = GameObjectTypes.DropAndDouble []
            , position = GameObjectTypes.OnFloor 2 2
            , rarity = GameObjectTypes.Legendary
            , exp = 0
            }

        newRelicDict =
            RelicDict.insert newRelic.id newRelic model.gameState.relicDict

        newModel =
            { incModel | gameState = updateGameStateRelicDict newRelicDict incModel.gameState }
    in
    ( newModel, Lamdera.broadcast (OtherClientPerformedAction Server (AddRelic newRelic)) )


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


andThenAddDirtToSpot : Point -> ( Model, Cmd BackendMsg ) -> ( Model, Cmd BackendMsg )
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


addDirtToSpot : Types.Point -> Int -> Model -> ( Model, Cmd BackendMsg )
addDirtToSpot { x, y } amount model =
    let
        existingDirt =
            GameObject.getDirtAtLocation x y model.gameState.dirtDict
    in
    case existingDirt of
        Nothing ->
            createDirt { x = x, y = y, amount = amount } model

        Just dirt ->
            changeDirtAmount dirt model amount


changeDirtAmount : GameObjectTypes.DirtData -> Model -> Int -> ( Model, Cmd BackendMsg )
changeDirtAmount dirt model amount =
    let
        newDirtDict =
            DirtDict.insert dirt.id { dirt | amount = amount } model.gameState.dirtDict

        newModel =
            { model | gameState = updateGameStateDirtDict newDirtDict model.gameState }
    in
    ( newModel
    , Lamdera.broadcast (OtherClientPerformedAction Server (ChangeDirtAmount dirt.id amount))
    )


forwardToEveryoneButMe : ActionOnGamestate -> ClientId -> Model -> Cmd BackendMsg
forwardToEveryoneButMe action myClientId model =
    model.connectedClients
        |> List.filter (\c -> c /= myClientId)
        |> List.map (\id -> sendToFrontend id (OtherClientPerformedAction (Client id) action))
        |> Cmd.batch
