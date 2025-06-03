port module Frontend exposing (..)

import BaseUI as UI
import Duration
import Effect.Browser.Dom
import Effect.Browser.Events exposing (onKeyDown)
import Effect.Browser.Navigation
import Effect.Command as Command exposing (Command, FrontendOnly)
import Effect.Lamdera
import Effect.Subscription as Subscription exposing (Subscription)
import Effect.Task
import Effect.Time
import GameObjectIds exposing (..)
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), DirtData, PersonData)
import GameStateManipulation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as Decode
import Lamdera
import MapRenderer
import Material.Icons.Outlined as Outlined
import Material.Icons.Types as Coloring
import Modals
import PointUtil
import RelicUtil
import SeqDict
import Types exposing (..)
import Url
import Util


type alias Model =
    FrontendModel


app =
    Effect.Lamdera.frontend
        Lamdera.sendToBackend
        app_


app_ =
    { init = init
    , onUrlRequest = UrlClicked
    , onUrlChange = UrlChanged
    , update = update
    , updateFromBackend = updateFromBackend
    , subscriptions = subscriptions
    , view = view
    }


port receiveElementSize : (Decode.Value -> msg) -> Sub msg


subscriptions : Model -> Subscription FrontendOnly FrontendMsg
subscriptions model =
    Subscription.batch
        -- TODO: move key listening to the `main-map` element
        [ Effect.Browser.Events.onKeyDown (keyDecoder model)
        , maybeFireEveryTick model
        , Subscription.fromJs "receiveElementSize"
            receiveElementSize
            (\value ->
                case Decode.decodeValue mapSizeDecoder value of
                    Ok size ->
                        ReceivedMapSize size

                    Err _ ->
                        NoOpFrontendMsg
            )
        ]


mapSizeDecoder : Decode.Decoder { width : Float, height : Float }
mapSizeDecoder =
    Decode.map2 (\w h -> { width = w, height = h })
        (Decode.field "width" Decode.float)
        (Decode.field "height" Decode.float)


maybeFireEveryTick : Model -> Subscription FrontendOnly FrontendMsg
maybeFireEveryTick model =
    case model.state of
        Playing playingState ->
            case playingState.targetPosition of
                Just _ ->
                    Effect.Time.every (Duration.milliseconds 50) Tick

                Nothing ->
                    Subscription.none

        _ ->
            Subscription.none


keyDecoder : Model -> Decode.Decoder FrontendMsg
keyDecoder model =
    Decode.map (msgFromKey model) (Decode.field "key" Decode.string)


msgFromKey : Model -> String -> FrontendMsg
msgFromKey model str =
    case model.state of
        Loading ->
            NoOpFrontendMsg

        Error _ ->
            NoOpFrontendMsg

        Playing playingState ->
            handleKey playingState str


handleKey : FrontendPlayingState -> String -> FrontendMsg
handleKey state key =
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
            if state.showingDebugStuff then
                DebugGenerateRelic

            else
                NoOpFrontendMsg

        " " ->
            PerformAction (tryCleaning state)

        "`" ->
            ToggleDebugStuff

        "Escape" ->
            CloseModals

        _ ->
            NoOpFrontendMsg


init : Url.Url -> Effect.Browser.Navigation.Key -> ( Model, Command restriction toMsg FrontendMsg )
init _ key =
    ( { key = key
      , state = Loading
      }
    , Command.none
    )


update : FrontendMsg -> Model -> ( Model, Command FrontendOnly ToBackend FrontendMsg )
update msg model =
    case msg of
        NoOpFrontendMsg ->
            ( model, Command.none )

        UrlClicked _ ->
            -- unhandled for now (may eventually use for stuff like "join my park" links, or logging in)
            ( model, Command.none )

        UrlChanged _ ->
            -- also unhandled
            ( model, Command.none )

        PerformAction action ->
            let
                -- Necessary otherwise the next "space" keypress will activate buttons unexpectedly
                refocus =
                    Effect.Task.attempt (\_ -> NoOpFrontendMsg) (Effect.Browser.Dom.focus (Effect.Browser.Dom.id "main-map"))

                newModel =
                    model
                        -- if the player hits any key, cancel moving to the clicked target
                        |> modelUpdateTarget Nothing
                        |> updateModelWithActionFromMyself action
            in
            ( newModel, Command.batch [ Effect.Lamdera.sendToBackend (ClientPerformsAction action), refocus ] )

        ActivatedRelic myId relicId ->
            -- todo: set "loading" state, since this is a backend-authoritative action and it could take time
            ( model, Effect.Lamdera.sendToBackend (PleaseActivateRelic myId relicId) )

        ClickedPleaseMakeMeDirty ->
            ( model, Effect.Lamdera.sendToBackend PleaseMakeMeDirty )

        DebugGenerateRelic ->
            ( model, Effect.Lamdera.sendToBackend PleaseGenerateRelic )

        NukeBackend ->
            ( model, Effect.Lamdera.sendToBackend PleaseNukeBackend )

        Tick _ ->
            moveMeTowardsMyTargetIfAny model

        ClickTarget point ->
            ( modelUpdateTarget (Just point) model, Command.none )

        ToggleDebugStuff ->
            ( modelUpdateIfPlaying toggleDebugStuff model, Command.none )

        CloseModals ->
            ( modelUpdateIfPlaying closeModals model, Command.none )

        ToggleMobileRelicMenu ->
            ( modelUpdateIfPlaying toggleMobileRelicMenu model, Command.none )

        ReceivedMapSize size ->
            ( modelUpdateIfPlaying (\state -> { state | mapSize = Just size } |> updateCameraPosition) model, Command.none )

        UpdateDebugDirtParamsMsg params ->
            ( model
            , Effect.Lamdera.sendToBackend (UpdateDebugDirtParams params)
            )


toggleDebugStuff : FrontendPlayingState -> FrontendPlayingState
toggleDebugStuff state =
    { state | showingDebugStuff = not state.showingDebugStuff }


closeModals : FrontendPlayingState -> FrontendPlayingState
closeModals state =
    { state | showingDebugStuff = False, mobileRelicMenuOpen = False }


toggleMobileRelicMenu : FrontendPlayingState -> FrontendPlayingState
toggleMobileRelicMenu state =
    { state | mobileRelicMenuOpen = not state.mobileRelicMenuOpen }


modelUpdateIfPlaying : (FrontendPlayingState -> FrontendPlayingState) -> Model -> Model
modelUpdateIfPlaying f model =
    case model.state of
        Playing state ->
            { model | state = Playing (f state) }

        _ ->
            model


modelUpdateTarget : Maybe GameObjectTypes.Point -> Model -> Model
modelUpdateTarget maybePoint model =
    case model.state of
        Playing state ->
            { model | state = Playing { state | targetPosition = maybePoint } }

        _ ->
            model


moveMeTowardsMyTargetIfAny : Model -> ( Model, Command FrontendOnly ToBackend FrontendMsg )
moveMeTowardsMyTargetIfAny model =
    case model.state of
        Playing state ->
            case state.targetPosition of
                Nothing ->
                    ( model, Command.none )

                Just _ ->
                    let
                        ( newState, cmd ) =
                            moveMeTowardsTargetPoint state
                    in
                    ( { model | state = Playing newState }, cmd )

        _ ->
            ( model, Command.none )


moveMeTowardsTargetPoint : FrontendPlayingState -> ( FrontendPlayingState, Command FrontendOnly ToBackend FrontendMsg )
moveMeTowardsTargetPoint state =
    case ( state.targetPosition, SeqDict.get state.myId state.backendConfirmedGameState.personDict ) of
        ( Just target, Just me ) ->
            let
                direction =
                    PointUtil.directionToMoveFrom me.position target
            in
            case direction of
                Just dir ->
                    let
                        ( newState, action ) =
                            ( updateStateWithAction (Client state.myId) (MovePerson state.myId dir) state
                            , Effect.Lamdera.sendToBackend (ClientPerformsAction (MovePerson state.myId dir))
                            )
                    in
                    ( newState, action )

                Nothing ->
                    -- we're already at the target
                    ( { state | targetPosition = Nothing }, Command.none )

        _ ->
            ( state, Command.none )


updateModelWithActionFromMyself : ActionOnGamestate -> Model -> Model
updateModelWithActionFromMyself actionOnGamestate model =
    case model.state of
        Playing playingState ->
            updateModelWithAction (Client playingState.myId) actionOnGamestate model

        _ ->
            model


updateModelWithAction : ActionPerformer -> ActionOnGamestate -> Model -> Model
updateModelWithAction who actionOnGamestate model =
    case model.state of
        Playing playState ->
            { model | state = Playing (updateStateWithAction who actionOnGamestate playState) }

        Loading ->
            -- TODO: action came down when the app was still loading. We assume this can't happen – it
            --   would mean that the state will be desynced which is bad. Need to add an "error report"
            --   for this that will alert me if this happens on a client.
            model

        Error _ ->
            -- TODO: action came down when the app was in an error state. handle this?
            model


updateStateWithAction : ActionPerformer -> ActionOnGamestate -> FrontendPlayingState -> FrontendPlayingState
updateStateWithAction who action prevState =
    -- UP NEXT: Instead of modifying the state here, add to the list of "optimistic actions".
    let
        ( newState, _ ) =
            GameStateManipulation.executeActionOnGameState who action prevState.backendConfirmedGameState
    in
    { prevState | backendConfirmedGameState = newState }
        |> updateCameraPosition


updateCameraPosition : FrontendPlayingState -> FrontendPlayingState
updateCameraPosition state =
    let
        maybeMe =
            extractMyself state
    in
    case ( maybeMe, state.mapSize ) of
        ( Just me, Just mapSizePixels ) ->
            updateCameraPositionWithPlayer state me mapSizePixels

        _ ->
            state


updateCameraPositionWithPlayer : FrontendPlayingState -> PersonData -> { width : Float, height : Float } -> FrontendPlayingState
updateCameraPositionWithPlayer state me mapSizePixels =
    let
        prevCamera : GameObjectTypes.Point
        prevCamera =
            state.cameraPosition
    in
    { state
        | cameraPosition =
            Util.calculateCameraPosition
                (Util.pixelsToTiles mapSizePixels)
                prevCamera
                me.position
    }


updateFromBackend : ToFrontend -> Model -> ( Model, Command restriction toMsg FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Command.none )

        UpdateFullState stateDump ->
            let
                newState =
                    case model.state of
                        Loading ->
                            Playing (initFrontendPlayingState stateDump)

                        Error _ ->
                            -- todo: is this really what we want? I'm not sure what state "Error" really represents (we don't even have a way to reach this state at the moment)
                            Playing (initFrontendPlayingState stateDump)

                        Playing playingState ->
                            Playing (updatePlayingStateWithBackendStateDump stateDump playingState)
            in
            ( { model | state = newState }, Command.none )

        OtherClientPerformedAction who action ->
            ( updateModelWithAction who action model, Command.none )


updatePlayingStateWithBackendStateDump : BackendToFrontendState -> FrontendPlayingState -> FrontendPlayingState
updatePlayingStateWithBackendStateDump stateDump state =
    { state
        | backendConfirmedGameState = stateDump.gameState
        , optimisticActions = []
        , myId = stateDump.myId
        , debugDirtParams = stateDump.debugDirtParams
    }


initFrontendPlayingState : BackendToFrontendState -> FrontendPlayingState
initFrontendPlayingState { gameState, myId, debugDirtParams } =
    { backendConfirmedGameState = gameState
    , myId = myId
    , optimisticActions = []
    , targetPosition = Nothing
    , showingDebugStuff = False
    , mapSize = Nothing
    , cameraPosition = { x = 0, y = 0 }
    , mobileRelicMenuOpen = False
    , debugDirtParams = debugDirtParams
    }
        |> updateCameraPosition


view : Model -> { title : String, body : List (Html FrontendMsg) }
view model =
    { title = "mmaintain"
    , body =
        [ Html.node "link" [ rel "stylesheet", href "/output.css" ] []
        , Html.node "meta" [ name "viewport", attribute "content" "width=device-width" ] []
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


extractMyself : FrontendPlayingState -> Maybe PersonData
extractMyself state =
    SeqDict.get state.myId state.backendConfirmedGameState.personDict


renderPlayingState : FrontendPlayingState -> Html.Html FrontendMsg
renderPlayingState state =
    case extractMyself state of
        Just me ->
            renderPlayingStateWithMe state me

        Nothing ->
            Html.text ("I couldn't find YOU in the dictionary of players. Your ID is " ++ personIdToString state.myId)


renderPlayingStateWithMe : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderPlayingStateWithMe state me =
    Html.div [ class "h-full" ]
        [ Modals.render state me
        , Html.div
            [ class
                ("grid h-full justify-end "
                    -- mobile layout: 3 rows (HUD, map, on-this-square)
                    ++ "grid-rows-[200px_1fr_150px] grid-cols-1 "
                    -- desktop layout: 2 rows (map takes up 2 columns), and a fixed Relics sidebar (takes up 2 rows)
                    ++ "md:grid-rows-[1fr_200px] md:grid-cols-[1fr_1fr_300px] "
                )
            ]
            [ renderMap state me
            , renderHeldRelics state me
            , renderMyHUD state me
            , renderOnThisSquare state me
            ]
        ]


renderMyHUD : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMyHUD state me =
    Html.div [ class "flex flex-col items-center bg-base-100 mx-3 h-64 order-1 md:order-none md:h-full" ]
        [ renderXP me
        , renderExpProgress me
        , renderCleanStrength state me
        , renderXPMultiplier state me
        , renderMobileRelicsButton state me
        ]


renderMap : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMap state me =
    MapRenderer.render state me


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
    let
        progress =
            round (Util.levelProgress person.experience)
    in
    UI.progressBar progress


renderCleanStrength : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderCleanStrength state me =
    let
        strength =
            GameStateManipulation.cleanStrengthForPlayer state.backendConfirmedGameState me
    in
    Html.div [ class "w-full prose" ]
        [ Html.h3 [ class "text-center" ]
            [ Html.text ("Clean Strength: " ++ String.fromInt strength) ]
        ]


renderExpProgress : PersonData -> Html.Html FrontendMsg
renderExpProgress me =
    let
        myLevel =
            Util.levelForExp me.experience

        myExp =
            me.experience

        myNextLevelExp : Int
        myNextLevelExp =
            Util.expForLevel (myLevel + 1)
    in
    Html.h3 [ class "text-center" ]
        [ Html.text (String.fromInt myExp ++ "/" ++ String.fromInt myNextLevelExp ++ " xp") ]


renderXPMultiplier : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderXPMultiplier state me =
    let
        xpMultiplier =
            GameStateManipulation.xpMultiplierForPlayer state.backendConfirmedGameState me
    in
    if xpMultiplier == 1 then
        Html.text ""

    else
        Html.div [ class "w-full prose" ]
            [ Html.h3 [ class "text-center" ]
                [ Html.text ("XP Multiplier: " ++ String.fromFloat xpMultiplier) ]
            ]


renderRelicContent : FrontendPlayingState -> PersonData -> List (Html.Html FrontendMsg)
renderRelicContent state me =
    let
        myRelics =
            GameStateManipulation.getRelicsHeldByPlayer state.myId state.backendConfirmedGameState
                |> SeqDict.values
    in
    [ Html.div [ class "prose mt-8" ]
        [ Html.h2 [ class "text-center" ]
            [ Html.text "My Relics:" ]
        ]
    , Html.div [ class "flex flex-col gap-2 flex-grow flex-wrap p-2 not-prose", id "relic-list" ]
        (renderRelicList
            myRelics
            state
            me
            ++ renderRelicSlots me (List.length myRelics)
        )
    ]


renderMobileRelicsButton : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMobileRelicsButton state me =
    let
        numHeldRelics =
            GameStateManipulation.getRelicsHeldByPlayer state.myId state.backendConfirmedGameState
                |> SeqDict.size
                |> String.fromInt

        myLevel =
            Util.levelForExp me.experience

        totalUnlockedSlots =
            RelicUtil.relicSlotsForLevel myLevel |> String.fromInt
    in
    Html.button
        [ class "btn btn-outline btn-ghost md:hidden fixed top-4 right-4 z-50"
        , Html.Events.onClick ToggleMobileRelicMenu
        ]
        [ "Relics: " ++ numHeldRelics ++ "/" ++ totalUnlockedSlots |> Html.text ]


renderMobileRelicDialog : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMobileRelicDialog state me =
    if state.mobileRelicMenuOpen then
        UI.basicDialog
            (Html.div
                [ class "flex flex-col h-full" ]
                [ Html.div [ class "flex-grow overflow-y-auto" ]
                    (renderRelicContent state me)
                , button
                    [ class "btn btn-primary w-full"
                    , Html.Events.onClick ToggleMobileRelicMenu
                    ]
                    [ text "Close" ]
                ]
            )

    else
        text ""


renderDesktopRelicSidebar : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderDesktopRelicSidebar state me =
    Html.div [ class "w-full flex flex-col overflow-scroll order-4 md:order-none hidden md:block row-span-2" ]
        (renderRelicContent state me)


renderHeldRelics : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderHeldRelics state me =
    Html.div [ class "order-4 md:order-none md:row-span-2 md:overflow-y-auto" ]
        [ renderMobileRelicDialog state me
        , renderDesktopRelicSidebar state me
        ]


renderEmptySquareWithNearestDirt : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderEmptySquareWithNearestDirt state me =
    case GameStateManipulation.findSmallestAndLargestNearbyDirts me.position state.backendConfirmedGameState of
        Just ( lowDirt, highDirt ) ->
            Html.div [ class "prose" ]
                [ Html.h2 [ class "text-center" ]
                    [ Html.text "No dirt or relics here!" ]
                , moveToDirtButtons lowDirt highDirt
                ]

        Nothing ->
            Html.div [ class "prose" ]
                [ Html.h2 [ class "text-center" ]
                    [ Html.text "No dirt nearby!" ]
                ]


moveToDirtButtons : DirtData -> DirtData -> Html.Html FrontendMsg
moveToDirtButtons lowDirt highDirt =
    Html.div [ class "flex flex-col justify-center px-8" ]
        (if lowDirt.id == highDirt.id then
            [ singleMoveToDirtButton lowDirt ]

         else
            [ singleMoveToDirtButton lowDirt, singleMoveToDirtButton highDirt ]
        )


singleMoveToDirtButton : DirtData -> Html.Html FrontendMsg
singleMoveToDirtButton dirt =
    Html.button
        [ class "btn btn-primary w-full"
        , Html.Events.onClick (ClickTarget dirt.position)
        ]
        [ text ("Go to dirt with " ++ String.fromInt dirt.amount ++ " left") ]


renderRelicsOnSquare : FrontendPlayingState -> PersonData -> List GameObjectTypes.RelicData -> Html.Html FrontendMsg
renderRelicsOnSquare state me relics =
    relics
        |> List.map (heldRelicView state me)
        |> Html.div [ class "flex flex-col gap-2 flex-grow flex-wrap p-2" ]


renderOnThisSquare : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderOnThisSquare state me =
    Html.div [ class "order-3 md:order-none touch-manipulation overflow-y-scroll" ]
        [ case SeqDict.get me.position state.backendConfirmedGameState.dirtByLocation of
            Just dirt ->
                renderDirtOnThisSquare me dirt

            Nothing ->
                case GameStateManipulation.relicsAtLocation me.position state.backendConfirmedGameState of
                    [] ->
                        renderEmptySquareWithNearestDirt state me

                    relics ->
                        renderRelicsOnSquare state me relics
        ]


renderDirtOnThisSquare : PersonData -> DirtData -> Html.Html FrontendMsg
renderDirtOnThisSquare me dirt =
    Html.div [ class "prose" ]
        [ Html.h2 [ class "text-center" ]
            [ Html.text ("Dirt here! Amount left: " ++ String.fromInt dirt.amount) ]
        , Html.div [ class "flex justify-center px-8" ]
            [ Html.button
                [ class "btn btn-primary w-full"
                , Html.Events.onClick (PerformAction (Clean me.id dirt.position))
                ]
                [ text "Clean it!" ]
            ]
        ]


renderRelicList : List GameObjectTypes.RelicData -> FrontendPlayingState -> PersonData -> List (Html.Html FrontendMsg)
renderRelicList list state me =
    List.map (heldRelicView state me) list


renderRelicSlots : PersonData -> Int -> List (Html.Html FrontendMsg)
renderRelicSlots person currentNumRelics =
    let
        myLevel =
            Util.levelForExp person.experience

        totalUnlockedSlots =
            RelicUtil.relicSlotsForLevel myLevel

        numAvailableSlots =
            totalUnlockedSlots - currentNumRelics

        lockedSlots =
            RelicUtil.lockedRelicSlots myLevel
    in
    List.repeat numAvailableSlots availableRelicView ++ List.map lockedSlotView lockedSlots


availableRelicView : Html.Html FrontendMsg
availableRelicView =
    UI.card ""
        [ Html.div [ class "text-center" ] [ Html.text "Free Slot" ] ]
        []


lockedSlotView : Int -> Html.Html FrontendMsg
lockedSlotView lockedUntil =
    UI.card ""
        [ Outlined.lock 16 Coloring.Inherit, Html.text "Locked" ]
        [ Html.div
            [ class "" ]
            [ Html.text ("Until level " ++ String.fromInt lockedUntil) ]
        ]


relicRarityBadge : GameObjectTypes.RelicRarity -> Html msg
relicRarityBadge rarity =
    Html.div
        [ class ("badge dark:text-black " ++ RelicUtil.relicBgColor rarity) ]
        [ Html.text (RelicUtil.relicRarityName rarity) ]


relicLevelProgressBar : GameObjectTypes.RelicData -> Html.Html msg
relicLevelProgressBar relic =
    let
        progressPercent =
            RelicUtil.relicLevelProgress relic.rarity relic.exp

        currentLevel =
            RelicUtil.relicLevelForExp relic.rarity relic.exp
    in
    if currentLevel >= 5 then
        -- No progress bar if max level
        Html.text "Max Level"

    else
        Html.div [ class "w-full flex flex-col items-center" ]
            [ Html.text ("Level " ++ String.fromInt currentLevel ++ "/5")
            , UI.progressBar (round progressPercent)
            ]


heldRelicView : FrontendPlayingState -> PersonData -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
heldRelicView state me relicData =
    UI.card ""
        [ relicCardTitle state me relicData ]
        [ relicRarityBadge relicData.rarity
        , relicLevelProgressBar relicData
        , Html.div
            [ class "flex flex-col justify-between" ]
            (GameStateManipulation.relicBody state relicData me)
        ]


relicCardTitle : FrontendPlayingState -> PersonData -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
relicCardTitle state me relicData =
    let
        isHeldByMe =
            GameStateManipulation.isRelicHeldByPerson state.backendConfirmedGameState relicData.id me.id
    in
    Html.div [ class "flex justify-between items-center w-full" ]
        [ Html.span []
            [ Html.text (RelicUtil.relicName relicData.relicType)
            ]
        , if isHeldByMe then
            dropButton relicData.id state.myId

          else
            pickUpButton relicData.id state.myId
        ]


dropButton : RelicId -> PersonId -> Html FrontendMsg
dropButton relicId myId =
    Html.button
        [ Html.Events.onClick (PerformAction (DropRelic relicId myId))
        , class "btn btn-sm btn-outline"
        , id "drop-button"
        ]
        [ Html.text "Drop" ]


pickUpButton : RelicId -> PersonId -> Html FrontendMsg
pickUpButton relicId myId =
    Html.button
        [ Html.Events.onClick (PerformAction (PickUpRelic relicId myId))
        , class "btn btn-sm btn-outline btn-square"
        , id "pickup-button"
        ]
        [ Html.img [ src "hand-pick-up.png", class "w-8 h-8 dark:invert" ] [] ]


tryCleaning : FrontendPlayingState -> ActionOnGamestate
tryCleaning state =
    let
        maybeMe =
            extractMyself state
    in
    case maybeMe of
        Nothing ->
            GameStateNoOp

        Just me ->
            performClean me state


performClean : PersonData -> FrontendPlayingState -> ActionOnGamestate
performClean me state =
    -- TODO: You'll be back here when we implement "no dropping relics on dirt". Hello future me!
    case SeqDict.get me.position state.backendConfirmedGameState.dirtByLocation of
        Nothing ->
            case GameStateManipulation.getRarestRelicAtLocation me.position state.backendConfirmedGameState of
                Nothing ->
                    GameStateNoOp

                Just relic ->
                    PickUpRelic relic.id me.id

        Just dirt ->
            Clean me.id dirt.position
