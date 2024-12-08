module Backend exposing (app)

import Dict
import DirtDict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate(..), PersonData, PersonId(..))
import Lamdera exposing (ClientId, SessionId, sendToFrontend)
import List
import PersonDict
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
      , personDict = PersonDict.empty
      , relicDict = RelicDict.empty
      , dirtDict = DirtDict.empty
      , biggestId = 0
      , bigRandom = 46296
      }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    let
        ( newModel, cmd ) =
            maybeDoUpdate msg model
    in
    case assembleBackendModel newModel of
        ValidBackendModel _ ->
            ( newModel, cmd )

        InvalidBackendModel _ ->
            -- TODO: Attempted to get to an invalid state! Cancel the action. In the future it would be good to log this (to a Google Sheet maybe?)
            ( model, Cmd.none )


maybeDoUpdate : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
maybeDoUpdate msg model =
    let
        assembledModel =
            assembleBackendModel model
    in
    case assembledModel of
        ValidBackendModel validModel ->
            actualUpdate msg model validModel

        InvalidBackendModel _ ->
            ( model, Cmd.none )


actualUpdate : BackendMsg -> Model -> ValidBackendModelData -> ( Model, Cmd BackendMsg )
actualUpdate msg model assembledModel =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )

        ClientConnected sessionId clientId ->
            let
                ( newModel, cmd, personId ) =
                    createPersonIfNeeded sessionId clientId model assembledModel
            in
            ( newModel, cmd )
                |> andThen (addClientToList clientId sessionId personId)

        ClientDisconnected _ clientId ->
            ( { model | connectedClients = List.filter (\c -> c /= clientId) model.connectedClients }, Cmd.none )


type alias ValidBackendModelData =
    { sessionIdToPersonData : Dict.Dict SessionId PersonData }


type AssembledBackendModel
    = ValidBackendModel ValidBackendModelData
    | InvalidBackendModel String


assembleBackendModel : Model -> AssembledBackendModel
assembleBackendModel model =
    case assembleSessionIdsToPersonData model of
        Ok dict ->
            ValidBackendModel
                { sessionIdToPersonData = dict }

        Err msg ->
            InvalidBackendModel msg


type alias AssembleStep =
    Result String (Dict.Dict SessionId PersonData)


assembleSessionIdsToPersonData : Model -> AssembleStep
assembleSessionIdsToPersonData model =
    Dict.foldl (convertPersonIdToPersonData model.personDict) (Ok Dict.empty) model.sessionIdToPersonId


convertPersonIdToPersonData : RealPersonDict -> SessionId -> PersonId -> AssembleStep -> AssembleStep
convertPersonIdToPersonData dict sessionId personId acc =
    Result.andThen (addPersonDataToDict dict sessionId personId) acc


addPersonDataToDict : RealPersonDict -> SessionId -> PersonId -> Dict.Dict SessionId PersonData -> AssembleStep
addPersonDataToDict dict sessionId personId acc =
    case PersonDict.get personId dict of
        Nothing ->
            Err
                ("Could not find person with ID "
                    ++ GameObjectTypes.personIdToString personId
                    ++ " which was mapped from session ID "
                    ++ sessionId
                )

        Just personData ->
            Ok (Dict.insert sessionId personData acc)


andThen : (Model -> ( Model, Cmd msg )) -> ( Model, Cmd msg ) -> ( Model, Cmd msg )
andThen updateFunc ( model, cmd ) =
    let
        ( newModel, newCmd ) =
            updateFunc model
    in
    ( newModel, Cmd.batch [ newCmd, cmd ] )


addClientToList : ClientId -> SessionId -> PersonData -> Model -> ( Model, Cmd BackendMsg )
addClientToList clientId sessionId personData model =
    let
        newState : FrontendPlayingState
        newState =
            { personDict = model.personDict
            , relicDict = model.relicDict
            , dirtDict = model.dirtDict
            , myId = personData.id
            }
    in
    ( { model
        | sessionIdToPersonId = Dict.insert sessionId personData.id model.sessionIdToPersonId
        , connectedClients = clientId :: model.connectedClients
      }
    , sendToFrontend clientId (UpdateFullState newState)
    )


createPersonIfNeeded : SessionId -> ClientId -> Model -> ValidBackendModelData -> ( Model, Cmd BackendMsg, PersonData )
createPersonIfNeeded sessionId clientId model assembledModel =
    case Dict.get sessionId assembledModel.sessionIdToPersonData of
        Just personData ->
            ( model, Cmd.none, personData )

        Nothing ->
            createPerson clientId model


createPerson : ClientId -> Model -> ( Model, Cmd BackendMsg, PersonData )
createPerson clientId model =
    let
        newPerson : PersonData
        newPerson =
            GameObject.createPerson (PersonId model.biggestId) "Person"

        newPersonDict =
            PersonDict.insert newPerson.id newPerson model.personDict

        incrementedModel =
            incrementBiggestId model
    in
    ( { incrementedModel | personDict = newPersonDict }
    , forwardToEveryoneButMe (AddPerson newPerson) clientId model
    , newPerson
    )


type alias CreateDirtArgs =
    { x : Int, y : Int, amount : Int }


createDirt : CreateDirtArgs -> Model -> ( Model, Cmd BackendMsg )
createDirt args model =
    let
        newDirt : GameObjectTypes.DirtData
        newDirt =
            { x = args.x, y = args.y, amount = args.amount, id = GameObjectTypes.DirtId model.biggestId }

        newDirtDict =
            DirtDict.insert newDirt.id newDirt model.dirtDict

        incrementedModel =
            incrementBiggestId model
    in
    ( { incrementedModel | dirtDict = newDirtDict }, Lamdera.broadcast (OtherClientPerformedAction Server (AddDirt newDirt)) )


incrementBiggestId : Model -> Model
incrementBiggestId model =
    { model | biggestId = model.biggestId + 1 }


getAndIncrementBiggestId : Model -> ( Int, Model )
getAndIncrementBiggestId model =
    ( model.biggestId, incrementBiggestId model )


{-| Return a "random enough" number.
-}
getRandomValue : Model -> ( Int, Model )
getRandomValue model =
    let
        nextRandom =
            modBy 2301875097 (model.bigRandom * 348987 + 174039)
    in
    ( model.bigRandom, { model | bigRandom = nextRandom } )


constructGameState : Model -> GameState
constructGameState model =
    { personDict = model.personDict
    , relicDict = model.relicDict
    , dirtDict = model.dirtDict
    }


updateModelFromGameState : Model -> GameState -> Model
updateModelFromGameState model gameState =
    { model
        | personDict = gameState.personDict
        , relicDict = gameState.relicDict
        , dirtDict = gameState.dirtDict
    }


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
                    model
                        |> constructGameState
                        |> executeActionOnGameState actionOnGamestate

                newModel =
                    updateModelFromGameState model newGameState

                -- todo: handle `trigger` here. Will update model and potentially have a new action to send back to the client. This could include an action to the original client!
                ( newerModel, actionsFromTrigger ) =
                    executeBackendTrigger trigger newModel
            in
            ( newerModel
            , Cmd.batch
                [ forwardToEveryoneButMe actionOnGamestate clientId model
                , Lamdera.broadcast (OtherClientPerformedAction Server actionsFromTrigger)
                ]
            )

        PleaseMakeMeDirty ->
            addSomeDirt model

        PleaseGenerateRelic ->
            addRelic model


executeBackendTrigger : BackendTrigger -> Model -> ( Model, ActionOnGamestate )
executeBackendTrigger trigger model =
    case trigger of
        NoOpBackendTrigger ->
            ( model, GameStateNoOp )

        BatchTrigger backendTriggers ->
            ( model, GameStateNoOp )

        ClearedPollution personId dirtData ->
            doRelicRoll personId dirtData model


doRelicRoll : PersonId -> GameObjectTypes.DirtData -> Model -> ( Model, ActionOnGamestate )
doRelicRoll who killedDirt model =
    let
        ( randomRarity, newModel ) =
            getRandomValue model

        maybeRarity =
            randomRarity
                |> modBy 100
                |> rarityRoll

        ( newId, incModel ) =
            getAndIncrementBiggestId newModel

        maybeNewRelic =
            Maybe.map
                (\rarity ->
                    { id = GameObjectTypes.RelicId newId
                    , relicType = GameObjectTypes.CleanFast
                    , position = GameObjectTypes.OnFloor killedDirt.x killedDirt.y
                    , rarity = rarity
                    , exp = 0
                    }
                )
                maybeRarity

        newRelicDict =
            case maybeNewRelic of
                Nothing ->
                    model.relicDict

                Just newRelic ->
                    RelicDict.insert newRelic.id newRelic model.relicDict

        finalModel =
            { incModel | relicDict = newRelicDict }

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


addRelic : Model -> ( Model, Cmd BackendMsg )
addRelic model =
    let
        ( newId, incModel ) =
            getAndIncrementBiggestId model

        newRelic : GameObjectTypes.RelicData
        newRelic =
            { id = GameObjectTypes.RelicId newId, relicType = GameObjectTypes.CleanFast, position = GameObjectTypes.OnFloor 2 2, rarity = GameObjectTypes.Legendary, exp = 0 }

        newRelicDict =
            RelicDict.insert newRelic.id newRelic model.relicDict
    in
    ( { incModel | relicDict = newRelicDict }, Lamdera.broadcast (OtherClientPerformedAction Server (AddRelic newRelic)) )


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
    andThen (addDirtToSpot point dirtAmount) ( newModel, msg )


addDirtToSpot : Types.Point -> Int -> Model -> ( Model, Cmd BackendMsg )
addDirtToSpot { x, y } amount model =
    let
        existingDirt =
            GameObject.getDirtAtLocation x y model.dirtDict
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
            DirtDict.insert dirt.id { dirt | amount = amount } model.dirtDict
    in
    ( { model | dirtDict = newDirtDict }, Lamdera.broadcast (OtherClientPerformedAction Server (ChangeDirtAmount dirt.id amount)) )


forwardToEveryoneButMe : ActionOnGamestate -> ClientId -> Model -> Cmd BackendMsg
forwardToEveryoneButMe action myClientId model =
    model.connectedClients
        |> List.filter (\c -> c /= myClientId)
        |> List.map (\id -> sendToFrontend id (OtherClientPerformedAction (Client id) action))
        |> Cmd.batch
