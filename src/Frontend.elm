module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import DirtDict
import GameObject exposing (executeActionOnGameState, relicName)
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), PersonData, PersonId, personIdToInt, personIdToString, relicIdToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as Decode
import Lamdera exposing (sendToBackend)
import PersonDict
import RelicDict
import Types exposing (..)
import Url
import Util


type alias Model =
    FrontendModel


type alias ValidFrontendModelData =
    { me : Types.PersonWithRelics, relicsByPerson : PersonDict.PersonDict Types.PersonWithRelics }


type AssembledFrontendModel
    = ValidFrontendModel ValidFrontendModelData
    | InvalidFrontendModel String


assembleFrontendModel : FrontendPlayingState -> AssembledFrontendModel
assembleFrontendModel state =
    let
        relicsByPersonResult =
            assembleRelicsByPerson state

        myselfResult =
            extractMyself state

        myselfWithRelicsResult =
            Util.andThen2 assembleMyself myselfResult relicsByPersonResult
    in
    case Result.map2 createValidFrontendModel myselfWithRelicsResult relicsByPersonResult of
        Err message ->
            InvalidFrontendModel message

        Ok validFrontendModelData ->
            ValidFrontendModel validFrontendModelData


assembleMyself : PersonData -> PersonDict.PersonDict PersonWithRelics -> Result String PersonWithRelics
assembleMyself myself relicsByPerson =
    case PersonDict.get myself.id relicsByPerson of
        Nothing ->
            Err ("Could not find myself in the 'relics by person' dict. My id: " ++ personIdToString myself.id)

        Just myselfWithRelics ->
            Ok myselfWithRelics


createValidFrontendModel : Types.PersonWithRelics -> PersonDict.PersonDict PersonWithRelics -> ValidFrontendModelData
createValidFrontendModel myself relicsByPerson =
    { me = myself, relicsByPerson = relicsByPerson }


extractMyself : FrontendPlayingState -> Result String PersonData
extractMyself state =
    case PersonDict.get state.myId state.personDict of
        Nothing ->
            Err
                ("You said my ID was "
                    ++ GameObjectTypes.personIdToString state.myId
                    ++ ", but that's not in the dict of persons."
                )

        Just myself ->
            Ok myself


type alias AssembleRelicsByPersonStep =
    Result String (PersonDict.PersonDict PersonWithRelics)


assembleRelicsByPerson : FrontendPlayingState -> Result String (PersonDict.PersonDict PersonWithRelics)
assembleRelicsByPerson state =
    state.relicDict
        |> RelicDict.values
        |> List.foldl (tryUpdatingRelicHolderDict state.personDict) (Ok (emptyRelicsByPerson state))


emptyRelicsByPerson : FrontendPlayingState -> PersonDict.PersonDict PersonWithRelics
emptyRelicsByPerson state =
    state.personDict
        |> PersonDict.values
        |> List.foldl (\p d -> PersonDict.insert p.id { person = p, heldRelics = [] } d) PersonDict.empty


tryUpdatingRelicHolderDict : RealPersonDict -> GameObjectTypes.RelicData -> AssembleRelicsByPersonStep -> AssembleRelicsByPersonStep
tryUpdatingRelicHolderDict people relicData dictSoFarResult =
    let
        relicHolderResult =
            tryGetRelicHolder people relicData
    in
    Result.map2 (addRelicToHolderDict relicData) relicHolderResult dictSoFarResult


tryGetRelicHolder : RealPersonDict -> GameObjectTypes.RelicData -> Result String (Maybe PersonData)
tryGetRelicHolder people relicData =
    case relicData.position of
        GameObjectTypes.HeldBy personId ->
            case PersonDict.get personId people of
                Nothing ->
                    Err ("Relic with ID " ++ relicIdToString relicData.id ++ " thinks it is held by person with ID " ++ personIdToString personId ++ ", but no such person was found in the PersonDict.")

                Just holder ->
                    Ok (Just holder)

        GameObjectTypes.OnFloor _ _ ->
            Ok Nothing


addRelicToHolderDict : GameObjectTypes.RelicData -> Maybe PersonData -> PersonDict.PersonDict PersonWithRelics -> PersonDict.PersonDict PersonWithRelics
addRelicToHolderDict relicData maybeHolder dictSoFar =
    case maybeHolder of
        Nothing ->
            dictSoFar

        Just holder ->
            case PersonDict.get holder.id dictSoFar of
                Nothing ->
                    PersonDict.insert holder.id { person = holder, heldRelics = [ relicData ] } dictSoFar

                Just existingList ->
                    let
                        updatedList =
                            { existingList | heldRelics = relicData :: existingList.heldRelics }
                    in
                    PersonDict.insert holder.id updatedList dictSoFar


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

                "r" ->
                    DebugGenerateRelic

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

        DebugGenerateRelic ->
            ( model, sendToBackend PleaseGenerateRelic )


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
            renderPlayingState playingState


renderPlayingState : FrontendPlayingState -> Html.Html FrontendMsg
renderPlayingState state =
    case assembleFrontendModel state of
        ValidFrontendModel validFrontendModelData ->
            Html.div []
                [ debugStuff state
                , renderHeldRelics validFrontendModelData
                , renderMap state
                ]

        InvalidFrontendModel errorMessage ->
            Html.text ("Error assembling model: " ++ errorMessage)


debugStuff : FrontendPlayingState -> Html.Html FrontendMsg
debugStuff state =
    debugDirtDict state.dirtDict


renderMap : FrontendPlayingState -> Html.Html FrontendMsg
renderMap state =
    renderPeople state
        ++ renderDirt state
        ++ renderFloorRelics state
        |> Html.div []


renderDirt : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderDirt state =
    DirtDict.values state.dirtDict
        |> List.map dirtView


renderHeldRelics : ValidFrontendModelData -> Html.Html FrontendMsg
renderHeldRelics state =
    state.me.heldRelics
        |> List.map (heldRelicView state.me.person.id)
        |> Html.div []


renderFloorRelics state =
    RelicDict.values state.relicDict
        |> List.map floorRelicView


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


floorRelicView : GameObjectTypes.RelicData -> Html.Html FrontendMsg
floorRelicView { relicType, position } =
    case position of
        GameObjectTypes.HeldBy _ ->
            text ""

        GameObjectTypes.OnFloor x y ->
            let
                offsetX =
                    String.fromInt (x * renderOffsetMultiplier)

                offsetY =
                    String.fromInt (y * renderOffsetMultiplier)
            in
            Html.div [ class "absolute text-green-500", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
                [ Html.text "!" ]


heldRelicView : PersonId -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
heldRelicView myId { id, relicType } =
    Html.div []
        [ Html.text (GameObject.relicName relicType)
        , Html.button
            [ Html.Events.onClick (PerformAction (DropRelic id myId)), class "btn btn-primary" ]
            [ text "Drop" ]
        ]


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
                    case GameObject.getRelicAtLocation myself.x myself.y state.relicDict of
                        Nothing ->
                            GameStateNoOp

                        Just relic ->
                            PickUpRelic relic.id myself.id

                Just dirt ->
                    Clean myself.id dirt.id
