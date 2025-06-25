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
import GameObjectTypes exposing (ActionOnGamestate(..), ActionWithMetadata, Direction(..), DirtData, PersonData)
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
import Svg
import Svg.Attributes
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
        , maybeTargetMovementTick model
        , animationTick
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


maybeTargetMovementTick : Model -> Subscription FrontendOnly FrontendMsg
maybeTargetMovementTick model =
    case model.state of
        Playing playingState ->
            case playingState.targetPosition of
                Just _ ->
                    Effect.Time.every (Duration.milliseconds 50) Tick

                Nothing ->
                    Subscription.none

        _ ->
            Subscription.none


animationTick : Subscription FrontendOnly FrontendMsg
animationTick =
    Effect.Time.every (Duration.milliseconds 20) AnimationTick


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
            tryCleaning state

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

        UrlChanged _ ->
            -- also unhandled
            ( model, Command.none )

        UrlClicked _ ->
            -- unhandled for now (may eventually use for stuff like "join my park" links, or logging in)
            ( model, Command.none )

        PerformAction action ->
            let
                -- Necessary otherwise the next "space" keypress will activate buttons unexpectedly
                refocus =
                    Effect.Task.attempt (\_ -> NoOpFrontendMsg) (Effect.Browser.Dom.focus (Effect.Browser.Dom.id "main-map"))

                ( actionWithMetadata, newModel ) =
                    case ( action, model.state ) of
                        ( Clean _ _, Playing state ) ->
                            -- Advance the random number for the next target
                            let
                                nextRandom =
                                    modBy 2301875097 (state.cleaningRandom * 348987 + 174039)

                                ( metadata, updatedState ) =
                                    addOptimisticActionAndReturnMetadata action state
                            in
                            ( metadata, { model | state = Playing { updatedState | cleaningRandom = nextRandom } } )

                        ( _, Playing state ) ->
                            let
                                ( metadata, updatedState ) =
                                    addOptimisticActionAndReturnMetadata action state

                                modelWithUpdatedState =
                                    { model | state = Playing updatedState }
                                        -- if the player hits any key, cancel moving to the clicked target
                                        |> modelUpdateTarget Nothing
                            in
                            ( metadata, modelWithUpdatedState )

                        _ ->
                            -- Non-playing states - this shouldn't happen, but handle gracefully
                            ( { action = action, performer = PersonId 0, id = GameObjectTypes.ActionId 0 }, model )
            in
            ( newModel, Command.batch [ Effect.Lamdera.sendToBackend (ClientPerformsAction actionWithMetadata), refocus ] )

        StunSelf ->
            let
                -- Necessary otherwise the next "space" keypress will activate buttons unexpectedly
                refocus =
                    Effect.Task.attempt (\_ -> NoOpFrontendMsg) (Effect.Browser.Dom.focus (Effect.Browser.Dom.id "main-map"))

                newModel =
                    case model.state of
                        Playing state ->
                            let
                                nextRandom =
                                    modBy 2301875097 (state.cleaningRandom * 348987 + 174039)

                                stunTime =
                                    Effect.Time.millisToPosix (Effect.Time.posixToMillis state.currentTime + 2000)
                            in
                            { model | state = Playing { state | cleaningRandom = nextRandom, stunnedUntil = stunTime } }

                        _ ->
                            model
            in
            ( newModel, refocus )

        ClickedPleaseMakeMeDirty ->
            ( model, Effect.Lamdera.sendToBackend PleaseMakeMeDirty )

        DebugGenerateRelic ->
            ( model, Effect.Lamdera.sendToBackend PleaseGenerateRelic )

        NukeBackend ->
            ( model, Effect.Lamdera.sendToBackend PleaseNukeBackend )

        Tick _ ->
            moveMeTowardsMyTargetIfAny model

        AnimationTick currTime ->
            ( modelUpdateIfPlaying (\state -> { state | currentTime = currTime }) model, Command.none )

        ClickTarget point ->
            ( modelUpdateTarget (Just point) model, Command.none )

        ToggleDebugStuff ->
            ( modelUpdateIfPlaying toggleDebugStuff model, Command.none )

        CloseModals ->
            ( modelUpdateIfPlaying closeModals model, Command.none )

        ToggleMobileRelicMenu ->
            ( modelUpdateIfPlaying toggleMobileRelicMenu model, Command.none )

        ToggleSkillTreeMenu ->
            let
                updatedModel =
                    modelUpdateIfPlaying toggleSkillTreeMenu model

                -- Scroll to center of the skill tree
                scrollCommand =
                    Effect.Task.attempt (\_ -> NoOpFrontendMsg)
                        (scrollElementToCenter
                            "skill-tree-svg-container"
                            "skill-tree-svg"
                            0.5
                            -- outerXPos (center)
                            0.5
                            -- innerXPos (center)
                            0.5
                            -- outerYPos (center)
                            0.5
                         -- innerYPos (center)
                        )
            in
            ( updatedModel, scrollCommand )

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
    { state | showingDebugStuff = False, mobileRelicMenuOpen = False, skillTreeMenuOpen = False }


toggleMobileRelicMenu : FrontendPlayingState -> FrontendPlayingState
toggleMobileRelicMenu state =
    { state | mobileRelicMenuOpen = not state.mobileRelicMenuOpen }


scrollElementToCenter : String -> String -> Float -> Float -> Float -> Float -> Effect.Task.Task FrontendOnly Effect.Browser.Dom.Error ()
scrollElementToCenter outerId innerId outerXPos innerXPos outerYPos innerYPos =
    Effect.Task.map3
        (\outerVp outerE innerE ->
            Effect.Browser.Dom.setViewportOf (Effect.Browser.Dom.id outerId)
                (outerVp.viewport.x
                    + innerE.element.x
                    + innerXPos
                    * innerE.element.width
                    - outerE.element.x
                    - outerXPos
                    * outerVp.viewport.width
                    |> round
                    |> toFloat
                )
                (outerVp.viewport.y
                    + innerE.element.y
                    + innerYPos
                    * innerE.element.height
                    - outerE.element.y
                    - outerYPos
                    * outerVp.viewport.height
                    |> round
                    |> toFloat
                )
        )
        (Effect.Browser.Dom.getViewportOf (Effect.Browser.Dom.id outerId))
        (Effect.Browser.Dom.getElement (Effect.Browser.Dom.id outerId))
        (Effect.Browser.Dom.getElement (Effect.Browser.Dom.id innerId))
        |> Effect.Task.andThen identity


toggleSkillTreeMenu : FrontendPlayingState -> FrontendPlayingState
toggleSkillTreeMenu state =
    { state | skillTreeMenuOpen = not state.skillTreeMenuOpen }


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
    case ( state.targetPosition, getDisplayStatePersonData state.myId state ) of
        ( Just target, Just me ) ->
            let
                direction =
                    PointUtil.directionToMoveFrom me.position target
            in
            case direction of
                Just dir ->
                    let
                        moveAction =
                            MovePerson state.myId dir

                        ( actionWithMetadata, newState ) =
                            addOptimisticActionAndReturnMetadata moveAction state

                        backendCommand =
                            Effect.Lamdera.sendToBackend (ClientPerformsAction actionWithMetadata)
                    in
                    ( newState, backendCommand )

                Nothing ->
                    -- we're already at the target
                    ( { state | targetPosition = Nothing }, Command.none )

        _ ->
            ( state, Command.none )


updateModelWithActionFromMyself : ActionOnGamestate -> Model -> Model
updateModelWithActionFromMyself actionOnGamestate model =
    case model.state of
        Playing playingState ->
            { model | state = Playing (addOptimisticAction actionOnGamestate playingState) }

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
            -- note we currently have no way to reach the Error state.
            model


createActionWithId : ActionOnGamestate -> FrontendPlayingState -> ( ActionWithMetadata, FrontendPlayingState )
createActionWithId action state =
    let
        actionWithMetadata =
            { action = action
            , performer = state.myId
            , id = GameObjectTypes.ActionId state.nextActionId
            }

        updatedState =
            { state | nextActionId = state.nextActionId + 1 }
    in
    ( actionWithMetadata, updatedState )


addOptimisticAction : ActionOnGamestate -> FrontendPlayingState -> FrontendPlayingState
addOptimisticAction action state =
    let
        ( actionWithMetadata, updatedState ) =
            createActionWithId action state
    in
    { updatedState | optimisticActions = updatedState.optimisticActions ++ [ actionWithMetadata ] }
        |> updateCameraPosition


addOptimisticActionAndReturnMetadata : ActionOnGamestate -> FrontendPlayingState -> ( ActionWithMetadata, FrontendPlayingState )
addOptimisticActionAndReturnMetadata action state =
    let
        ( actionWithMetadata, updatedState ) =
            createActionWithId action state

        finalState =
            { updatedState | optimisticActions = updatedState.optimisticActions ++ [ actionWithMetadata ] }
                |> updateCameraPosition
    in
    ( actionWithMetadata, finalState )


computeDisplayState : FrontendPlayingState -> GameState
computeDisplayState state =
    List.foldl
        (\actionWithMetadata currentState ->
            let
                ( newState, _ ) =
                    GameStateManipulation.executeActionOnGameState
                        (Client actionWithMetadata.performer)
                        actionWithMetadata.action
                        currentState
            in
            newState
        )
        state.backendConfirmedGameState
        state.optimisticActions


getDisplayStatePersonData : PersonId -> FrontendPlayingState -> Maybe PersonData
getDisplayStatePersonData personId state =
    SeqDict.get personId (computeDisplayState state).personDict


getDisplayStateCleanStrength : FrontendPlayingState -> PersonData -> Int
getDisplayStateCleanStrength state person =
    GameStateManipulation.cleanStrengthForPlayer (computeDisplayState state) person


getDisplayStateXpMultiplier : FrontendPlayingState -> PersonData -> Float
getDisplayStateXpMultiplier state person =
    GameStateManipulation.xpMultiplierForPlayer (computeDisplayState state) person


getDisplayStateRelicsHeldByPlayer : PersonId -> FrontendPlayingState -> RelicsById
getDisplayStateRelicsHeldByPlayer personId state =
    GameStateManipulation.getRelicsHeldByPlayer personId (computeDisplayState state)


getDisplayStateFindSmallestAndLargestNearbyDirts : GameObjectTypes.Point -> FrontendPlayingState -> Maybe ( DirtData, DirtData )
getDisplayStateFindSmallestAndLargestNearbyDirts position state =
    GameStateManipulation.findSmallestAndLargestNearbyDirts position (computeDisplayState state)


getDisplayStateDirtByLocation : GameObjectTypes.Point -> FrontendPlayingState -> Maybe DirtData
getDisplayStateDirtByLocation position state =
    SeqDict.get position (computeDisplayState state).dirtByLocation


getDisplayStateRelicsAtLocation : GameObjectTypes.Point -> FrontendPlayingState -> List GameObjectTypes.RelicData
getDisplayStateRelicsAtLocation position state =
    GameStateManipulation.relicsAtLocation position (computeDisplayState state)


getDisplayStateRarestRelicAtLocation : GameObjectTypes.Point -> FrontendPlayingState -> Maybe GameObjectTypes.RelicData
getDisplayStateRarestRelicAtLocation position state =
    GameStateManipulation.getRarestRelicAtLocation position (computeDisplayState state)


getDisplayStateIsRelicHeldByPerson : RelicId -> PersonId -> FrontendPlayingState -> Bool
getDisplayStateIsRelicHeldByPerson relicId personId state =
    GameStateManipulation.isRelicHeldByPerson (computeDisplayState state) relicId personId


{-| Helper function for MapRenderer to get the computed display state.
This is the main entry point for MapRenderer to access the optimistic state.
-}
getDisplayStateForMapRenderer : FrontendPlayingState -> GameState
getDisplayStateForMapRenderer state =
    computeDisplayState state


removeConfirmedActionFromOptimisticList : ActionWithMetadata -> FrontendPlayingState -> FrontendPlayingState
removeConfirmedActionFromOptimisticList confirmedAction state =
    let
        updatedOptimisticActions =
            -- Remove the action from the optimistic list. We only remove the action if it's the same performer and id.
            List.filter
                (\actionWithMetadata ->
                    actionWithMetadata.id
                        /= confirmedAction.id
                        && actionWithMetadata.performer
                        == confirmedAction.performer
                )
                state.optimisticActions

        -- If we removed an optimistic action, update the camera position since
        -- the computed display state may have changed
        stateWithUpdatedActions =
            { state | optimisticActions = updatedOptimisticActions }
    in
    if List.length updatedOptimisticActions /= List.length state.optimisticActions then
        -- We removed an action, update camera position
        updateCameraPosition stateWithUpdatedActions

    else
        -- No action was removed (this ActionId wasn't in our optimistic list,
        -- probably from another player), so no need to update camera
        stateWithUpdatedActions


updateStateWithAction : ActionPerformer -> ActionOnGamestate -> FrontendPlayingState -> FrontendPlayingState
updateStateWithAction who action prevState =
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

        ServerAction who action ->
            ( updateModelWithAction who action model, Command.none )

        ActionConfirmed actionWithMetadata ->
            case model.state of
                Playing playingState ->
                    let
                        -- First, update the backend confirmed state with the confirmed action
                        stateWithConfirmedAction =
                            updateStateWithAction (Client actionWithMetadata.performer) actionWithMetadata.action playingState

                        -- Then, remove the action from optimistic list if it's there
                        finalState =
                            removeConfirmedActionFromOptimisticList actionWithMetadata stateWithConfirmedAction
                    in
                    ( { model | state = Playing finalState }, Command.none )

                _ ->
                    ( model, Command.none )


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
    let
        initialState : FrontendPlayingState
        initialState =
            { backendConfirmedGameState = gameState
            , myId = myId
            , optimisticActions = []
            , targetPosition = Nothing
            , showingDebugStuff = False
            , mapSize = Nothing
            , cameraPosition = { x = 0, y = 0 }
            , mobileRelicMenuOpen = False
            , skillTreeMenuOpen = False
            , debugDirtParams = debugDirtParams
            , currentTime = Effect.Time.millisToPosix 0
            , cleaningRandom = 42
            , stunnedUntil = Effect.Time.millisToPosix 0
            , nextActionId = 1
            }
    in
    initialState
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
    getDisplayStatePersonData state.myId state


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
                    -- desktop layout: 2 rows (map takes up 2 columns), and a fixed Relics sidebar
                    ++ "md:grid-rows-[1fr_200px] md:grid-cols-[1fr_1fr_300px] "
                )
            ]
            [ renderMap state me
            , renderHeldRelics state me
            , renderMyHUD state me
            , renderOnThisSquare state me
            , renderSkillTree state me
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
        , renderOpenSkillTreeButton state me
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
            getDisplayStateCleanStrength state me

        highFiveText =
            case me.bestHighFiveBoost of
                Nothing ->
                    Html.text ""

                Just boost ->
                    Html.h3 [ class "text-center text-base-content/70" ]
                        [ Html.text ("High Five Boost: +" ++ String.fromInt boost.boost) ]
    in
    Html.div [ class "w-full prose" ]
        [ Html.h3 [ class "text-center" ]
            [ Html.text ("Clean Strength: " ++ String.fromInt strength) ]
        , highFiveText
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
            getDisplayStateXpMultiplier state me
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
            getDisplayStateRelicsHeldByPlayer state.myId state
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


renderSkillTreeContainer : FrontendPlayingState -> PersonData -> List (Html.Html FrontendMsg)
renderSkillTreeContainer state me =
    [ Html.div [ class "prose mt-8" ]
        [ Html.h2 [ class "text-center" ]
            [ Html.text "Skill Tree:" ]
        ]
    , Html.div [ class "flex flex-col gap-4 p-4 not-prose" ]
        [ Html.div [ class "text-center" ]
            [ Html.text ("Current Level: " ++ String.fromInt (Util.levelForExp me.experience)) ]
        , renderSkillTreeContent state me
        ]
    ]


renderSkillTreeContent : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderSkillTreeContent state me =
    Html.div
        [ class "w-full h-96 bg-base-100 rounded-lg border border-base-300 overflow-auto", id "skill-tree-svg-container" ]
        [ Svg.svg
            [ Svg.Attributes.viewBox "0 0 800 600"
            , Svg.Attributes.width "800"
            , Svg.Attributes.height "600"
            , Svg.Attributes.id "skill-tree-svg"
            ]
            [ -- Connection lines
              skillConnectionLine "400" "300" "400" "200" -- center to top
            , skillConnectionLine "400" "300" "250" "450" -- center to bottom-left
            , skillConnectionLine "400" "300" "550" "450" -- center to bottom-right

            -- Skill nodes
            , skillNodeSvg "400" "300" "Core" "🔥" True
            , skillNodeSvg "400" "200" "Power Strike" "⚡" False
            , skillNodeSvg "250" "450" "Shield Mastery" "🛡️" False
            , skillNodeSvg "550" "450" "Swift Cleaning" "💨" False
            ]
        ]


skillConnectionLine : String -> String -> String -> String -> Svg.Svg FrontendMsg
skillConnectionLine x1 y1 x2 y2 =
    Svg.line
        [ Svg.Attributes.x1 x1
        , Svg.Attributes.y1 y1
        , Svg.Attributes.x2 x2
        , Svg.Attributes.y2 y2
        , Svg.Attributes.stroke "#6b7280"
        , Svg.Attributes.strokeWidth "2"
        , Svg.Attributes.strokeDasharray "5,5"
        ]
        []


skillNodeSvg : String -> String -> String -> String -> Bool -> Svg.Svg FrontendMsg
skillNodeSvg x y name icon isUnlocked =
    let
        nodeRadius =
            "32"

        fillColor =
            if isUnlocked then
                "#3b82f6"
                -- Blue (primary)

            else
                "transparent"

        strokeColor =
            if isUnlocked then
                "#3b82f6"
                -- Blue

            else
                "#6b7280"

        -- Gray
        opacity =
            if isUnlocked then
                "1"

            else
                "0.6"
    in
    Svg.g []
        [ -- Node circle
          Svg.circle
            [ Svg.Attributes.cx x
            , Svg.Attributes.cy y
            , Svg.Attributes.r nodeRadius
            , Svg.Attributes.fill fillColor
            , Svg.Attributes.stroke strokeColor
            , Svg.Attributes.strokeWidth "2"
            , Svg.Attributes.opacity opacity
            , Svg.Attributes.style "cursor: pointer;"
            ]
            []

        -- Icon text
        , Svg.text_
            [ Svg.Attributes.x x
            , Svg.Attributes.y (String.fromInt (String.toInt y |> Maybe.withDefault 0 |> (+) 6))
            , Svg.Attributes.textAnchor "middle"
            , Svg.Attributes.fontSize "24"
            , Svg.Attributes.opacity opacity
            ]
            [ Svg.text icon ]

        -- Name label
        , Svg.text_
            [ Svg.Attributes.x x
            , Svg.Attributes.y (String.fromInt (String.toInt y |> Maybe.withDefault 0 |> (+) 50))
            , Svg.Attributes.textAnchor "middle"
            , Svg.Attributes.fontSize "12"
            , Svg.Attributes.fill "#374151"
            , Svg.Attributes.opacity opacity
            ]
            [ Svg.text name ]
        ]


renderMobileRelicsButton : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMobileRelicsButton state me =
    let
        numHeldRelics =
            getDisplayStateRelicsHeldByPlayer state.myId state
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


renderOpenSkillTreeButton : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderOpenSkillTreeButton state me =
    let
        myLevel =
            Util.levelForExp me.experience
    in
    Html.button
        [ class "btn btn-outline btn-ghost md:hidden fixed top-16 right-4 z-50"
        , Html.Events.onClick ToggleSkillTreeMenu
        ]
        [ "Skills: Lvl " ++ String.fromInt myLevel |> Html.text ]


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


renderMobileSkillTreeDialog : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMobileSkillTreeDialog state me =
    if state.skillTreeMenuOpen then
        UI.basicDialog
            (Html.div
                [ class "flex flex-col h-full" ]
                [ Html.div [ class "flex-grow overflow-y-auto" ]
                    (renderSkillTreeContainer state me)
                , button
                    [ class "btn btn-primary w-full"
                    , Html.Events.onClick ToggleSkillTreeMenu
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
    Html.div [ class "order-4 md:order-none md:overflow-y-auto" ]
        [ renderMobileRelicDialog state me
        , renderMobileSkillTreeDialog state me
        , renderDesktopRelicSidebar state me
        ]


renderEmptySquareWithNearestDirt : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderEmptySquareWithNearestDirt state me =
    case getDisplayStateFindSmallestAndLargestNearbyDirts me.position state of
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
        [ case getDisplayStateDirtByLocation me.position state of
            Just dirt ->
                renderDirtOnThisSquare state me dirt

            Nothing ->
                case getDisplayStateRelicsAtLocation me.position state of
                    [] ->
                        renderEmptySquareWithNearestDirt state me

                    relics ->
                        renderRelicsOnSquare state me relics
        ]


renderDirtOnThisSquare : FrontendPlayingState -> PersonData -> DirtData -> Html.Html FrontendMsg
renderDirtOnThisSquare state me dirt =
    Html.div [ class "prose" ]
        [ Html.h2 [ class "text-center" ]
            [ Html.text ("Amount left: " ++ String.fromInt dirt.amount) ]
        , Html.div [ class "flex flex-col justify-center px-8" ]
            [ renderCleaningMinigame state me dirt
            ]
        ]


calculateMarkerPosition : Effect.Time.Posix -> Float
calculateMarkerPosition currentTime =
    let
        baseOffset =
            toFloat (Effect.Time.posixToMillis currentTime) / 600 |> sin
    in
    ((baseOffset * 0.5) + 0.5) * 100


calculateTargetPosition : Int -> Float
calculateTargetPosition randomValue =
    toFloat (modBy 100 randomValue)


isInTargetZone : Float -> Float -> Bool
isInTargetZone markerPosition targetPosition =
    abs (markerPosition - targetPosition) < 10.0


isPlayerStunned : FrontendPlayingState -> Bool
isPlayerStunned state =
    Effect.Time.posixToMillis state.currentTime < Effect.Time.posixToMillis state.stunnedUntil


calculateMinigameState : FrontendPlayingState -> ( Float, Float, Bool )
calculateMinigameState state =
    let
        markerPosition =
            calculateMarkerPosition state.currentTime

        targetPosition =
            calculateTargetPosition state.cleaningRandom

        inTargetZone =
            isInTargetZone markerPosition targetPosition
    in
    ( markerPosition, targetPosition, inTargetZone )


renderCleaningMinigame : FrontendPlayingState -> PersonData -> DirtData -> Html.Html FrontendMsg
renderCleaningMinigame state me dirt =
    let
        ( markerPosition, targetPosition, inTargetZone ) =
            calculateMinigameState state

        isStunned =
            isPlayerStunned state

        targetZoneStyle =
            style "left" (String.fromFloat (targetPosition - 5.0) ++ "%")

        markerStyle =
            style "left" (String.fromFloat markerPosition ++ "%")

        buttonText =
            if isStunned then
                "Stunned!"

            else if inTargetZone then
                "Clean it!"

            else
                "Try to clean!"

        buttonClass =
            if isStunned then
                "btn btn-disabled w-full"

            else
                "btn btn-primary w-full"

        cleaningButtonAction =
            if isStunned then
                NoOpFrontendMsg

            else if inTargetZone then
                PerformAction (Clean me.id dirt.position)

            else
                StunSelf
    in
    Html.div [ class "flex flex-col gap-2" ]
        [ Html.div [ class "bg-blue-500 h-8 w-full relative" ]
            [ -- Target zone (green)
              Html.div
                [ class "absolute bg-green-500 h-8 w-[10%] opacity-50"
                , targetZoneStyle
                ]
                []

            -- Marker (red)
            , Html.div
                [ class "absolute"
                , markerStyle
                ]
                [ Html.div [ class "bg-red-500 h-8 w-2 relative", style "left" "-50%" ] [] ]
            ]
        , Html.button
            [ class buttonClass
            , Html.Events.onMouseDown cleaningButtonAction
            , Html.Events.on "touchstart" (Decode.succeed cleaningButtonAction)
            ]
            [ text buttonText ]
        ]


renderSkillTree : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderSkillTree state me =
    Html.div [ class "order-4 md:order-none md:overflow-y-auto hidden md:flex items-center justify-center w-full h-full" ]
        [ Html.button
            [ class "btn btn-outline btn-ghost"
            , Html.Events.onClick ToggleSkillTreeMenu
            ]
            [ Html.text "Skills" ]
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
        [ relicLevelProgressBar relicData
        , Html.div
            [ class "flex flex-col justify-between" ]
            (GameStateManipulation.relicBody state relicData me)
        ]


relicCardTitle : FrontendPlayingState -> PersonData -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
relicCardTitle state me relicData =
    let
        isHeldByMe =
            getDisplayStateIsRelicHeldByPerson relicData.id me.id state
    in
    Html.div [ class "flex justify-between items-center w-full" ]
        [ Html.span [ class ("dark:text-black font-semibold px-2 py-1 rounded-md " ++ RelicUtil.relicBgColor relicData.rarity) ]
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


tryCleaning : FrontendPlayingState -> FrontendMsg
tryCleaning state =
    let
        maybeMe =
            extractMyself state
    in
    case maybeMe of
        Nothing ->
            NoOpFrontendMsg

        Just me ->
            tryCleaningWithMe me state


tryCleaningWithMe : PersonData -> FrontendPlayingState -> FrontendMsg
tryCleaningWithMe me state =
    -- Don't allow cleaning if player is stunned
    if isPlayerStunned state then
        NoOpFrontendMsg

    else
        case getDisplayStateDirtByLocation me.position state of
            Nothing ->
                case getDisplayStateRarestRelicAtLocation me.position state of
                    Nothing ->
                        NoOpFrontendMsg

                    Just relic ->
                        PerformAction (PickUpRelic relic.id me.id)

            Just dirt ->
                let
                    ( _, _, inTargetZone ) =
                        calculateMinigameState state
                in
                if inTargetZone then
                    PerformAction (Clean me.id dirt.position)

                else
                    StunSelf
