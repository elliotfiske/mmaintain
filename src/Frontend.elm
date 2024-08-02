module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Debug exposing (toString)
import Dict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate, PersonId)
import Html
import Html.Attributes as Attr
import Lamdera exposing (sendToBackend)
import Types exposing (..)
import Url


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }


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

        OtherClientPerformedAction action ->
            ( updateModelWithAction action model, Cmd.none )


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
                    "PersonDict: " ++ toString personDict ++ "\nRelicDict: " ++ toString relicDict ++ "\nDirtDict: " ++ toString dirtDict ++ "\nMyId: " ++ toString myId
    in
    { title = ""
    , body =
        [ Html.div [ Attr.style "text-align" "center", Attr.style "padding-top" "40px" ]
            [ Html.div
                [ Attr.style "font-family" "sans-serif"
                , Attr.style "padding-top" "40px"
                ]
                [ Html.text modelString ]
            ]
        ]
    }
