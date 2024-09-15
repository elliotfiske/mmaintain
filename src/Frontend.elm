module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import DirtDict
import GameObject
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), PersonData, PersonId, personIdToInt, personIdToString, relicIdToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as Decode
import Lamdera
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
            handleKey playingState str


handleKey : FrontendPlayingState -> String -> FrontendMsg
handleKey state key =
    case assembleFrontendModel state of
        ValidFrontendModel assembledModel ->
            case key of
                "w" ->
                    PerformAction (MovePerson state.myId Up)

                "s" ->
                    PerformAction (MovePerson state.myId Down)

                "a" ->
                    PerformAction (MovePerson state.myId Left)

                "d" ->
                    PerformAction (MovePerson state.myId Right)

                "ArrowUp" ->
                    PerformAction (MovePerson state.myId Up)

                "ArrowDown" ->
                    PerformAction (MovePerson state.myId Down)

                "ArrowLeft" ->
                    PerformAction (MovePerson state.myId Left)

                "ArrowRight" ->
                    PerformAction (MovePerson state.myId Right)

                "r" ->
                    DebugGenerateRelic

                " " ->
                    PerformAction (tryCleaning state assembledModel)

                _ ->
                    NoOpFrontendMsg

        InvalidFrontendModel _ ->
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
            ( updateModelWithAction action model, Lamdera.sendToBackend (ClientPerformsAction action) )

        ClickedPleaseMakeMeDirty ->
            ( model, Lamdera.sendToBackend PleaseMakeMeDirty )

        DebugGenerateRelic ->
            ( model, Lamdera.sendToBackend PleaseGenerateRelic )


updateModelWithAction : ActionOnGamestate -> Model -> Model
updateModelWithAction actionOnGamestate model =
    case model.state of
        Playing { personDict, dirtDict, relicDict, myId } ->
            let
                gameState =
                    { personDict = personDict, dirtDict = dirtDict, relicDict = relicDict }

                ( newGameState, _ ) =
                    GameObject.executeActionOnGameState actionOnGamestate gameState
            in
            { model | state = gameStateToFrontendState myId newGameState }

        Loading ->
            -- TODO: action came down when the app was still loading. handle this?
            model

        Error _ ->
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


view : Model -> Browser.Document FrontendMsg
view model =
    { title = ""
    , body =
        [ Html.node "link" [ rel "stylesheet", href "/output.css" ] []
        , renderModel model
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
                , renderMyHUD state validFrontendModelData
                , renderMap state
                ]

        InvalidFrontendModel errorMessage ->
            Html.text ("Error assembling model: " ++ errorMessage)


renderMyHUD : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderMyHUD state assembledModel =
    Html.div [ class "flex flex-col items-end" ]
        [ renderXP assembledModel.me.person
        , renderCleanStrength assembledModel
        , renderHeldRelics assembledModel
        , maybeRenderGameOver state assembledModel
        ]


debugStuff : FrontendPlayingState -> Html.Html FrontendMsg
debugStuff state =
    Html.div [ class "flex flex-col items-end" ]
        [ debugDicts state
        , Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary" ] [ text "Add Dirt" ]
        ]


debugDicts : FrontendPlayingState -> Html.Html FrontendMsg
debugDicts { personDict, relicDict, dirtDict, myId } =
    Html.text ("PersonDict: " ++ String.fromInt (PersonDict.size personDict) ++ "\nRelicDict: " ++ String.fromInt (RelicDict.size relicDict) ++ "\nDirtDict: " ++ String.fromInt (DirtDict.size dirtDict) ++ "\nMyId: " ++ GameObjectTypes.personIdToString myId)


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


renderXP : PersonData -> Html.Html FrontendMsg
renderXP myself =
    Html.div [ class "flex flex-col text-right" ]
        [ Html.text ("XP: " ++ String.fromInt myself.experience)
        , Html.br [] []
        , Html.text
            ("Level: " ++ String.fromInt (Util.levelForExp myself.experience))
        ]


renderHeldRelics : ValidFrontendModelData -> Html.Html FrontendMsg
renderHeldRelics state =
    Html.div [ class "flex flex-col" ]
        (Html.text
            "My Relics:"
            :: renderRelicList state.me.heldRelics state.me.person.id
        )


renderCleanStrength : ValidFrontendModelData -> Html.Html FrontendMsg
renderCleanStrength state =
    let
        strength =
            simulateClean state
    in
    Html.div [ class "flex flex-col" ]
        [ Html.text
            ("Clean Strength: "
                ++ String.fromInt strength
            )
        ]


simulateClean : ValidFrontendModelData -> Int
simulateClean state =
    let
        action =
            List.foldl
                GameObject.relicModifiesAction
                (Clean state.me.person.id (GameObjectTypes.DirtId 0) 10)
                state.me.heldRelics
    in
    case action of
        Clean _ _ strength ->
            strength

        _ ->
            -1


maybeRenderGameOver : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
maybeRenderGameOver state model =
    if DirtDict.size state.dirtDict == 0 then
        text ("Congratulations, the park is clean! You did this many clean actions: " ++ String.fromInt model.me.person.stats.cleanCount ++ " and you finished off this many pollution patches: " ++ String.fromInt model.me.person.stats.clearCount)

    else
        text ""


renderRelicList : List GameObjectTypes.RelicData -> PersonId -> List (Html.Html FrontendMsg)
renderRelicList list myId =
    List.map (heldRelicView myId) list


renderFloorRelics state =
    RelicDict.values state.relicDict
        |> List.map floorRelicView


renderPeople : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderPeople state =
    PersonDict.values state.personDict
        |> List.map personView


renderOffsetMultiplier =
    50


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
            String.fromInt (y * renderOffsetMultiplier + 15)
    in
    Html.div [ class "absolute text-orange-500", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.text (String.fromInt amount) ]


floorRelicView : GameObjectTypes.RelicData -> Html.Html FrontendMsg
floorRelicView { relicType, rarity, position } =
    case position of
        GameObjectTypes.HeldBy _ ->
            text ""

        GameObjectTypes.OnFloor x y ->
            let
                offsetX =
                    String.fromInt (x * renderOffsetMultiplier)

                offsetY =
                    String.fromInt (y * renderOffsetMultiplier + 15)
            in
            Html.div [ class ("absolute " ++ GameObject.relicColor rarity), style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
                [ Html.text "!" ]


heldRelicView : PersonId -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
heldRelicView myId { id, relicType, rarity } =
    Html.div []
        [ Html.text (GameObject.relicName relicType)
        , Html.div
            [ class (GameObject.relicColor rarity) ]
            [ Html.text (GameObject.relicRarityName rarity) ]
        , Html.button
            [ Html.Events.onClick (PerformAction (DropRelic id myId)), class "btn btn-primary" ]
            [ text "Drop" ]
        ]


tryCleaning : FrontendPlayingState -> ValidFrontendModelData -> ActionOnGamestate
tryCleaning state assembledModel =
    let
        myself =
            assembledModel.me.person
    in
    case GameObject.getDirtAtLocation myself.x myself.y state.dirtDict of
        Nothing ->
            case GameObject.getRelicAtLocation myself.x myself.y state.relicDict of
                Nothing ->
                    GameStateNoOp

                Just relic ->
                    PickUpRelic relic.id myself.id

        Just dirt ->
            Clean myself.id dirt.id 10
