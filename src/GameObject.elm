module GameObject exposing (..)

import Dict
import DirtDict
import GameObjectTypes exposing (..)
import PersonDict exposing (PersonDict)
import Relic exposing (..)
import RelicDict
import Types exposing (BackendTrigger(..), GameState, RealDirtDict, RealRelicDict)
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


cleanDirt : Int -> DirtData -> DirtData
cleanDirt cleanStrength dirt =
    { dirt | amount = dirt.amount - cleanStrength }


setDirtAmount : Int -> DirtData -> DirtData
setDirtAmount amount dirt =
    { dirt | amount = amount }


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


changeDirtAmount : Types.DirtLocation -> Int -> Types.DirtByLocation -> Types.DirtByLocation
changeDirtAmount location amount dict =
    Dict.update location (Maybe.map (setDirtAmount amount)) dict


dirtIsAtLocation : GameObjectTypes.Point -> GameObjectTypes.DirtData -> Bool
dirtIsAtLocation pos dirtData =
    pos == dirtData.position


pointToDirtLocation : GameObjectTypes.Point -> Types.DirtLocation
pointToDirtLocation point =
    ( point.x, point.y )


getDirtAtLocation : GameObjectTypes.Point -> Types.DirtByLocation -> Maybe DirtData
getDirtAtLocation point dirtByLocation =
    Dict.get (pointToDirtLocation point) dirtByLocation
        |> Maybe.map (\dirt -> dirt)


addOrModifyDirt : DirtData -> GameState -> ( GameState, Types.BackendTrigger )
addOrModifyDirt dirtData state =
    let
        maybeExistingDirt =
            getDirtAtLocation dirtData.position state.dirtByLocation
    in
    case maybeExistingDirt of
        Nothing ->
            ( { state | dirtByLocation = Dict.insert (pointToDirtLocation dirtData.position) dirtData state.dirtByLocation }, NoOpBackendTrigger )

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


updateWithRelics : Types.ActionPerformer -> ActionOnGamestate -> GameState -> GameState
updateWithRelics actorId action state =
    case actorId of
        Types.Server ->
            -- Don't apply relic middleware for server actions
            state

        Types.Client personId ->
            Dict.get (Relic.playerHolderToLocation personId) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty
                |> RelicDict.values
                |> List.foldl (Relic.relicMiddleware action)
                    state


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


doClean : PersonId -> Point -> Int -> GameState -> ( GameState, Types.BackendTrigger )
doClean personId location strength state =
    case Dict.get (pointToDirtLocation location) state.dirtByLocation of
        Nothing ->
            -- This might happen if the user is lagging and someone else cleared the dirt
            ( state, NoOpBackendTrigger )

        Just dirtData ->
            let
                newDirt =
                    cleanDirt strength dirtData

                backendTrigger =
                    if newDirt.amount <= 0 then
                        ClearedPollution personId dirtData

                    else
                        NoOpBackendTrigger

                newDict =
                    if newDirt.amount <= 0 then
                        Dict.remove (pointToDirtLocation dirtData.position) state.dirtByLocation

                    else
                        Dict.insert (pointToDirtLocation dirtData.position) newDirt state.dirtByLocation
            in
            ( { state | dirtByLocation = newDict }
            , backendTrigger
            )


addCleanStats : PersonId -> GameState -> GameState
addCleanStats personId state =
    { state | personDict = incrementCleanCount personId state.personDict }


addClearStats : PersonId -> ( GameState, Types.BackendTrigger ) -> ( GameState, Types.BackendTrigger )
addClearStats personId ( state, trigger ) =
    case trigger of
        ClearedPollution _ _ ->
            ( { state | personDict = incrementClearCount personId state.personDict }, trigger )

        _ ->
            ( state, trigger )


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


earnExperienceFromClean : PersonId -> ( GameState, Types.BackendTrigger ) -> ( GameState, Types.BackendTrigger )
earnExperienceFromClean personId ( state, trigger ) =
    let
        baseXpEarned =
            case trigger of
                ClearedPollution _ _ ->
                    10

                _ ->
                    1
    in
    ( playerEarnsExperience personId baseXpEarned state, trigger )


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


withNoOp : GameState -> ( GameState, Types.BackendTrigger )
withNoOp state =
    ( state, NoOpBackendTrigger )


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

                        Just player ->
                            cleanStrengthForPlayer state player
            in
            state
                |> addCleanStats personId
                |> doClean personId location strength
                |> addClearStats personId
                |> earnExperienceFromClean personId

        MovePerson personId direction ->
            withNoOp { state | personDict = movePersonWithId personId direction state.personDict }

        AddPerson personData ->
            withNoOp { state | personDict = PersonDict.insert personData.id personData state.personDict }

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
            withNoOp { state | relicsByPosition = Dict.insert (Relic.floorPointToLocation floorPoint) newRelicDict state.relicsByPosition }

        GameStateNoOp ->
            withNoOp state

        ActivateGenerosityTrap personId relicId numDoubles ->
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
                            withNoOp (activateGenerosityTrap relicData fella numDoubles state)

                        _ ->
                            -- User tried to activate Generosity on a relic that wasn't Generosity. Cheating???
                            ( state, NuhUh personId )

                _ ->
                    ( state, NuhUh personId )


executeActionOnGameState : Types.ActionPerformer -> ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
executeActionOnGameState who actionOnGamestate state =
    let
        stateAfterRelicMiddleware =
            updateWithRelics who actionOnGamestate state
    in
    internalExecuteActionOnGameState actionOnGamestate stateAfterRelicMiddleware


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
