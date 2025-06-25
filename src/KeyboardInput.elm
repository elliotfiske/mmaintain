module KeyboardInput exposing (keyDecoder)

import Effect.Time
import GameObjectIds
import GameObjectTypes exposing (..)
import GameStateManipulation
import Json.Decode as Decode
import SeqDict
import Types exposing (..)


keyDecoder : FrontendPlayingState -> Decode.Decoder FrontendMsg
keyDecoder state =
    Decode.map (msgFromKey state) (Decode.field "key" Decode.string)


msgFromKey : FrontendPlayingState -> String -> FrontendMsg
msgFromKey state str =
    handleKey state str


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


tryCleaning : FrontendPlayingState -> FrontendMsg
tryCleaning state =
    case getDisplayStatePersonData state.myId state of
        Nothing ->
            NoOpFrontendMsg

        Just me ->
            tryCleaningWithMe me state


getDisplayStatePersonData : GameObjectIds.PersonId -> FrontendPlayingState -> Maybe PersonData
getDisplayStatePersonData personId state =
    SeqDict.get personId (computeDisplayState state).personDict


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


getDisplayStateDirtByLocation : GameObjectTypes.Point -> FrontendPlayingState -> Maybe DirtData
getDisplayStateDirtByLocation position state =
    SeqDict.get position (computeDisplayState state).dirtByLocation


getDisplayStateRarestRelicAtLocation : GameObjectTypes.Point -> FrontendPlayingState -> Maybe GameObjectTypes.RelicData
getDisplayStateRarestRelicAtLocation position state =
    GameStateManipulation.getRarestRelicAtLocation position (computeDisplayState state)


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