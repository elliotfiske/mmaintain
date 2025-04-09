port module Frontend exposing (..)

import BaseUI as UI
import Browser exposing (UrlRequest(..))
import Browser.Dom
import Browser.Events exposing (onKeyDown)
import Browser.Navigation as Nav
import Dict
import DirtDict
import GameObject
import GameObjectTypes exposing (ActionOnGamestate(..), Direction(..), DirtData, PersonData, PersonId)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as Decode
import Lamdera
import Markdown
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


port receiveElementSize : ({ width : Float, height : Float } -> msg) -> Sub msg


subscriptions : Model -> Sub FrontendMsg
subscriptions model =
    Sub.batch
        [ onKeyDown (keyDecoder model)
        , maybeFireEveryTick model
        , receiveElementSize ReceivedMapSize
        ]


maybeFireEveryTick : Model -> Sub FrontendMsg
maybeFireEveryTick model =
    case model.state of
        Playing playingState ->
            case playingState.targetPosition of
                Just _ ->
                    Time.every 50 Tick

                Nothing ->
                    Sub.none

        _ ->
            Sub.none


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

        _ ->
            NoOpFrontendMsg


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init _ key =
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
                        -- if the player hits any key, cancel moving to the clicked target
                        |> modelUpdateTarget Nothing
                        |> updateModelWithActionFromMyself action
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

        ToggleDebugStuff ->
            ( modelUpdateIfPlaying toggleDebugStuff model, Cmd.none )

        ToggleMobileRelicMenu ->
            ( modelUpdateIfPlaying toggleMobileRelicMenu model, Cmd.none )

        ReceivedMapSize size ->
            ( modelUpdateIfPlaying (\state -> { state | mapSize = Just size } |> updateCameraPosition) model, Cmd.none )


toggleDebugStuff : FrontendPlayingState -> FrontendPlayingState
toggleDebugStuff state =
    { state | showingDebugStuff = not state.showingDebugStuff }


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
    case ( state.targetPosition, PersonDict.get state.myId state.gameState.personDict ) of
        ( Just target, Just me ) ->
            let
                direction =
                    GameObject.directionToMoveFrom me.position target
            in
            case direction of
                Just dir ->
                    let
                        ( newState, action ) =
                            ( updateStateWithAction (Client state.myId) (MovePerson state.myId dir) state
                            , Lamdera.sendToBackend (ClientPerformsAction (MovePerson state.myId dir))
                            )
                    in
                    ( newState, action )

                Nothing ->
                    -- we're already at the target
                    ( { state | targetPosition = Nothing }, Cmd.none )

        _ ->
            ( state, Cmd.none )


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
    let
        ( newState, _ ) =
            GameObject.executeActionOnGameState who action prevState.gameState
    in
    { prevState | gameState = newState }
        |> updateCameraPosition


mapSizeInTiles : { width : Float, height : Float } -> GameObjectTypes.Point
mapSizeInTiles { width, height } =
    { x = truncate (width / renderOffsetMultiplier)
    , y = truncate (height / renderOffsetMultiplier)
    }


updateCameraPosition : FrontendPlayingState -> FrontendPlayingState
updateCameraPosition state =
    let
        maybeMe =
            extractMyself state
    in
    case ( maybeMe, state.mapSize ) of
        ( Just me, Just mapSizePixels ) ->
            let
                prevCamera =
                    state.cameraPosition
            in
            { state
                | cameraPosition =
                    Util.calculateCameraPosition
                        (mapSizeInTiles mapSizePixels)
                        prevCamera
                        me.position
            }

        _ ->
            state


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

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
            ( { model | state = newState }, Cmd.none )

        OtherClientPerformedAction who action ->
            ( updateModelWithAction who action model, Cmd.none )


updatePlayingStateWithBackendStateDump : BackendToFrontendState -> FrontendPlayingState -> FrontendPlayingState
updatePlayingStateWithBackendStateDump stateDump state =
    { state | gameState = stateDump.gameState, myId = stateDump.myId }


initFrontendPlayingState : BackendToFrontendState -> FrontendPlayingState
initFrontendPlayingState { gameState, myId } =
    { gameState = gameState
    , myId = myId
    , targetPosition = Nothing
    , showingDebugStuff = False
    , mapSize = Nothing
    , cameraPosition = { x = 0, y = 0 }
    , mobileRelicMenuOpen = False
    }
        |> updateCameraPosition


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


extractMyself : FrontendPlayingState -> Maybe PersonData
extractMyself state =
    PersonDict.get state.myId state.gameState.personDict


renderPlayingState : FrontendPlayingState -> Html.Html FrontendMsg
renderPlayingState state =
    case extractMyself state of
        Just me ->
            Html.div [ class "h-full" ]
                [ renderModals state me
                , Html.div
                    [ class
                        ("grid h-full justify-end "
                            -- mobile layout: 3 rows (HUD, map, on-this-square)
                            ++ "grid-rows-[200px_1fr_120px] grid-cols-1 "
                            -- desktop layout: 2 rows (map takes up 2 rows), and a fixed sidebar
                            ++ "md:grid-rows-[1fr_200px] md:grid-cols-[1fr_1fr_300px] "
                        )
                    ]
                    [ renderMap state me
                    , renderHeldRelics state me
                    , renderMyHUD state me
                    , renderOnThisSquare state me
                    ]
                ]

        Nothing ->
            Html.text ("I couldn't find YOU in the dictionary of players. Your ID is " ++ GameObjectTypes.personIdToString state.myId)


renderModals : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderModals state me =
    if state.showingDebugStuff then
        Html.div []
            [ UI.dialog
                { title = UI.simpleTitle "Debug Stuff! :)"
                , body =
                    debugStuff state
                , actions =
                    button
                        [ class "btn btn-primary"
                        , Html.Events.onClick ToggleDebugStuff
                        ]
                        [ text "Close" ]
                }
            ]

    else if DirtDict.size state.gameState.dirtDict == 0 then
        UI.dialog
            { title =
                h3
                    [ class "text-lg font-bold"
                    ]
                    [ text "THE PARK IS CLEAN!!!!" ]
            , body =
                Html.div []
                    [ img [ src "yeah.gif", class "w-full" ] []
                    , p
                        [ class "py-4" ]
                        [ text
                            ("Congratulations, the park is clean! You did this many clean actions: "
                                ++ String.fromInt me.stats.cleanCount
                                ++ " and you finished off this many pollution patches: "
                                ++ String.fromInt me.stats.clearCount
                            )
                        ]
                    ]
            , actions =
                button
                    [ class "btn btn-primary"
                    , Html.Events.onClick ClickedPleaseMakeMeDirty
                    ]
                    [ text "I'M NOT DONE, ADD MORE DIRT!" ]
            }

    else
        text ""


renderMyHUD : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMyHUD state me =
    Html.div [ class "flex flex-col items-center bg-base-100 mx-3 h-64 order-1 md:order-none md:h-full" ]
        [ renderXP me
        , renderExpProgress me
        , renderCleanStrength state me
        , renderXPMultiplier state me
        , renderMobileHamburgerButton
        ]


debugStuff : FrontendPlayingState -> Html.Html FrontendMsg
debugStuff state =
    if state.showingDebugStuff then
        Html.div [ class "flex flex-col" ]
            (Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary" ] [ text "Add Dirt" ]
                :: debugDictsView state
            )

    else
        Html.text ""


debugDictsView : FrontendPlayingState -> List (Html.Html FrontendMsg)
debugDictsView { gameState, myId } =
    Markdown.toHtml
        Nothing
        ("PersonDict: "
            ++ String.fromInt (PersonDict.size gameState.personDict)
            ++ "<br>Relics By Position Dict: "
            ++ String.fromInt (Dict.size gameState.relicsByPosition)
            ++ "<br>DirtDict: "
            ++ String.fromInt (DirtDict.size gameState.dirtDict)
            ++ "<br>MyId: "
            ++ GameObjectTypes.personIdToString myId
        )


renderMap : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMap state me =
    renderPeople state
        ++ renderDirt state
        ++ renderFloorRelics state
        ++ renderClickableLayer state
        ++ renderTooltipLayer state me
        |> Html.div [ class "order-2 md:order-none md:col-span-2 bg-green-800 relative overflow-hidden", id "main-map", tabindex 0 ]


renderDirt : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderDirt state =
    DirtDict.values state.gameState.dirtDict
        |> List.map (dirtView state.cameraPosition)


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


renderCleanStrength : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderCleanStrength state me =
    let
        strength =
            GameObject.cleanStrengthForPlayer state.gameState me
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
            Relic.xpMultiplierForPlayer state.gameState me
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
            Relic.getRelicsHeldByPlayer state.myId state.gameState
                |> RelicDict.values
    in
    [ Html.div [ class "prose mt-8" ]
        [ Html.h2 [ class "text-center" ]
            [ Html.text "My Relics:" ]
        ]
    , Html.div [ class "flex flex-col gap-2 flex-grow flex-wrap p-2", id "relic-list" ]
        (renderRelicList
            myRelics
            state
            me
            ++ renderRelicSlots me (List.length myRelics)
        )
    ]


renderMobileHamburgerButton : Html.Html FrontendMsg
renderMobileHamburgerButton =
    Html.button
        [ class "btn btn-square btn-ghost md:hidden fixed top-4 right-4 z-50"
        , Html.Events.onClick ToggleMobileRelicMenu
        ]
        [ Outlined.menu 24 Coloring.Inherit ]


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
    Html.div [ class "w-full flex flex-col overflow-scroll order-4 md:order-none hidden md:block md:row-span-2" ]
        (renderRelicContent state me)


renderHeldRelics : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderHeldRelics state me =
    Html.div [ class "order-4 md:order-none" ]
        [ renderMobileRelicDialog state me
        , renderDesktopRelicSidebar state me
        ]


renderOnThisSquare : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderOnThisSquare state me =
    Html.div [ class "order-3 md:order-none" ]
        [ case GameObject.getDirtAtLocation me.position state.gameState.dirtDict of
            Just dirt ->
                renderDirtOnThisSquare state me dirt

            Nothing ->
                GameObject.relicsAtLocation me.position state.gameState
                    |> List.map (heldRelicView state me)
                    |> Html.div [ class "flex flex-col gap-2 flex-grow flex-wrap p-2" ]
        ]


renderDirtOnThisSquare : FrontendPlayingState -> PersonData -> DirtData -> Html.Html FrontendMsg
renderDirtOnThisSquare state me dirt =
    Html.div [ class "prose" ]
        [ Html.h2 [ class "text-center" ]
            [ Html.text ("Dirty dirty dirt! " ++ String.fromInt dirt.amount) ]
        , Html.div [ class "flex justify-center px-8" ]
            [ Html.button
                [ class "btn btn-primary w-full"
                , Html.Events.onClick (PerformAction (Clean me.id dirt.id))
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
            GameObject.relicSlotsForLevel myLevel

        numAvailableSlots =
            totalUnlockedSlots - currentNumRelics

        lockedSlots =
            GameObject.lockedRelicSlots myLevel
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


relicsOnFloor : FrontendPlayingState -> List ( GameObjectTypes.Point, List GameObjectTypes.RelicData )
relicsOnFloor state =
    Dict.toList state.gameState.relicsByPosition
        |> List.filter (\( position, _ ) -> Relic.relicLocationIsOnFloor position)
        |> List.map relicLocationAndDictToFloorRelics


rarestRelicAtPoints : FrontendPlayingState -> List ( GameObjectTypes.Point, GameObjectTypes.RelicData )
rarestRelicAtPoints state =
    relicsOnFloor state
        |> List.filterMap rarestRelicAtPoint


rarestRelicAtPoint : ( GameObjectTypes.Point, List GameObjectTypes.RelicData ) -> Maybe ( GameObjectTypes.Point, GameObjectTypes.RelicData )
rarestRelicAtPoint ( point, relics ) =
    case List.sortBy GameObject.byRelicRarity relics |> List.head of
        Just relic ->
            Just ( point, relic )

        Nothing ->
            Nothing


relicLocationAndDictToFloorRelics : ( Types.RelicLocation, RealRelicDict ) -> ( GameObjectTypes.Point, List GameObjectTypes.RelicData )
relicLocationAndDictToFloorRelics ( position, relicDict ) =
    ( Relic.floorRelicLocationToFloorPoint position, RelicDict.values relicDict )


renderFloorRelics : FrontendPlayingState -> List (Html FrontendMsg)
renderFloorRelics state =
    List.map (floorRelicView state.cameraPosition) (rarestRelicAtPoints state)


renderTooltipLayer : FrontendPlayingState -> PersonData -> List (Html.Html FrontendMsg)
renderTooltipLayer state me =
    relicsOnFloor state
        |> List.map (renderRelicTooltip state me)


renderRelicTooltip : FrontendPlayingState -> PersonData -> ( GameObjectTypes.Point, List GameObjectTypes.RelicData ) -> Html.Html FrontendMsg
renderRelicTooltip state me ( relicPileLocation, relics ) =
    let
        ( offsetX, offsetY ) =
            renderedOffset relicPileLocation state.cameraPosition

        tooltipClasses =
            "absolute invisible group-hover:visible opacity-0 group-hover:opacity-100 transition"
    in
    Html.div [ class "absolute z-50", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.div [ class "relative group" ]
            [ -- Empty space 32px by 32px for mouse event
              Html.div
                [ class "absolute left-0 top-0"
                , style "width" (String.fromInt renderOffsetMultiplier ++ "px")
                , style "height" (String.fromInt renderOffsetMultiplier ++ "px")
                , Html.Events.onClick (ClickTarget relicPileLocation)
                ]
                []
            , Html.div
                [ class (tooltipClasses ++ " w-64 flex flex-col")
                , style "left" "50px"
                , style "top" "0px"
                ]
                (List.map (renderRelicTooltipBody state me) relics)
            ]
        ]


renderClickableLayer : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderClickableLayer state =
    let
        mapHeightInTiles : Int
        mapHeightInTiles =
            state.mapSize
                |> Maybe.map (mapSizeInTiles >> .y)
                |> Maybe.withDefault 0
    in
    List.range 0 mapHeightInTiles
        |> List.concatMap (renderClickableTileRow state)


renderClickableTileRow : FrontendPlayingState -> Int -> List (Html.Html FrontendMsg)
renderClickableTileRow state row =
    let
        mapWidthInTiles : Int
        mapWidthInTiles =
            state.mapSize
                |> Maybe.map (mapSizeInTiles >> .x)
                |> Maybe.withDefault 0
    in
    List.range 0 mapWidthInTiles
        |> List.map (renderClickableTile state row)


renderClickableTile : FrontendPlayingState -> Int -> Int -> Html.Html FrontendMsg
renderClickableTile state row col =
    let
        point =
            { x = col, y = row }

        offsetX =
            col * renderOffsetMultiplier |> String.fromInt

        offsetY =
            row * renderOffsetMultiplier |> String.fromInt

        worldPoint =
            Util.addPoints state.cameraPosition point
    in
    Html.div
        [ class "absolute"
        , style "left" (offsetX ++ "px")
        , style "top" (offsetY ++ "px")
        , style "width" (String.fromInt renderOffsetMultiplier ++ "px")
        , style "height" (String.fromInt renderOffsetMultiplier ++ "px")
        , Html.Events.onClick (ClickTarget worldPoint)
        ]
        []


renderRelicTooltipBody : FrontendPlayingState -> PersonData -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
renderRelicTooltipBody state me relicData =
    let
        cardTitle =
            [ Html.div [ class "flex justify-between w-full" ]
                [ Html.text (Relic.relicName relicData.relicType) ]
            ]
    in
    UI.card "h-auto"
        cardTitle
        [ relicRarityBadge relicData.rarity
        , Html.div
            [ class "flex flex-col justify-between" ]
            (Relic.relicBody state relicData me)
        ]


relicRarityBadge : GameObjectTypes.RelicRarity -> Html msg
relicRarityBadge rarity =
    Html.div
        [ class ("badge dark:text-black " ++ Relic.relicBgColor rarity) ]
        [ Html.text (Relic.relicRarityName rarity) ]


renderPeople : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderPeople state =
    PersonDict.values state.gameState.personDict
        |> List.map (personView state.cameraPosition)


{-| The width in pixels of a game tile
-}
renderOffsetMultiplier =
    50


renderedOffset : GameObjectTypes.Point -> GameObjectTypes.Point -> ( String, String )
renderedOffset objectPosition cameraOffset =
    ( (objectPosition.x - cameraOffset.x)
        * renderOffsetMultiplier
        |> String.fromInt
    , (objectPosition.y - cameraOffset.y)
        * renderOffsetMultiplier
        |> String.fromInt
    )


personView : GameObjectTypes.Point -> PersonData -> Html.Html FrontendMsg
personView camera { id, name, position } =
    let
        ( offsetX, offsetY ) =
            renderedOffset position camera
    in
    Html.div [ class "absolute sprite person z-20", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        []


dirtView : GameObjectTypes.Point -> GameObjectTypes.DirtData -> Html.Html FrontendMsg
dirtView camera { position, amount } =
    let
        ( offsetX, offsetY ) =
            renderedOffset position camera
    in
    Html.div [ class "absolute text-orange-500", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.text (String.fromInt amount) ]


floorRelicView : GameObjectTypes.Point -> ( GameObjectTypes.Point, GameObjectTypes.RelicData ) -> Html.Html FrontendMsg
floorRelicView camera ( floorPosition, relicData ) =
    let
        ( offsetX, offsetY ) =
            renderedOffset floorPosition camera
    in
    Html.div
        [ class ("absolute sprite relic z-10 " ++ Relic.relicRarityToCssClass relicData.rarity)
        , style "left" (offsetX ++ "px")
        , style "top" (offsetY ++ "px")
        ]
        [ Html.text "" ]


heldRelicView : FrontendPlayingState -> PersonData -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
heldRelicView state me relicData =
    UI.card ""
        [ relicCardTitle state me relicData ]
        [ relicRarityBadge relicData.rarity
        , Html.div
            [ class "flex flex-col justify-between" ]
            (Relic.relicBody state relicData me)
        ]


relicCardTitle : FrontendPlayingState -> PersonData -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
relicCardTitle state me relicData =
    let
        isHeldByMe =
            Relic.isRelicHeldByPerson state.gameState relicData.id me.id
    in
    Html.div [ class "flex justify-between w-full" ]
        [ Html.text (Relic.relicName relicData.relicType)
        , if isHeldByMe then
            dropButton relicData.id state.myId

          else
            pickUpButton relicData.id state.myId
        ]


dropButton : GameObjectTypes.RelicId -> PersonId -> Html FrontendMsg
dropButton relicId myId =
    Html.button
        [ Html.Events.onClick (PerformAction (DropRelic relicId myId))
        , class "btn btn-sm btn-outline btn-square"
        , id "drop-button"
        ]
        [ Outlined.file_download 18 Coloring.Inherit ]


pickUpButton : GameObjectTypes.RelicId -> PersonId -> Html FrontendMsg
pickUpButton relicId myId =
    Html.button
        [ Html.Events.onClick (PerformAction (PickUpRelic relicId myId))
        , class "btn btn-sm btn-outline btn-square"
        , id "pickup-button"
        ]
        [ Outlined.file_upload 18 Coloring.Inherit ]


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
    let
        myRelicCount =
            RelicDict.size (Relic.getRelicsHeldByPlayer state.myId state.gameState)
    in
    case GameObject.getDirtAtLocation me.position state.gameState.dirtDict of
        Nothing ->
            case GameObject.getRarestRelicAtLocation me.position state.gameState of
                Nothing ->
                    GameStateNoOp

                Just relic ->
                    if myRelicCount < GameObject.relicSlotsForLevel (Util.levelForExp me.experience) then
                        PickUpRelic relic.id me.id

                    else
                        GameStateNoOp

        Just dirt ->
            Clean me.id dirt.id
