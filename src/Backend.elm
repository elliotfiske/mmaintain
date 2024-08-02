module Backend exposing (..)

import Dict
import DirtDict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate(..), PersonData, PersonId(..))
import Lamdera exposing (ClientId, SessionId, sendToFrontend)
import List
import PersonDict
import RelicDict
import Types exposing (..)


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
                |> andThen (addClientToList clientId sessionId personId)

        ClientDisconnected _ clientId ->
            ( { model | connectedClients = List.filter (\c -> c /= clientId) model.connectedClients }, Cmd.none )


andThen : (Model -> ( Model, Cmd msg )) -> ( Model, Cmd msg ) -> ( Model, Cmd msg )
andThen updateFunc ( model, cmd ) =
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
            { personDict = model.personDict
            , relicDict = model.relicDict
            , dirtDict = model.dirtDict
            , myId = personId
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
            { id = PersonId model.biggestId, name = "Person", experience = 0, x = 0, y = 0 }

        newPersonDict =
            PersonDict.insert newPerson.id newPerson model.personDict
    in
    ( { model | biggestId = model.biggestId + 1, personDict = newPersonDict }
    , forwardToEveryoneButMe (AddPerson newPerson) clientId model
    , newPerson.id
    )


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
            ( updateModelFromGameState model (executeActionOnGameState actionOnGamestate (constructGameState model))
            , forwardToEveryoneButMe actionOnGamestate clientId model
            )


forwardToEveryoneButMe : ActionOnGamestate -> ClientId -> Model -> Cmd BackendMsg
forwardToEveryoneButMe action myClientId model =
    model.connectedClients
        |> List.filter (\c -> c /= myClientId)
        |> List.map (\id -> sendToFrontend id (OtherClientPerformedAction action))
        |> Cmd.batch
