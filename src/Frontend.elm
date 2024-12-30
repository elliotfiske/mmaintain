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
        , maybeFireEveryTick model
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
            DebugGenerateRelic

        " " ->
            PerformAction (tryCleaning state)

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


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        UpdateFullState frontendState ->
            ( { model | state = Playing frontendState }, Cmd.none )

        OtherClientPerformedAction who action ->
            ( updateModelWithAction who action model, Cmd.none )


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
    case PersonDict.get state.myId state.gameState.personDict of
        Just myself ->
            Just myself

        Nothing ->
            Nothing


renderPlayingState : FrontendPlayingState -> Html.Html FrontendMsg
renderPlayingState state =
    case extractMyself state of
        Just me ->
            Html.div [ class "h-full" ]
                [ debugStuff state
                , renderModals state me
                , Html.div [ class "flex justify-end h-full" ]
                    [ renderMap state
                    , renderMyHUD state me
                    ]
                ]

        Nothing ->
            Html.text ("I couldn't find YOU in the dictionary of players. Your ID is " ++ GameObjectTypes.personIdToString state.myId)


renderModals : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderModals state me =
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
                            ++ String.fromInt me.stats.cleanCount
                            ++ " and you finished off this many pollution patches: "
                            ++ String.fromInt me.stats.clearCount
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


renderMyHUD : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderMyHUD state me =
    Html.div [ class "flex flex-col items-center h-full bg-base-100 mx-3" ]
        [ renderXP me
        , renderExpProgress me
        , renderCleanStrength state me
        , renderXPMultiplier state me
        , renderHeldRelics state me
        ]


debugStuff : FrontendPlayingState -> Html.Html FrontendMsg
debugStuff state =
    Html.div [ class "flex flex-col absolute" ]
        [ debugDicts state
        , Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary" ] [ text "Add Dirt" ]
        ]


debugDicts : FrontendPlayingState -> Html.Html FrontendMsg
debugDicts { gameState, myId } =
    Html.text
        ("PersonDict: "
            ++ String.fromInt (PersonDict.size gameState.personDict)
            ++ "\nRelics By Position Dict: "
            ++ String.fromInt (Dict.size gameState.relicsByPosition)
            ++ "\nDirtDict: "
            ++ String.fromInt (DirtDict.size gameState.dirtDict)
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


renderHeldRelics : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
renderHeldRelics state me =
    let
        myRelics =
            Relic.getRelicsHeldByPlayer state.myId state.gameState
                |> RelicDict.values
    in
    Html.div [ class "w-full flex flex-col flex-gro" ]
        [ Html.div [ class "prose mt-8" ]
            [ Html.h2 [ class "text-center" ]
                [ Html.text "My Relics:" ]
            ]
        , Html.div [ class "flex flex-col gap-2 flex-grow flex-wrap h-[660px] p-2", id "relic-list" ]
            (renderRelicList
                myRelics
                state
                ++ renderRelicSlots me (List.length myRelics)
            )
        ]


renderRelicList : List GameObjectTypes.RelicData -> FrontendPlayingState -> List (Html.Html FrontendMsg)
renderRelicList list state =
    List.map (heldRelicView state) list


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
    List.map floorRelicView (rarestRelicAtPoints state)


renderTooltipLayer : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderTooltipLayer state =
    relicsOnFloor state
        |> List.map (renderRelicTooltip state)


tooltipClasses =
    "absolute invisible z-50 group-hover:visible opacity-0 group-hover:opacity-100 transition"


renderRelicTooltip : FrontendPlayingState -> ( GameObjectTypes.Point, List GameObjectTypes.RelicData ) -> Html.Html FrontendMsg
renderRelicTooltip state ( { x, y }, relics ) =
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


floorRelicView : ( GameObjectTypes.Point, GameObjectTypes.RelicData ) -> Html.Html FrontendMsg
floorRelicView ( floorPosition, relicData ) =
    let
        offsetX =
            String.fromInt (floorPosition.x * renderOffsetMultiplier)

        offsetY =
            String.fromInt (floorPosition.y * renderOffsetMultiplier + 15)
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
                [ Html.text (Relic.relicName relicData.relicType), dropButton relicData.id state.myId ]
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
