module GameObject exposing (..)

import BackendTriggerUtil
import Dict
import GameObjectTypes exposing (..)
import GameState
import PersonDict exposing (PersonDict)
import Relic exposing (..)
import RelicDict
import Types exposing (BackendTrigger(..), GameState, RealRelicDict)
import Util


movePerson : Direction -> PersonData -> PersonData
movePerson direction person =
    let
        destination =
            newPoint direction person.position

        tooLow =
            destination.y < Util.yOrigin || destination.x < Util.xOrigin

        tooHigh =
            destination.y >= Util.mapYMax || destination.x >= Util.mapXMax
    in
    if tooLow || tooHigh then
        -- out of bounds, don't complete the move
        person

    else
        { person | position = newPoint direction person.position }


newPoint : Direction -> GameObjectTypes.Point -> GameObjectTypes.Point
newPoint direction point =
    case direction of
        Up ->
            { point | y = point.y - 1 }

        Down ->
            { point | y = point.y + 1 }

        Left ->
            { point | x = point.x - 1 }

        Right ->
            { point | x = point.x + 1 }

        UpLeft ->
            { point | x = point.x - 1, y = point.y - 1 }

        UpRight ->
            { point | x = point.x + 1, y = point.y - 1 }

        DownLeft ->
            { point | x = point.x - 1, y = point.y + 1 }

        DownRight ->
            { point | x = point.x + 1, y = point.y + 1 }


type DirectionDifferenceVertical
    = Above
    | Below
    | SameY


type DirectionDifferenceHorizontal
    = LeftOf
    | RightOf
    | SameX


directionToMoveFrom : Point -> Point -> Maybe Direction
directionToMoveFrom from to =
    let
        yDiff =
            if from.y > to.y then
                Above

            else if from.y < to.y then
                Below

            else
                SameY

        xDiff =
            if from.x > to.x then
                LeftOf

            else if from.x < to.x then
                RightOf

            else
                SameX
    in
    case ( xDiff, yDiff ) of
        ( LeftOf, SameY ) ->
            Just Left

        ( RightOf, SameY ) ->
            Just Right

        ( SameX, Above ) ->
            Just Up

        ( SameX, Below ) ->
            Just Down

        ( LeftOf, Above ) ->
            Just UpLeft

        ( RightOf, Above ) ->
            Just UpRight

        ( LeftOf, Below ) ->
            Just DownLeft

        ( RightOf, Below ) ->
            Just DownRight

        ( SameX, SameY ) ->
            Nothing


pickUpRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
pickUpRelic takerId relicId state =
    let
        maybeTaker =
            PersonDict.get takerId state.personDict

        existingRelicsOnGround =
            maybeTaker
                |> Maybe.map (\taker -> getRelicsAtFloorPoint taker.position state)
                |> Maybe.withDefault RelicDict.empty

        maybeTargetRelic =
            RelicDict.get relicId existingRelicsOnGround
    in
    case ( maybeTaker, maybeTargetRelic ) of
        ( Just taker, Just targetRelic ) ->
            let
                newState =
                    moveRelicFromFloorToPlayer taker targetRelic existingRelicsOnGround state
            in
            ( newState, NoOpBackendTrigger )

        _ ->
            ( state, NuhUh takerId )


moveRelicFromFloorToPlayer : PersonData -> RelicData -> RealRelicDict -> GameState -> GameState
moveRelicFromFloorToPlayer taker relicData floorDictToRemoveFrom state =
    let
        newFloorRelicDict =
            RelicDict.remove relicData.id floorDictToRemoveFrom

        existingHeldRelics =
            Dict.get (Relic.playerHolderToLocation taker.id) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty

        newHeldRelics =
            RelicDict.insert relicData.id relicData existingHeldRelics

        newRelicsByPosition =
            state.relicsByPosition
                |> Dict.insert (Relic.playerHolderToLocation taker.id) newHeldRelics
                |> Dict.insert (Relic.floorPointToLocation taker.position) newFloorRelicDict
    in
    { state | relicsByPosition = newRelicsByPosition }


dropRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
dropRelic dropperId relicId state =
    let
        maybeDropper =
            PersonDict.get dropperId state.personDict

        existingRelicsHeldByPlayer =
            Relic.getRelicsHeldByPlayer dropperId state

        maybeRelicBeingDropped =
            RelicDict.get relicId existingRelicsHeldByPlayer
    in
    case ( maybeDropper, maybeRelicBeingDropped ) of
        ( Just dropper, Just relic ) ->
            let
                newState =
                    moveRelicFromPlayerToFloor dropper relic existingRelicsHeldByPlayer state
            in
            ( newState, NoOpBackendTrigger )

        _ ->
            ( state, NuhUh dropperId )


moveRelicFromPlayerToFloor : PersonData -> RelicData -> RealRelicDict -> GameState -> GameState
moveRelicFromPlayerToFloor dropper relicData heldDictToRemoveFrom state =
    let
        newHeldRelicDict =
            RelicDict.remove relicData.id heldDictToRemoveFrom

        existingFloorRelics =
            Dict.get (Relic.floorPointToLocation dropper.position) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty

        newFloorRelics =
            RelicDict.insert relicData.id relicData existingFloorRelics

        newRelicsByPosition =
            state.relicsByPosition
                |> Dict.insert (Relic.playerHolderToLocation dropper.id) newHeldRelicDict
                |> Dict.insert (Relic.floorPointToLocation dropper.position) newFloorRelics
    in
    { state | relicsByPosition = newRelicsByPosition }


createPerson : PersonId -> String -> PersonData
createPerson id name =
    { id = id
    , name = name
    , experience = 0
    , position = { x = 3, y = 3 }
    , stats =
        { cleanCount = 0
        , clearCount = 0
        }
    }


movePersonWithId : PersonId -> Direction -> PersonDict PersonData -> PersonDict PersonData
movePersonWithId id direction dict =
    PersonDict.update id (Maybe.map (movePerson direction)) dict


setDirtAmount : Int -> DirtData -> DirtData
setDirtAmount amount dirt =
    { dirt | amount = amount }


changeDirtAmount : Types.DirtLocation -> Int -> Types.DirtByLocation -> Types.DirtByLocation
changeDirtAmount location amount dict =
    Dict.update location (Maybe.map (setDirtAmount amount)) dict


pointToDirtLocation : GameObjectTypes.Point -> Types.DirtLocation
pointToDirtLocation point =
    ( point.x, point.y )


getDirtAtLocation : GameObjectTypes.Point -> Types.DirtByLocation -> Maybe DirtData
getDirtAtLocation point dirtByLocation =
    Dict.get (pointToDirtLocation point) dirtByLocation


updateDirtAtLocation : GameObjectTypes.Point -> DirtData -> Types.DirtByLocation -> Types.DirtByLocation
updateDirtAtLocation point dirtData dirtByLocation =
    Dict.insert (pointToDirtLocation point) dirtData dirtByLocation


{-| Add a new dirt or modify an existing dirt's "amount".

Currently used to spawn dirt as a "debug action", not for normal gameplay.

-}
addOrModifyDirt : DirtData -> GameState -> ( GameState, Types.BackendTrigger )
addOrModifyDirt dirtData state =
    let
        maybeExistingDirt =
            getDirtAtLocation dirtData.position state.dirtByLocation
    in
    case maybeExistingDirt of
        Nothing ->
            ( { state | dirtByLocation = updateDirtAtLocation dirtData.position dirtData state.dirtByLocation }, NoOpBackendTrigger )

        Just existingDirt ->
            let
                newDirtDict =
                    changeDirtAmount (pointToDirtLocation existingDirt.position) dirtData.amount state.dirtByLocation
            in
            ( { state | dirtByLocation = newDirtDict }, NoOpBackendTrigger )


getRarestRelicAtLocation : GameObjectTypes.Point -> GameState -> Maybe RelicData
getRarestRelicAtLocation point state =
    relicsAtLocation point state
        |> List.sortBy byRelicRarity
        |> List.head


relicsAtLocation : GameObjectTypes.Point -> GameState -> List RelicData
relicsAtLocation point state =
    Dict.get (Relic.floorPointToLocation point) state.relicsByPosition
        |> Maybe.withDefault RelicDict.empty
        |> RelicDict.values


byRelicRarity : RelicData -> Int
byRelicRarity relic =
    case relic.rarity of
        Common ->
            0

        Uncommon ->
            -1

        Rare ->
            -2

        Epic ->
            -3

        Legendary ->
            -4


updateWithRelics : Types.ActionPerformer -> ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
updateWithRelics actorId action state =
    case actorId of
        Types.Server ->
            -- Don't apply relic middleware for server actions
            BackendTriggerUtil.withNoOp state

        Types.Client personId ->
            Dict.get (Relic.playerHolderToLocation personId) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty
                |> RelicDict.values
                |> List.foldl
                    (applyRelicMiddleware action)
                    ( state, [] )
                |> Tuple.mapSecond BatchTrigger


applyRelicMiddleware : ActionOnGamestate -> RelicData -> ( GameState, List Types.BackendTrigger ) -> ( GameState, List Types.BackendTrigger )
applyRelicMiddleware action relic ( accState, accTriggers ) =
    let
        ( newState, newTrigger ) =
            Relic.relicMiddleware action relic accState
    in
    ( newState, newTrigger :: accTriggers )


relicSlotThreshholds : List Int
relicSlotThreshholds =
    [ 3, 5, 10 ]


relicSlotsForLevel : Int -> Int
relicSlotsForLevel level =
    3
        + (relicSlotThreshholds
            |> List.filter (\x -> level >= x)
            |> List.length
          )


{-| Given a level, return a list where each member is a level at which you'll unlock a new relic slot
-}
lockedRelicSlots : Int -> List Int
lockedRelicSlots level =
    relicSlotThreshholds
        |> List.filter (\x -> level < x)


incrementCleanCount : PersonId -> PersonDict PersonData -> PersonDict PersonData
incrementCleanCount personId dict =
    PersonDict.update personId (Maybe.map doIncrementCleanCount) dict


doIncrementCleanCount : PersonData -> PersonData
doIncrementCleanCount person =
    let
        stats =
            person.stats

        newStats =
            { stats | cleanCount = stats.cleanCount + 1 }
    in
    { person | stats = newStats }


addCleanStats : PersonId -> GameState -> GameState
addCleanStats personId state =
    { state | personDict = incrementCleanCount personId state.personDict }


cleanStrengthForPlayer : GameState -> PersonData -> Int
cleanStrengthForPlayer state person =
    let
        heldRelics =
            Dict.get (Relic.playerHolderToLocation person.id) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty
                |> RelicDict.values

        baseXP =
            toFloat (10 + Util.levelForExp person.experience)
    in
    heldRelics
        |> List.foldl
            (\relic acc ->
                case relic.relicType of
                    CleanFast ->
                        acc * cleanFastStrengthMultiplier relic.rarity relic.exp

                    _ ->
                        acc
            )
            baseXP
        |> round


updatePersonDictWithExperience : PersonId -> Int -> PersonDict PersonData -> PersonDict PersonData
updatePersonDictWithExperience personId totalXpEarned dict =
    PersonDict.update personId
        (Maybe.map
            (\player ->
                { player
                    | experience = player.experience + totalXpEarned
                }
            )
        )
        dict


updateRelicsByPositionWithExperience : PersonId -> Int -> Dict.Dict Types.RelicLocation RealRelicDict -> Dict.Dict Types.RelicLocation RealRelicDict
updateRelicsByPositionWithExperience personId totalXpEarned relicsByPosition =
    let
        heldRelics =
            Dict.get (Relic.playerHolderToLocation personId) relicsByPosition
                |> Maybe.withDefault RelicDict.empty

        newHeldRelics =
            heldRelics
                |> RelicDict.map
                    (\_ relic ->
                        { relic | exp = relic.exp + totalXpEarned }
                    )
    in
    Dict.insert (Relic.playerHolderToLocation personId) newHeldRelics relicsByPosition


playerEarnsExperience : PersonId -> Int -> GameState -> GameState
playerEarnsExperience personId xpEarned state =
    case PersonDict.get personId state.personDict of
        Nothing ->
            state

        Just player ->
            let
                xpMultiplier =
                    Relic.xpMultiplierForPlayer state player

                totalXpEarned =
                    round (xpMultiplier * toFloat xpEarned)

                newPersonDict =
                    updatePersonDictWithExperience personId totalXpEarned state.personDict

                newRelicsByPosition =
                    updateRelicsByPositionWithExperience personId totalXpEarned state.relicsByPosition
            in
            { state
                | personDict = newPersonDict
                , relicsByPosition = newRelicsByPosition
            }


handleActivateGenerosityTrap : PersonId -> RelicId -> Int -> GameState -> ( GameState, Types.BackendTrigger )
handleActivateGenerosityTrap personId relicId numDoubles state =
    let
        maybeRelic =
            Dict.get (Relic.playerHolderToLocation personId) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty
                |> RelicDict.get relicId

        maybeFella =
            PersonDict.get personId state.personDict
    in
    case ( maybeRelic, maybeFella ) of
        ( Just relicData, Just fella ) ->
            case relicData.relicType of
                DropAndDouble _ ->
                    BackendTriggerUtil.withNoOp (activateGenerosityTrap relicData fella numDoubles state)

                _ ->
                    -- User tried to activate Generosity on a relic that wasn't Generosity. Cheating???
                    ( state, NuhUh personId )

        _ ->
            ( state, NuhUh personId )


internalExecuteActionOnGameState : ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
internalExecuteActionOnGameState action state =
    case action of
        Clean personId location ->
            let
                maybePlayer =
                    PersonDict.get personId state.personDict

                strength =
                    case maybePlayer of
                        Nothing ->
                            1

                        -- todo: should return `state` if player is not found
                        Just player ->
                            cleanStrengthForPlayer state player
            in
            state
                |> addCleanStats personId
                |> CleanOperations.doClean personId location strength

        MovePerson personId direction ->
            BackendTriggerUtil.withNoOp { state | personDict = movePersonWithId personId direction state.personDict }

        AddPerson personData ->
            BackendTriggerUtil.withNoOp { state | personDict = PersonDict.insert personData.id personData state.personDict }

        PickUpRelic relicId personId ->
            pickUpRelic personId relicId state

        DropRelic relicId personId ->
            dropRelic personId relicId state

        AddDirt dirtData ->
            addOrModifyDirt dirtData state

        AddRelic relicData floorPoint ->
            let
                existingRelicDict =
                    Dict.get (Relic.floorPointToLocation floorPoint) state.relicsByPosition
                        |> Maybe.withDefault RelicDict.empty

                newRelicDict =
                    RelicDict.insert relicData.id relicData existingRelicDict
            in
            BackendTriggerUtil.withNoOp { state | relicsByPosition = Dict.insert (Relic.floorPointToLocation floorPoint) newRelicDict state.relicsByPosition }

        GameStateNoOp ->
            BackendTriggerUtil.withNoOp state

        ActivateGenerosityTrap personId relicId numDoubles ->
            handleActivateGenerosityTrap personId relicId numDoubles state

        BatchAction actions ->
            List.foldl
                (\batchAction ( currentState, currentTrigger ) ->
                    let
                        ( newState, newTrigger ) =
                            internalExecuteActionOnGameState batchAction currentState
                    in
                    case ( currentTrigger, newTrigger ) of
                        ( NoOpBackendTrigger, _ ) ->
                            ( newState, newTrigger )

                        ( _, NoOpBackendTrigger ) ->
                            ( newState, currentTrigger )

                        ( _, _ ) ->
                            ( newState, Types.BatchTrigger [ currentTrigger, newTrigger ] )
                )
                ( state, Types.NoOpBackendTrigger )
                actions


executeActionOnGameState : Types.ActionPerformer -> ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
executeActionOnGameState who actionOnGamestate state =
    let
        ( stateAfterRelicMiddleware, relicTrigger ) =
            updateWithRelics who actionOnGamestate state

        ( newState, actionTrigger ) =
            internalExecuteActionOnGameState actionOnGamestate stateAfterRelicMiddleware
    in
    ( newState, BatchTrigger [ relicTrigger, actionTrigger ] )


activateGenerosityTrap : RelicData -> PersonData -> Int -> GameState -> GameState
activateGenerosityTrap relicData personData numDoubles state =
    let
        relicsHeldByPlayer =
            Relic.getRelicsHeldByPlayer personData.id state

        newRelicDict =
            RelicDict.remove relicData.id relicsHeldByPlayer

        newRelicsByPosition =
            state.relicsByPosition
                |> Dict.insert (Relic.playerHolderToLocation personData.id) newRelicDict

        xpEarned =
            Relic.dropDoubleCurrentExperience relicData.rarity relicData.exp numDoubles

        newState =
            playerEarnsExperience personData.id xpEarned state
    in
    { newState | relicsByPosition = newRelicsByPosition }


doClean : PersonId -> Point -> Int -> GameState -> ( GameState, Types.BackendTrigger )
doClean personId location strength state =
    case Dict.get (pointToDirtLocation location) state.dirtByLocation of
        Nothing ->
            -- This might happen if the user is lagging and someone else cleared the dirt
            ( state, NoOpBackendTrigger )

        Just dirtData ->
            cleanDirt personId dirtData strength state


cleanDirt : PersonId -> DirtData -> Int -> GameState -> ( GameState, Types.BackendTrigger )
cleanDirt personId dirtData strength state =
    let
        newDirt =
            reduceDirtAmount strength dirtData
    in
    if newDirt.amount <= 0 then
        destroyDirt personId dirtData state

    else
        makeDirtSmaller personId newDirt state


makeDirtSmaller : PersonId -> DirtData -> GameState -> ( GameState, Types.BackendTrigger )
makeDirtSmaller personId newDirt state =
    let
        newDirtDict =
            Dict.insert (pointToDirtLocation newDirt.position) newDirt state.dirtByLocation
    in
    ( { state | dirtByLocation = newDirtDict }, NoOpBackendTrigger )


destroyDirt : PersonId -> DirtData -> GameState -> ( GameState, Types.BackendTrigger )
destroyDirt personId dirtData state =
    let
        newDirtDict =
            Dict.remove (pointToDirtLocation dirtData.position) state.dirtByLocation

        newPersonDict =
            state.personDict
                |> incrementClearCount personId
                |> playerEarnsExperience personId 10

        newState =
            state
                |> GameState.updateGameStateDirtDict newDirtDict
                |> GameState.updateGameStatePersonDict newPersonDict
    in
    ( newState, ClearedPollution personId dirtData )


pointToDirtLocation : Point -> Types.DirtLocation
pointToDirtLocation point =
    ( point.x, point.y )


reduceDirtAmount : Int -> DirtData -> DirtData
reduceDirtAmount cleanStrength dirt =
    { dirt | amount = dirt.amount - cleanStrength }


incrementClearCount : PersonId -> PersonDict PersonData -> PersonDict PersonData
incrementClearCount personId dict =
    PersonDict.update personId (Maybe.map doIncrementClearCount) dict


doIncrementClearCount : PersonData -> PersonData
doIncrementClearCount person =
    let
        stats =
            person.stats

        newStats =
            { stats | clearCount = stats.clearCount + 1 }
    in
    { person | stats = newStats }
