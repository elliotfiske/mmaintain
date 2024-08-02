module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import Dict
import GameObject exposing (executeActionOnGameState)
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), PersonData, PersonId, personIdToInt)
import Html
import Html.Attributes as Attr exposing (..)
import Json.Decode as Decode
import Lamdera exposing (sendToBackend)
import PersonDict
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
            case str of
                "ArrowUp" ->
                    PerformAction (MovePerson playingState.myId Up)

                "ArrowDown" ->
                    PerformAction (MovePerson playingState.myId Down)

                "ArrowLeft" ->
                    PerformAction (MovePerson playingState.myId Left)

                "ArrowRight" ->
                    PerformAction (MovePerson playingState.myId Right)

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
        [ Html.node "link" [ rel "stylesheet", href "/output.css" ] []
        , renderModel model
        , Html.text modelString
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
            PersonDict.values playingState.personDict
                |> List.map personView
                |> Html.div [ class "game-container" ]


personView : PersonData -> Html.Html FrontendMsg
personView { id, name, x, y } =
    let
        offsetMultiplier =
            10

        offsetX =
            String.fromInt (x * offsetMultiplier)

        offsetY =
            String.fromInt (y * offsetMultiplier)
    in
    Html.div [ class "absolute", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ] [ Html.text (String.fromInt (personIdToInt id)) ]
