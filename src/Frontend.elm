module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Dom
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import Dict
import Dict.Extra
import DirtDict
import GameObject
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), PersonData, PersonId, relicIdToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as Decode
import Lamdera
import Material.Icons.Outlined as Outlined
import Material.Icons.Types as Coloring
import PersonDict
import Relic
import RelicDict
import Task
import Time
import Types exposing (..)
import Url
import Util


type alias Model =
    FrontendModel


type alias ValidFrontendModelData =
    { relicsByPerson : PersonDict.PersonDict Types.PersonWithRelics }


type AssembledFrontendModel
    = ValidFrontendModel ValidFrontendModelData
    | InvalidFrontendModel String


assembleFrontendModel : FrontendPlayingState -> AssembledFrontendModel
assembleFrontendModel state =
    case assembleRelicsByPerson state of
        Err message ->
            InvalidFrontendModel message

        Ok relicsByPerson ->
            ValidFrontendModel { relicsByPerson = relicsByPerson }


type alias AssembleRelicsByPersonStep =
    Result String (PersonDict.PersonDict PersonWithRelics)


assembleRelicsByPerson : FrontendPlayingState -> Result String (PersonDict.PersonDict PersonWithRelics)
assembleRelicsByPerson state =
    state.gameState.relicDict
        |> RelicDict.values
        |> List.foldl (tryUpdatingRelicHolderDict state.gameState.personDict) (Ok (emptyRelicsByPerson state))


emptyRelicsByPerson : FrontendPlayingState -> PersonDict.PersonDict PersonWithRelics
emptyRelicsByPerson state =
    state.gameState.personDict
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

        GameObjectTypes.OnFloor _ ->
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
        , Time.every 50 Tick
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
                    PerformAction (MovePerson state.me.person.id Up)

                "s" ->
                    PerformAction (MovePerson state.me.person.id Down)

                "a" ->
                    PerformAction (MovePerson state.me.person.id Left)

                "d" ->
                    PerformAction (MovePerson state.me.person.id Right)

                "ArrowUp" ->
                    PerformAction (MovePerson state.me.person.id Up)

                "ArrowDown" ->
                    PerformAction (MovePerson state.me.person.id Down)

                "ArrowLeft" ->
                    PerformAction (MovePerson state.me.person.id Left)

                "ArrowRight" ->
                    PerformAction (MovePerson state.me.person.id Right)

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

        UrlClicked _ ->
            -- unhandled for now (may eventually use for stuff like "join my park" links, or logging in)
            ( model, Cmd.none )

        UrlChanged _ ->
            -- also unhandled
            ( model, Cmd.none )

        PerformAction action ->
            let
                -- Necessary otherwise the next "space" keypress will activate buttons unexpectedly
                refocus =
                    Task.attempt (\_ -> NoOpFrontendMsg) (Browser.Dom.focus "main-map")

                newModel =
                    model
                        |> modelUpdateTarget Nothing
                        |> updateModelWithAction action
            in
            ( newModel, Cmd.batch [ Lamdera.sendToBackend (ClientPerformsAction action), refocus ] )

        ActivatedRelic myId relicId ->
            -- todo: set "loading" state, since this is a backend-authoritative action and it could take time
            ( model, Lamdera.sendToBackend (PleaseActivateRelic myId relicId) )

        ClickedPleaseMakeMeDirty ->
            ( model, Lamdera.sendToBackend PleaseMakeMeDirty )

        DebugGenerateRelic ->
            ( model, Lamdera.sendToBackend PleaseGenerateRelic )

        Tick _ ->
            moveMeTowardsMyTargetIfAny model

        ClickTarget point ->
            ( modelUpdateTarget (Just point) model, Cmd.none )


modelUpdateTarget : Maybe GameObjectTypes.Point -> Model -> Model
modelUpdateTarget maybePoint model =
    case model.state of
        Playing state ->
            { model | state = Playing { state | targetPosition = maybePoint } }

        _ ->
            model


moveMeTowardsMyTargetIfAny : Model -> ( Model, Cmd FrontendMsg )
moveMeTowardsMyTargetIfAny model =
    case model.state of
        Playing state ->
            case state.targetPosition of
                Nothing ->
                    ( model, Cmd.none )

                Just _ ->
                    let
                        ( newState, cmd ) =
                            moveMeTowardsTargetPoint state
                    in
                    ( { model | state = Playing newState }, cmd )

        _ ->
            ( model, Cmd.none )


moveMeTowardsTargetPoint : FrontendPlayingState -> ( FrontendPlayingState, Cmd FrontendMsg )
moveMeTowardsTargetPoint state =
    case ( state.targetPosition, PersonDict.get state.me.person.id state.gameState.personDict ) of
        ( Just target, Just me ) ->
            let
                direction =
                    GameObject.directionToMoveFrom me.position target

                maybeAction =
                    Maybe.map (MovePerson state.me.person.id) direction

                ( newState, action ) =
                    case maybeAction of
                        Just a ->
                            ( updateStateWithAction a state, Lamdera.sendToBackend (ClientPerformsAction a) )

                        Nothing ->
                            ( state, Cmd.none )
            in
            ( newState, action )

        _ ->
            ( state, Cmd.none )


updateModelWithAction : ActionOnGamestate -> Model -> Model
updateModelWithAction actionOnGamestate model =
    case model.state of
        Playing playState ->
            { model | state = Playing (updateStateWithAction actionOnGamestate playState) }

        Loading ->
            -- TODO: action came down when the app was still loading. We assume this can't happen – it
            --   would mean that the state will be desynced which is bad. Need to add an "error report"
            --   for this that will alert me if this happens on a client.
            model

        Error _ ->
            -- TODO: action came down when the app was in an error state. handle this?
            model


updateStateWithAction : ActionOnGamestate -> FrontendPlayingState -> FrontendPlayingState
updateStateWithAction action prevState =
    let
        ( newState, _ ) =
            GameObject.executeActionOnGameState action prevState.gameState
    in
    { prevState | gameState = newState }


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        UpdateFullState frontendState ->
            ( { model | state = Playing frontendState }, Cmd.none )

        OtherClientPerformedAction _ action ->
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


renderModals : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderModals state model =
    if DirtDict.size state.gameState.dirtDict == 0 then
        node "modal-dialog"
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
                , img [ src "yeah.gif", class "w-full" ] []
                , p
                    [ class "py-4"
                    ]
                    [ text
                        ("Congratulations, the park is clean! You did this many clean actions: "
                            ++ String.fromInt state.me.person.stats.cleanCount
                            ++ " and you finished off this many pollution patches: "
                            ++ String.fromInt state.me.person.stats.clearCount
                        )
                    ]
                , div
                    [ class "modal-action"
                    ]
                    [ Html.form
                        [ method "dialog"
                        ]
                        [ {- if there is a button in a form, it will close the modal -}
                          button
                            [ class "btn btn-primary"
                            , Html.Events.onClick
                                ClickedPleaseMakeMeDirty
                            ]
                            [ text "I'M NOT DONE, ADD MORE DIRT!" ]
                        , button
                            [ class "btn btn-primary"
                            ]
                            [ text "example button" ]
                        ]
                    ]
                ]
            ]

    else
        text ""


renderMyHUD : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderMyHUD state assembledModel =
    Html.div [ class "flex flex-col items-center h-full bg-base-100 mx-3" ]
        [ renderXP state.me.person
        , renderExpProgress assembledModel
        , renderCleanStrength state assembledModel
        , renderXPMultiplier state assembledModel
        , renderHeldRelics state assembledModel
        ]


debugStuff : FrontendPlayingState -> Html.Html FrontendMsg
debugStuff state =
    Html.div [ class "flex flex-col absolute" ]
        [ debugDicts state
        , Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary" ] [ text "Add Dirt" ]
        ]


debugDicts : FrontendPlayingState -> Html.Html FrontendMsg
debugDicts { gameState, me } =
    Html.text
        ("PersonDict: "
            ++ String.fromInt (PersonDict.size gameState.personDict)
            ++ "\nRelicDict: "
            ++ String.fromInt (RelicDict.size gameState.relicDict)
            ++ "\nDirtDict: "
            ++ String.fromInt (DirtDict.size gameState.dirtDict)
            ++ "\nMyId: "
            ++ GameObjectTypes.personIdToString me.person.id
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
    DirtDict.values state.gameState.dirtDict
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
            GameObject.cleanStrengthForPlayer state.gameState.relicDict state.me.person
    in
    Html.div [ class "w-full prose" ]
        [ Html.h3 [ class "text-center" ]
            [ Html.text ("Clean Strength: " ++ String.fromInt strength) ]
        ]


renderExpProgress : ValidFrontendModelData -> Html.Html FrontendMsg
renderExpProgress model =
    let
        myLevel =
            Util.levelForExp model.me.person.experience

        myExp =
            model.me.person.experience

        myNextLevelExp : Int
        myNextLevelExp =
            Util.expForLevel (myLevel + 1)
    in
    Html.h3 [ class "text-center" ]
        [ Html.text (String.fromInt myExp ++ "/" ++ String.fromInt myNextLevelExp ++ " xp") ]


renderXPMultiplier : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderXPMultiplier state modelData =
    let
        xpMultiplier =
            Relic.xpMultiplierForPlayer state.gameState.relicDict state.me.person
    in
    if xpMultiplier == 1 then
        Html.text ""

    else
        Html.div [ class "w-full prose" ]
            [ Html.h3 [ class "text-center" ]
                [ Html.text ("XP Multiplier: " ++ String.fromFloat xpMultiplier) ]
            ]


renderHeldRelics : FrontendPlayingState -> ValidFrontendModelData -> Html.Html FrontendMsg
renderHeldRelics state model =
    Html.div [ class "w-full flex flex-col flex-gro" ]
        [ Html.div [ class "prose mt-8" ]
            [ Html.h2 [ class "text-center" ]
                [ Html.text "My Relics:" ]
            ]
        , Html.div [ class "flex flex-col gap-2 flex-grow flex-wrap h-[660px] p-2", id "relic-list" ]
            (renderRelicList
                state.me.heldRelics
                state
                ++ renderRelicSlots state.me
            )
        ]


renderRelicList : List GameObjectTypes.RelicData -> FrontendPlayingState -> List (Html.Html FrontendMsg)
renderRelicList list state =
    List.map (heldRelicView state) list


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
    card "h-52"
        [ Html.div [ class "text-center" ] [ Html.text "Free Slot" ] ]
        []


lockedSlotView : Int -> Html.Html FrontendMsg
lockedSlotView lockedUntil =
    card "h-52"
        [ Outlined.lock 16 Coloring.Inherit, Html.text "Locked" ]
        [ Html.div
            [ class "" ]
            [ Html.text ("Until level " ++ String.fromInt lockedUntil) ]
        ]


renderFloorRelics : FrontendPlayingState -> List (Html FrontendMsg)
renderFloorRelics state =
    RelicDict.values state.gameState.relicDict
        |> List.map floorRelicView


renderTooltipLayer : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderTooltipLayer state =
    -- Group relics by location
    RelicDict.values state.gameState.relicDict
        |> Dict.Extra.filterGroupBy
            (\relicData ->
                case relicData.position of
                    GameObjectTypes.OnFloor point ->
                        Just ( point.x, point.y )

                    GameObjectTypes.HeldBy _ ->
                        Nothing
            )
        |> Dict.toList
        |> List.map (renderRelicTooltip state)


tooltipClasses =
    "absolute invisible z-50 group-hover:visible opacity-0 group-hover:opacity-100 transition"


renderRelicTooltip : FrontendPlayingState -> ( ( Int, Int ), List GameObjectTypes.RelicData ) -> Html.Html FrontendMsg
renderRelicTooltip state ( ( x, y ), relics ) =
    let
        offsetX =
            String.fromInt (x * renderOffsetMultiplier)

        offsetY =
            String.fromInt (y * renderOffsetMultiplier + 15)
    in
    Html.div [ class "absolute", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.div [ class "relative group" ]
            [ -- Empty space 32px by 32px for mouse event
              Html.div
                [ class "absolute w-8 h-8"
                , style "left" "0px"
                , style "top" "0px"
                , Html.Events.onClick (ClickTarget { x = x, y = y })
                ]
                []
            , Html.div
                [ class (tooltipClasses ++ " flex flex-col")
                , style "left" "50px"
                , style "top" "0px"
                ]
                (List.map (renderRelicTooltipBody state) relics)
            ]
        ]


renderRelicTooltipBody : FrontendPlayingState -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
renderRelicTooltipBody state relicData =
    let
        cardTitle =
            [ Html.div [ class "flex justify-between w-full" ]
                [ Html.text (Relic.relicName relicData.relicType) ]
            ]
    in
    card "h-auto"
        cardTitle
        [ relicRarityBadge relicData.rarity
        , Html.div
            [ class "flex flex-col justify-between" ]
            (Relic.relicBody state relicData)
        ]


relicRarityBadge : GameObjectTypes.RelicRarity -> Html msg
relicRarityBadge rarity =
    Html.div
        [ class ("badge dark:text-black " ++ Relic.relicBgColor rarity) ]
        [ Html.text (Relic.relicRarityName rarity) ]


renderPeople : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderPeople state =
    PersonDict.values state.gameState.personDict
        |> List.map personView


renderOffsetMultiplier =
    50


personView : PersonData -> Html.Html FrontendMsg
personView { id, name, position } =
    let
        offsetX =
            String.fromInt (position.x * renderOffsetMultiplier)

        offsetY =
            String.fromInt (position.y * renderOffsetMultiplier)
    in
    Html.div [ class "absolute sprite person", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        []


dirtView : GameObjectTypes.DirtData -> Html.Html FrontendMsg
dirtView { position, amount } =
    let
        offsetX =
            String.fromInt (position.x * renderOffsetMultiplier)

        offsetY =
            String.fromInt (position.y * renderOffsetMultiplier + 15)
    in
    Html.div [ class "absolute text-orange-500", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.text (String.fromInt amount) ]


floorRelicView : GameObjectTypes.RelicData -> Html.Html FrontendMsg
floorRelicView relicData =
    case relicData.position of
        GameObjectTypes.HeldBy _ ->
            text ""

        GameObjectTypes.OnFloor position ->
            let
                offsetX =
                    String.fromInt (position.x * renderOffsetMultiplier)

                offsetY =
                    String.fromInt (position.y * renderOffsetMultiplier + 15)
            in
            Html.div
                [ class ("absolute " ++ Relic.relicTextColor relicData.rarity)
                , style "left" (offsetX ++ "px")
                , style "top" (offsetY ++ "px")
                ]
                [ Html.text "o" ]


heldRelicView : FrontendPlayingState -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
heldRelicView state relicData =
    let
        cardTitle =
            [ Html.div [ class "flex justify-between w-full" ]
                [ Html.text (Relic.relicName relicData.relicType), dropButton relicData.id state.me.person.id ]
            ]
    in
    card "h-52"
        cardTitle
        [ Html.div
            [ class ("badge dark:text-black " ++ Relic.relicBgColor relicData.rarity) ]
            [ Html.text (Relic.relicRarityName relicData.rarity) ]
        , Html.div
            [ class "flex flex-col justify-between" ]
            (Relic.relicBody state relicData)
        ]


dropButton : GameObjectTypes.RelicId -> PersonId -> Html FrontendMsg
dropButton relicId myId =
    Html.button
        [ Html.Events.onClick (PerformAction (DropRelic relicId myId))
        , class "btn btn-sm btn-outline btn-square"
        , id "drop-button"
        ]
        [ Outlined.file_download 18 Coloring.Inherit ]


card : String -> List (Html.Html FrontendMsg) -> List (Html.Html FrontendMsg) -> Html.Html FrontendMsg
card extraClasses title content =
    Html.div [ class ("card card-compact bg-base-300 shadow-xl w-52 " ++ extraClasses) ]
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
    case GameObject.getDirtAtLocation myself.position state.gameState.dirtDict of
        Nothing ->
            case GameObject.getRelicAtLocation myself.position state.gameState.relicDict of
                Nothing ->
                    GameStateNoOp

                Just relic ->
                    if myRelicCount < GameObject.relicSlotsForLevel (Util.levelForExp myself.experience) then
                        PickUpRelic relic.id myself.id

                    else
                        GameStateNoOp

        Just dirt ->
            Clean myself.id dirt.id
