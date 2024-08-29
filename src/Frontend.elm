module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import Dict
import DirtDict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), PersonData, PersonId, personIdToInt)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Lamdera exposing (sendToBackend)
import PersonDict
import RelicDict
import Types exposing (..)
import Url


type alias Model =
    FrontendModel


type alias ValidFrontendModelData =
    { me : PersonData }


type AssembledFrontendModel
    = ValidFrontendModel ValidFrontendModelData
    | InvalidFrontendModel String


assembleFrontendModel : FrontendPlayingState -> AssembledFrontendModel
assembleFrontendModel state =
    case PersonDict.get state.myId state.personDict of
        Nothing ->
            InvalidFrontendModel
                ("You said my ID was "
                    ++ GameObjectTypes.personIdToString state.myId
                    ++ ", but that's not in the dict of persons."
                )

        Just myself ->
            ValidFrontendModel { me = myself }


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = view
        }


subscriptions : Model -> Sub FrontendMsg
subscriptions model =
    Sub.batch
        [ onKeyDown (keyDecoder model)
        ]


keyDecoder : Model -> Decode.Decoder FrontendMsg
keyDecoder model =
    Decode.map (toKey model) (Decode.field "key" Decode.string)


toKey : Model -> String -> FrontendMsg
toKey model str =
    case model.state of
        Loading ->
            NoOpFrontendMsg

        Error _ ->
            NoOpFrontendMsg

        Playing playingState ->
            case Debug.log "str" str of
                "ArrowUp" ->
                    PerformAction (MovePerson playingState.myId Up)

                "ArrowDown" ->
                    PerformAction (MovePerson playingState.myId Down)

                "ArrowLeft" ->
                    PerformAction (MovePerson playingState.myId Left)

                "ArrowRight" ->
                    PerformAction (MovePerson playingState.myId Right)

                " " ->
                    PerformAction (tryCleaning playingState)

                _ ->
                    NoOpFrontendMsg


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , state = Loading
      }
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        NoOpFrontendMsg ->
            ( model, Cmd.none )

        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                External url ->
                    ( model, Nav.load url )

        UrlChanged url ->
            ( model, Cmd.none )

        PerformAction action ->
            ( updateModelWithAction action model, sendToBackend (ClientPerformsAction action) )

        ClickedPleaseMakeMeDirty ->
            ( model, sendToBackend PleaseMakeMeDirty )


updateModelWithAction : ActionOnGamestate -> Model -> Model
updateModelWithAction actionOnGamestate model =
    case model.state of
        Playing { personDict, dirtDict, relicDict, myId } ->
            let
                gameState =
                    { personDict = personDict, dirtDict = dirtDict, relicDict = relicDict }
            in
            { model | state = gameStateToFrontendState myId (executeActionOnGameState actionOnGamestate gameState) }

        Loading ->
            -- TODO: action came down when the app was still loading. handle this?
            model

        Error string ->
            -- TODO: action came down when the app was in an error state. handle this?
            model


gameStateToFrontendState : PersonId -> GameState -> FrontendState
gameStateToFrontendState myId gameState =
    Playing
        { personDict = gameState.personDict
        , relicDict = gameState.relicDict
        , dirtDict = gameState.dirtDict
        , myId = myId
        }


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        UpdateFullState frontendState ->
            ( { model | state = Playing frontendState }, Cmd.none )

        OtherClientPerformedAction id action ->
            ( updateModelWithAction action model, Cmd.none )


debugDirtDict : RealDirtDict -> Html.Html FrontendMsg
debugDirtDict dict =
    DirtDict.values dict
        |> List.map debugDirt
        |> List.map Html.text
        |> Html.div []


debugDirt : GameObjectTypes.DirtData -> String
debugDirt dirt =
    "x: " ++ String.fromInt dirt.x ++ ", y: " ++ String.fromInt dirt.y


view : Model -> Browser.Document FrontendMsg
view model =
    let
        modelString =
            case model.state of
                Loading ->
                    "Loading..."

                Error string ->
                    "Error: " ++ string

                Playing { personDict, relicDict, dirtDict, myId } ->
                    "PersonDict: " ++ String.fromInt (PersonDict.size personDict) ++ "\nRelicDict: " ++ String.fromInt (RelicDict.size relicDict) ++ "\nDirtDict: " ++ String.fromInt (DirtDict.size dirtDict) ++ "\nMyId: " ++ GameObjectTypes.personIdToString myId
    in
    { title = ""
    , body =
        [ Html.node "link" [ rel "stylesheet", href "/output.css" ] []
        , renderModel model
        , Html.text modelString
        , Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary" ] [ text "Add Dirt" ]
        ]
    }


renderModel : Model -> Html.Html FrontendMsg
renderModel model =
    case model.state of
        Loading ->
            Html.text "Loading..."

        Error string ->
            Html.text ("Error: " ++ string)

        Playing playingState ->
            Html.div []
                [ debugStuff playingState
                , renderPlayingState playingState
                ]


debugStuff : FrontendPlayingState -> Html.Html FrontendMsg
debugStuff state =
    debugDirtDict state.dirtDict


renderPlayingState : FrontendPlayingState -> Html.Html FrontendMsg
renderPlayingState state =
    renderPeople state
        ++ renderDirt state
        |> Html.div []


renderDirt : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderDirt state =
    DirtDict.values state.dirtDict
        |> List.map dirtView


renderPeople : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderPeople state =
    PersonDict.values state.personDict
        |> List.map personView


renderOffsetMultiplier =
    10


personView : PersonData -> Html.Html FrontendMsg
personView { id, name, x, y } =
    let
        offsetX =
            String.fromInt (x * renderOffsetMultiplier)

        offsetY =
            String.fromInt (y * renderOffsetMultiplier)
    in
    Html.div [ class "absolute", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.text (String.fromInt (personIdToInt id)) ]


dirtView : GameObjectTypes.DirtData -> Html.Html FrontendMsg
dirtView { x, y, amount } =
    let
        offsetX =
            String.fromInt (x * renderOffsetMultiplier)

        offsetY =
            String.fromInt (y * renderOffsetMultiplier)
    in
    Html.div [ class "absolute text-orange-500", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.text (String.fromInt amount) ]


me : FrontendPlayingState -> Maybe PersonData
me state =
    PersonDict.get state.myId state.personDict


tryCleaning : FrontendPlayingState -> ActionOnGamestate
tryCleaning state =
    case me state of
        Nothing ->
            GameStateNoOp

        Just myself ->
            case GameObject.getDirtAtLocation myself.x myself.y state.dirtDict of
                Nothing ->
                    GameStateNoOp

                Just dirt ->
                    Clean dirt.id
