module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Dom
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import DirtDict
import GameObject
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), PersonData, PersonId, relicIdToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as Decode
import Lamdera
import List.Extra
import Material.Icons.Outlined as Outlined
import Material.Icons.Types as Coloring
import PersonDict
import Relic
import RelicDict
import Task
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
            Err ("Could not find myself in the 'relics by person' dict. My id: " ++ GameObjectTypes.personIdToString myself.id)

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
                    Err
                        ("Relic with ID "
                            ++ relicIdToString relicData.id
                            ++ " thinks it is held by person with ID "
                            ++ GameObjectTypes.personIdToString personId
                            ++ ", but no such person was found in the PersonDict."
                        )

                Just holder ->
                    Ok (Just holder)

        GameObjectTypes.OnFloor _ _ ->
            Ok Nothing


addRelicToHolderDict :
    GameObjectTypes.RelicData
    -> Maybe PersonData
    -> PersonDict.PersonDict PersonWithRelics
    -> PersonDict.PersonDict PersonWithRelics
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
            let
                -- Necessary otherwise the next "space" keypress will activate buttons unexpectedly
                refocus =
                    Task.attempt (\_ -> NoOpFrontendMsg) (Browser.Dom.focus "main-map")
            in
            ( updateModelWithAction action model, Cmd.batch [ Lamdera.sendToBackend (ClientPerformsAction action), refocus ] )

        ActivatedRelic myId relicId ->
            -- todo: set "loading" state, since this is a backend-authoritative action and it could take time
            ( model, Lamdera.sendToBackend (PleaseActivateRelic myId relicId) )

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
            -- TODO: action came down when the app was still loading. We assume this can't happen – it
            --   would mean that the state will be desynced which is bad. Need to add an "error report"
            --   for this that will alert me if this happens on a client.
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
    { title = "mmaintain"
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


renderModals : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderModals state model =
    if DirtDict.size state.dirtDict == 0 then
        node "dialog"
            [ id "my_modal_1"
            , class "modal"
            , attribute "open" "true"
            ]
            [ div
                [ class "modal-box"
                ]
                [ h3
                    [ class "text-lg font-bold"
                    ]
                    [ text "THE PARK IS CLEAN!!!" ]
                , iframe
                    [ src "https://giphy.com/embed/PFs9HklIZefehcOphI/video"
                    , width 480
                    , height 202
                    , attribute "frameborder" "0"
                    , class "giphy-embed"
                    , attribute "allowfullscreen" ""
                    ]
                    []
                , p
                    [ class "py-4"
                    ]
                    [ text
                        ("Congratulations, the park is clean! You did this many clean actions: "
                            ++ String.fromInt model.me.person.stats.cleanCount
                            ++ " and you finished off this many pollution patches: "
                            ++ String.fromInt model.me.person.stats.clearCount
                        )
                    ]
                , div
                    [ class "modal-action"
                    ]
                    [ Html.form
                        [ method "dialog"
                        ]
                        [ {- if there is a button in form, it will close the modal -}
                          button
                            [ class "btn btn-primary"
                            , Html.Events.onClick
                                ClickedPleaseMakeMeDirty
                            ]
                            [ text "I'M NOT DONE, ADD MORE DIRT!" ]
                        ]
                    ]
                ]
            ]

    else
        text ""


renderPlayingState : FrontendPlayingState -> Html.Html FrontendMsg
renderPlayingState state =
    case assembleFrontendModel state of
        ValidFrontendModel validFrontendModelData ->
            Html.div [ class "h-full" ]
                [ debugStuff state
                , renderModals state validFrontendModelData
                , Html.div [ class "flex justify-end h-full" ]
                    [ renderMap state
                    , renderMyHUD state validFrontendModelData
                    ]
                ]

        InvalidFrontendModel errorMessage ->
            Html.text ("Error assembling model: " ++ errorMessage)


renderMyHUD : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderMyHUD state assembledModel =
    Html.div [ class "flex flex-col items-center h-full bg-base-100 mx-3" ]
        [ renderXP assembledModel.me.person
        , renderCleanStrength state assembledModel
        , renderXPMultiplier state assembledModel
        , renderHeldRelics assembledModel
        ]


debugStuff : FrontendPlayingState -> Html.Html FrontendMsg
debugStuff state =
    Html.div [ class "flex flex-col absolute" ]
        [ debugDicts state
        , Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary" ] [ text "Add Dirt" ]
        ]


debugDicts : FrontendPlayingState -> Html.Html FrontendMsg
debugDicts { personDict, relicDict, dirtDict, myId } =
    Html.text
        ("PersonDict: "
            ++ String.fromInt (PersonDict.size personDict)
            ++ "\nRelicDict: "
            ++ String.fromInt (RelicDict.size relicDict)
            ++ "\nDirtDict: "
            ++ String.fromInt (DirtDict.size dirtDict)
            ++ "\nMyId: "
            ++ GameObjectTypes.personIdToString myId
        )


renderMap : FrontendPlayingState -> Html.Html FrontendMsg
renderMap state =
    renderPeople state
        ++ renderDirt state
        ++ renderFloorRelics state
        ++ renderTooltipLayer state
        |> Html.div [ class "bg-green-800 flex-grow", id "main-map", tabindex 0 ]


renderDirt : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderDirt state =
    DirtDict.values state.dirtDict
        |> List.map dirtView


renderXP : PersonData -> Html.Html FrontendMsg
renderXP myself =
    Html.div [ class "prose" ]
        [ Html.h2 [ class "text-center" ]
            [ Html.text
                ("Level " ++ String.fromInt (Util.levelForExp myself.experience))
            ]
        , levelProgressBar myself
        ]


levelProgressBar : PersonData -> Html.Html FrontendMsg
levelProgressBar person =
    Html.div [ class "bg-cyan-600 h-4 w-64 rounded" ]
        [ Html.div
            [ class "bg-cyan-100 h-4 rounded"
            , style "width" (String.fromInt (round (Util.levelProgress person.experience)) ++ "%")
            ]
            []
        ]


renderCleanStrength : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderCleanStrength state modelData =
    let
        strength =
            GameObject.cleanStrengthForPlayer state.relicDict modelData.me.person
    in
    Html.div [ class "w-full prose" ]
        [ Html.h3 [ class "text-center" ]
            [ Html.text ("Clean Strength: " ++ String.fromInt strength) ]
        ]


renderXPMultiplier : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderXPMultiplier state modelData =
    let
        xpMultiplier =
            GameObject.xpMultiplierForPlayer state.relicDict modelData.me.person
    in
    if xpMultiplier == 1 then
        Html.text ""

    else
        Html.div [ class "w-full prose" ]
            [ Html.h3 [ class "text-center" ]
                [ Html.text ("XP Multiplier: " ++ String.fromFloat xpMultiplier) ]
            ]


renderHeldRelics : ValidFrontendModelData -> Html.Html FrontendMsg
renderHeldRelics state =
    Html.div [ class "w-full flex flex-col flex-gro" ]
        [ Html.div [ class "prose mt-8" ]
            [ Html.h2 [ class "text-center" ]
                [ Html.text "My Relics:" ]
            ]
        , Html.div [ class "flex flex-col gap-2 flex-grow flex-wrap h-[660px] p-2", id "relic-list" ]
            (renderRelicList
                state.me.heldRelics
                state.me.person.id
                ++ renderRelicSlots state.me
            )
        ]


renderRelicList : List GameObjectTypes.RelicData -> PersonId -> List (Html.Html FrontendMsg)
renderRelicList list myId =
    List.map (heldRelicView myId) list


renderRelicSlots : PersonWithRelics -> List (Html.Html FrontendMsg)
renderRelicSlots person =
    let
        myLevel =
            Util.levelForExp person.person.experience

        totalUnlockedSlots =
            GameObject.relicSlotsForLevel myLevel

        numAvailableSlots =
            totalUnlockedSlots - List.length person.heldRelics

        lockedSlots =
            GameObject.lockedRelicSlots myLevel
    in
    List.repeat numAvailableSlots availableRelicView ++ List.map lockedSlotView lockedSlots


availableRelicView : Html.Html FrontendMsg
availableRelicView =
    card [ Html.div [ class "text-center" ] [ Html.text "Free Slot" ] ]
        []


lockedSlotView : Int -> Html.Html FrontendMsg
lockedSlotView lockedUntil =
    card [ Outlined.lock 16 Coloring.Inherit, Html.text "Locked" ]
        [ Html.div
            [ class "" ]
            [ Html.text ("Until level " ++ String.fromInt lockedUntil) ]
        ]


renderFloorRelics : FrontendPlayingState -> List (Html FrontendMsg)
renderFloorRelics state =
    RelicDict.values state.relicDict
        |> List.map (floorRelicView state.myId)


renderTooltipLayer : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderTooltipLayer state =
    -- Group relics by location
    RelicDict.values state.relicDict
        |> List.filterMap
            (\relic ->
                case relic.position of
                    GameObjectTypes.OnFloor x y ->
                        Just relic

                    GameObjectTypes.HeldBy _ ->
                        Nothing
            )
        |> Util.groupWhile relicsAreSameLocation
        |> List.map (renderTooltip state)


relicsAreSameLocation : GameObjectTypes.RelicData -> GameObjectTypes.RelicData -> Bool
relicsAreSameLocation relic1 relic2 =
    case ( relic1.position, relic2.position ) of
        ( GameObjectTypes.OnFloor x1 y1, GameObjectTypes.OnFloor x2 y2 ) ->
            x1 == x2 && y1 == y2

        _ ->
            False


renderTooltip : FrontendPlayingState -> List GameObjectTypes.RelicData -> Html.Html FrontendMsg
renderTooltip state relics =
    --let
    --    offsetX =
    --        String.fromInt (List.head relics |> Maybe.withDefault { x = 0, y = 0 } |> .x * renderOffsetMultiplier)
    --
    --    offsetY =
    --        String.fromInt (List.head relics |> Maybe.withDefault { x = 0, y = 0 } |> .y * renderOffsetMultiplier + 15)
    --in
    Html.div [ class "absolute invisible z-50 group-hover:visible opacity-0 group-hover:opacity-100 transition", style "left" "0px", style "top" "10px" ]
        (List.map (renderRelicTooltipBody state.myId) relics)


renderRelicTooltipBody : PersonId -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
renderRelicTooltipBody myId relicData =
    let
        cardTitle =
            [ Html.div [ class "flex justify-between w-full" ]
                [ Html.text (Relic.relicName relicData.relicType) ]
            ]
    in
    card cardTitle
        [ relicRarityBadge relicData.rarity
        , Html.div
            [ class "flex flex-col justify-between" ]
            (Relic.relicBody myId relicData)
        ]


relicRarityBadge : GameObjectTypes.RelicRarity -> Html msg
relicRarityBadge rarity =
    Html.div
        [ class ("badge dark:text-black " ++ Relic.relicBgColor rarity) ]
        [ Html.text (Relic.relicRarityName rarity) ]


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
    Html.div [ class "absolute sprite person", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        []


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


floorRelicView : PersonId -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
floorRelicView myId relicData =
    case relicData.position of
        GameObjectTypes.HeldBy _ ->
            text ""

        GameObjectTypes.OnFloor x y ->
            let
                offsetX =
                    String.fromInt (x * renderOffsetMultiplier)

                offsetY =
                    String.fromInt (y * renderOffsetMultiplier + 15)
            in
            Html.div [ class "relative group" ]
                [ Html.div [ class ("absolute " ++ Relic.relicTextColor relicData.rarity), style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
                    [ Html.text "aaaaa" ]
                , span
                    [ class "absolute invisible group-hover:visible opacity-0 group-hover:opacity-100 transition bg-gray-800 text-white text-xs rounded py-1 px-2 top-0"
                    , style "left" (offsetX ++ "px")
                    , style "top" (offsetY ++ "px")
                    ]
                    [ heldRelicView
                        myId
                        relicData
                    ]
                ]


heldRelicView : PersonId -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
heldRelicView myId relicData =
    let
        cardTitle =
            [ Html.div [ class "flex justify-between w-full" ]
                [ Html.text (Relic.relicName relicData.relicType), dropButton relicData.id myId ]
            ]
    in
    card cardTitle
        [ Html.div
            [ class ("badge dark:text-black " ++ Relic.relicBgColor relicData.rarity) ]
            [ Html.text (Relic.relicRarityName relicData.rarity) ]
        , Html.div
            [ class "flex flex-col justify-between" ]
            (Relic.relicBody myId relicData)
        ]


dropButton : GameObjectTypes.RelicId -> PersonId -> Html FrontendMsg
dropButton relicId myId =
    Html.button
        [ Html.Events.onClick (PerformAction (DropRelic relicId myId))
        , class "btn btn-sm btn-outline btn-square"
        , id "drop-button"
        ]
        [ Outlined.file_download 18 Coloring.Inherit ]


card : List (Html.Html FrontendMsg) -> List (Html.Html FrontendMsg) -> Html.Html FrontendMsg
card title content =
    Html.div [ class "card card-compact bg-base-300 shadow-xl w-52 h-52" ]
        [ Html.div
            [ class "card-body" ]
            (Html.h2 [ class "card-title" ] title
                :: content
            )
        ]


tryCleaning : FrontendPlayingState -> ValidFrontendModelData -> ActionOnGamestate
tryCleaning state assembledModel =
    let
        myself =
            assembledModel.me.person

        myRelicCount =
            List.length assembledModel.me.heldRelics
    in
    case GameObject.getDirtAtLocation myself.x myself.y state.dirtDict of
        Nothing ->
            case GameObject.getRelicAtLocation myself.x myself.y state.relicDict of
                Nothing ->
                    GameStateNoOp

                Just relic ->
                    if myRelicCount < GameObject.relicSlotsForLevel (Util.levelForExp myself.experience) then
                        PickUpRelic relic.id myself.id

                    else
                        GameStateNoOp

        Just dirt ->
            Clean myself.id dirt.id
