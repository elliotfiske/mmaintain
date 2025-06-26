module GameStateManipulation exposing
    ( cleanStrengthForPlayer
    , executeActionOnGameState
    , findSmallestAndLargestNearbyDirts
    , getRarestRelicAtLocation
    , getRelicsHeldByPlayer
    , isRelicHeldByPerson
    , relicBody
    , relicRarityBoostForPlayer
    , relicsAtLocation
    , xpMultiplierForPlayer
    )

import BackendTriggerUtil
import DirtUtil
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import GameState
import Html
import List.Extra
import Markdown
import PersonUtil
import PointUtil
import RelicUtil
import SeqDict exposing (SeqDict)
import SeqSet exposing (SeqSet)
import Types exposing (BackendTrigger(..), GameState, RelicsById, RelicsByLocation)
import Util


pickUpRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
pickUpRelic takerId relicId state =
    let
        maybeTaker =
            SeqDict.get takerId state.personDict

        existingRelicsOnGround =
            maybeTaker
                |> Maybe.map (\taker -> getRelicsAtFloorPoint taker.position state)
                |> Maybe.withDefault SeqDict.empty

        maybeTargetRelic =
            SeqDict.get relicId existingRelicsOnGround

        hasEnoughSlots taker =
            let
                currentRelicCount =
                    getRelicsHeldByPlayer taker.id state
                        |> SeqDict.size

                maxSlots =
                    RelicUtil.relicSlotsForLevel (Util.levelForExp taker.experience)
            in
            currentRelicCount < maxSlots
    in
    case ( maybeTaker, maybeTargetRelic ) of
        ( Just taker, Just targetRelic ) ->
            if hasEnoughSlots taker then
                let
                    newState =
                        moveRelicFromFloorToPlayer taker targetRelic existingRelicsOnGround state
                in
                ( newState, NoOpBackendTrigger )

            else
                ( state, NoOpBackendTrigger )

        _ ->
            ( state, NoOpBackendTrigger )


moveRelicFromFloorToPlayer : PersonData -> RelicData -> RelicsById -> GameState -> GameState
moveRelicFromFloorToPlayer taker relicData floorDictToRemoveFrom state =
    let
        newFloorRelicDict =
            SeqDict.remove relicData.id floorDictToRemoveFrom

        existingHeldRelics =
            SeqDict.get (GameObjectTypes.HeldBy taker.id) state.relicsByLocation
                |> Maybe.withDefault SeqDict.empty

        newHeldRelics =
            SeqDict.insert relicData.id relicData existingHeldRelics

        newRelicsByPosition =
            state.relicsByLocation
                |> SeqDict.insert (GameObjectTypes.HeldBy taker.id) newHeldRelics
                |> SeqDict.insert (GameObjectTypes.OnFloor taker.position) newFloorRelicDict
    in
    GameState.updateRelicState newRelicsByPosition state


dropRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
dropRelic dropperId relicId state =
    let
        maybeDropper =
            SeqDict.get dropperId state.personDict

        existingRelicsHeldByPlayer =
            getRelicsHeldByPlayer dropperId state

        maybeRelicBeingDropped =
            SeqDict.get relicId existingRelicsHeldByPlayer
    in
    case ( maybeDropper, maybeRelicBeingDropped ) of
        ( Just dropper, Just relic ) ->
            let
                newState =
                    moveRelicFromPlayerToFloor dropper relic existingRelicsHeldByPlayer state
            in
            ( newState, NoOpBackendTrigger )

        _ ->
            ( state, NoOpBackendTrigger )


moveRelicFromPlayerToFloor : PersonData -> RelicData -> RelicsById -> GameState -> GameState
moveRelicFromPlayerToFloor dropper relicData heldDictToRemoveFrom state =
    let
        newHeldRelicDict =
            SeqDict.remove relicData.id heldDictToRemoveFrom

        existingFloorRelics =
            SeqDict.get (GameObjectTypes.OnFloor dropper.position) state.relicsByLocation
                |> Maybe.withDefault SeqDict.empty

        newFloorRelics =
            SeqDict.insert relicData.id relicData existingFloorRelics

        newRelicsByPosition =
            state.relicsByLocation
                |> SeqDict.insert (GameObjectTypes.HeldBy dropper.id) newHeldRelicDict
                |> SeqDict.insert (GameObjectTypes.OnFloor dropper.position) newFloorRelics
    in
    GameState.updateRelicState newRelicsByPosition state


changeDirtAmount : Point -> Int -> Types.DirtByLocation -> Types.DirtByLocation
changeDirtAmount location amount dict =
    SeqDict.update location (Maybe.map (DirtUtil.setDirtAmount amount)) dict


{-| Add a new dirt or modify an existing dirt's "amount".

Currently used to spawn dirt as a "debug action", not for user-initiated actions.

-}
addOrModifyDirt : DirtData -> GameState -> ( GameState, Types.BackendTrigger )
addOrModifyDirt dirtData state =
    let
        maybeExistingDirt =
            SeqDict.get dirtData.position state.dirtByLocation
    in
    case maybeExistingDirt of
        Nothing ->
            ( { state | dirtByLocation = SeqDict.insert dirtData.position dirtData state.dirtByLocation }, NoOpBackendTrigger )

        Just existingDirt ->
            let
                newDirtDict =
                    changeDirtAmount existingDirt.position dirtData.amount state.dirtByLocation
            in
            ( { state | dirtByLocation = newDirtDict }, NoOpBackendTrigger )


getRarestRelicAtLocation : GameObjectTypes.Point -> GameState -> Maybe RelicData
getRarestRelicAtLocation point state =
    relicsAtLocation point state
        |> List.sortBy RelicUtil.byRelicRarity
        |> List.head


relicsAtLocation : GameObjectTypes.Point -> GameState -> List RelicData
relicsAtLocation point state =
    SeqDict.get (GameObjectTypes.OnFloor point) state.relicsByLocation
        |> Maybe.withDefault SeqDict.empty
        |> SeqDict.values


updateWithRelics : Types.ActionPerformer -> ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
updateWithRelics actorId action state =
    case actorId of
        Types.Server ->
            -- Don't apply relic middleware for server actions
            BackendTriggerUtil.withNoOp state

        Types.Client _ ->
            SeqDict.values state.relicsByLocation
                |> List.concatMap SeqDict.values
                |> List.foldl
                    (applyRelicMiddleware action)
                    ( state, [] )
                |> Tuple.mapSecond BatchTrigger


applyRelicMiddleware : ActionOnGamestate -> RelicData -> ( GameState, List Types.BackendTrigger ) -> ( GameState, List Types.BackendTrigger )
applyRelicMiddleware action relic ( accState, accTriggers ) =
    let
        ( newState, newTrigger ) =
            relicMiddleware action relic accState
    in
    ( newState, newTrigger :: accTriggers )


{-| Some relics are interested in actions against the GameState. This function
lets relics modify the GameState in response to actions.
-}
relicMiddleware : ActionOnGamestate -> RelicData -> GameState -> ( GameState, BackendTrigger )
relicMiddleware action relic state =
    case relic.relicType of
        Broom ->
            BackendTriggerUtil.withNoOp state

        Mop ->
            BackendTriggerUtil.withNoOp state

        MoreXP ->
            -- Handled in earnExperienceFromClean
            BackendTriggerUtil.withNoOp state

        DropAndDouble people ->
            (case action of
                DropRelic relicId personId ->
                    handleDroppingDoubler relicId relic personId people state

                _ ->
                    state
            )
                |> BackendTriggerUtil.withNoOp

        SplashBucket ->
            case action of
                Clean personId location ->
                    if isRelicHeldByPerson state relic.id personId then
                        handleSplashBucket location relic personId state

                    else
                        BackendTriggerUtil.withNoOp state

                _ ->
                    BackendTriggerUtil.withNoOp state

        GuestBook peopleWhoHaveHeldIt ->
            case action of
                PickUpRelic relicId personId ->
                    handleGuestBookPickup relicId relic personId peopleWhoHaveHeldIt state

                _ ->
                    BackendTriggerUtil.withNoOp state

        DiminishingPower { currentDirtPatch, currentPower } ->
            case action of
                Clean personId location ->
                    if isRelicHeldByPerson state relic.id personId then
                        let
                            newPower =
                                if currentDirtPatch == Just location then
                                    -- Diminish power by 20% each time
                                    currentPower * 0.8

                                else
                                    -- Reset to max power for new dirt patch
                                    RelicUtil.diminishingPowerMultiplier relic location

                            updatedRelic =
                                { relic | relicType = DiminishingPower { currentDirtPatch = Just location, currentPower = newPower } }

                            newState =
                                RelicUtil.updateRelicAtLocation (HeldBy personId) updatedRelic state
                        in
                        ( newState, NoOpBackendTrigger )

                    else
                        BackendTriggerUtil.withNoOp state

                _ ->
                    BackendTriggerUtil.withNoOp state

        HighFive ->
            case action of
                MovePerson moverId direction ->
                    let
                        maybeMover =
                            SeqDict.get moverId state.personDict
                    in
                    case maybeMover of
                        Just mover ->
                            BackendTriggerUtil.withNoOp (handleHighFive relic mover direction state)

                        Nothing ->
                            BackendTriggerUtil.withNoOp state

                _ ->
                    BackendTriggerUtil.withNoOp state

        MetalDetector ->
            -- Metal Detector is passive - only affects relic find boost calculation
            BackendTriggerUtil.withNoOp state


{-| Find all players at a given location, excluding one player.
-}
findPlayersAtDestination : Point -> PersonId -> SeqDict PersonId PersonData -> List PersonData
findPlayersAtDestination location excludeId personDict =
    personDict
        |> SeqDict.values
        |> List.filter
            (\person ->
                person.position
                    == location
                    && person.id
                    /= excludeId
            )


{-| Each time a player moves, apply necessary high five boosts.

Note this code will be run for ALL player movement, and will also be run once for each High Five Relic in the game.

Check the target location for the relic holder (note this could be the same as the person moving).
If there is a person at the target location with a high-five relic, look for any other people on the same tile.
If there are people, apply the boost to all players at the destination (besides the holder).

-}
handleHighFive : RelicData -> PersonData -> Direction -> GameState -> GameState
handleHighFive relic mover direction state =
    let
        maybeRelicHolder =
            RelicUtil.getRelicHolderId relic.id state

        maybeHolderData =
            maybeRelicHolder
                |> Maybe.andThen (\holderId -> SeqDict.get holderId state.personDict)
    in
    case maybeHolderData of
        Nothing ->
            state

        Just holder ->
            applyHighFiveBoost relic holder mover direction state


{-| Apply high five boosts to players at the destination.
-}
applyHighFiveBoost : RelicData -> PersonData -> PersonData -> Direction -> GameState -> GameState
applyHighFiveBoost relic holder mover direction state =
    let
        playerDictAfterMove =
            PersonUtil.movePersonWithId mover.id direction state.personDict

        destination =
            PointUtil.newPoint direction mover.position

        playersAtDestination =
            findPlayersAtDestination destination holder.id playerDictAfterMove

        newBoost =
            HighFiveBoost
                (RelicUtil.highFiveBoostStrength relic.rarity relic.exp)
                holder.id

        updatePlayerWithBoost person =
            { person | bestHighFiveBoost = newHighFiveBoost person.bestHighFiveBoost newBoost }

        updatedPlayers =
            List.map updatePlayerWithBoost playersAtDestination

        newPersonDict =
            List.foldl
                (\updatedPerson dict -> SeqDict.insert updatedPerson.id updatedPerson dict)
                state.personDict
                updatedPlayers
    in
    { state | personDict = newPersonDict }


newHighFiveBoost : Maybe HighFiveBoost -> HighFiveBoost -> Maybe HighFiveBoost
newHighFiveBoost maybeCurrentBoost newBoost =
    case maybeCurrentBoost of
        Nothing ->
            Just newBoost

        Just currentBoost ->
            if currentBoost.boost > newBoost.boost then
                Just currentBoost

            else
                Just newBoost


updateRelicsByPositionWithExperience : PersonId -> Int -> RelicsByLocation -> RelicsByLocation
updateRelicsByPositionWithExperience personId totalXpEarned relicsByLocation =
    let
        heldRelics =
            SeqDict.get (GameObjectTypes.HeldBy personId) relicsByLocation
                |> Maybe.withDefault SeqDict.empty

        newHeldRelics =
            heldRelics
                |> SeqDict.map
                    (\_ relic ->
                        { relic | exp = relic.exp + totalXpEarned }
                    )
    in
    SeqDict.insert (GameObjectTypes.HeldBy personId) newHeldRelics relicsByLocation


playerEarnsExperience : PersonId -> Int -> GameState -> GameState
playerEarnsExperience personId xpEarned state =
    case SeqDict.get personId state.personDict of
        Nothing ->
            state

        Just player ->
            let
                xpMultiplier =
                    xpMultiplierForPlayer state player

                totalXpEarned =
                    round (xpMultiplier * toFloat xpEarned)

                newPersonDict =
                    updatePersonDictWithExperience personId totalXpEarned state.personDict

                newRelicsByPosition =
                    updateRelicsByPositionWithExperience personId totalXpEarned state.relicsByLocation
            in
            state
                |> GameState.updateGameStatePersonDict newPersonDict
                |> GameState.updateGameStateRelicDict newRelicsByPosition


handleActivateGenerosityTrap : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
handleActivateGenerosityTrap personId relicId state =
    let
        maybeRelic =
            SeqDict.get (GameObjectTypes.HeldBy personId) state.relicsByLocation
                |> Maybe.withDefault SeqDict.empty
                |> SeqDict.get relicId

        maybeFella =
            SeqDict.get personId state.personDict
    in
    case ( maybeRelic, maybeFella ) of
        ( Just relicData, Just fella ) ->
            case relicData.relicType of
                DropAndDouble people ->
                    BackendTriggerUtil.withNoOp (activateGenerosityTrap relicData fella (List.length people) state)

                _ ->
                    -- User tried to activate Generosity on a relic that wasn't Generosity. Cheating???
                    ( state, NoOpBackendTrigger )

        _ ->
            ( state, NoOpBackendTrigger )


internalExecuteActionOnGameState : ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
internalExecuteActionOnGameState action state =
    case action of
        Clean personId location ->
            case SeqDict.get personId state.personDict of
                Nothing ->
                    ( state, NoOpBackendTrigger )

                Just player ->
                    let
                        strength =
                            cleanStrengthForPlayer state player
                    in
                    state
                        |> addCleanStats personId
                        |> doClean personId location strength

        MovePerson personId direction ->
            BackendTriggerUtil.withNoOp { state | personDict = PersonUtil.movePersonWithId personId direction state.personDict }

        AddPerson personData ->
            BackendTriggerUtil.withNoOp { state | personDict = SeqDict.insert personData.id personData state.personDict }

        PickUpRelic relicId personId ->
            pickUpRelic personId relicId state

        DropRelic relicId personId ->
            dropRelic personId relicId state

        AddDirt dirtData ->
            addOrModifyDirt dirtData state

        AddRelic relicData floorPoint ->
            let
                existingRelicDict =
                    SeqDict.get (GameObjectTypes.OnFloor floorPoint) state.relicsByLocation
                        |> Maybe.withDefault SeqDict.empty

                newRelicDict =
                    SeqDict.insert relicData.id relicData existingRelicDict

                newRelicsByLocation =
                    SeqDict.insert (GameObjectTypes.OnFloor floorPoint) newRelicDict state.relicsByLocation
            in
            BackendTriggerUtil.withNoOp (GameState.updateRelicState newRelicsByLocation state)

        GameStateNoOp ->
            BackendTriggerUtil.withNoOp state

        ActivateGenerosityTrap personId relicId ->
            handleActivateGenerosityTrap personId relicId state

        UnlockSkillAction personId skill ->
            unlockSkill personId skill state

        BatchAction actions ->
            handleBatchAction actions state


handleBatchAction : List ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
handleBatchAction actions state =
    List.foldl
        combineBatchActionResult
        ( state, Types.NoOpBackendTrigger )
        actions


combineBatchActionResult : ActionOnGamestate -> ( GameState, Types.BackendTrigger ) -> ( GameState, Types.BackendTrigger )
combineBatchActionResult batchAction ( currentState, currentTrigger ) =
    let
        ( newState, newTrigger ) =
            internalExecuteActionOnGameState batchAction currentState
    in
    case ( currentTrigger, newTrigger ) of
        ( NoOpBackendTrigger, _ ) ->
            ( newState, newTrigger )

        ( _, NoOpBackendTrigger ) ->
            ( newState, currentTrigger )

        _ ->
            ( newState, Types.BatchTrigger [ currentTrigger, newTrigger ] )


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
        xpEarned =
            RelicUtil.dropDoubleCurrentExperience relicData.rarity relicData.exp numDoubles

        newState =
            playerEarnsExperience personData.id xpEarned state

        relicsHeldByPlayer =
            getRelicsHeldByPlayer personData.id newState

        newRelicDict =
            SeqDict.remove relicData.id relicsHeldByPlayer

        newRelicsByPosition =
            newState.relicsByLocation
                |> SeqDict.insert (GameObjectTypes.HeldBy personData.id) newRelicDict
    in
    GameState.updateRelicState newRelicsByPosition newState


doClean : PersonId -> Point -> Int -> GameState -> ( GameState, Types.BackendTrigger )
doClean personId location strength state =
    case SeqDict.get location state.dirtByLocation of
        Nothing ->
            -- This might happen if the user is lagging and someone else cleared the dirt
            ( state, NoOpBackendTrigger )

        Just dirtData ->
            cleanDirt personId dirtData strength state


cleanDirt : PersonId -> DirtData -> Int -> GameState -> ( GameState, Types.BackendTrigger )
cleanDirt personId dirtData strength state =
    let
        newDirt =
            DirtUtil.reduceDirtAmount strength dirtData
    in
    if newDirt.amount <= 0 then
        destroyDirt personId dirtData state

    else
        makeDirtSmaller personId newDirt state


makeDirtSmaller : PersonId -> DirtData -> GameState -> ( GameState, Types.BackendTrigger )
makeDirtSmaller personId newDirt state =
    let
        newDirtDict =
            SeqDict.insert newDirt.position newDirt state.dirtByLocation

        baseXP =
            calculateBaseXPForCleaning personId 1 state

        newState =
            state
                |> GameState.updateGameStateDirtDict newDirtDict
                |> playerEarnsExperience personId baseXP
    in
    ( newState, NoOpBackendTrigger )


destroyDirt : PersonId -> DirtData -> GameState -> ( GameState, Types.BackendTrigger )
destroyDirt personId dirtData state =
    let
        newDirtDict =
            SeqDict.remove dirtData.position state.dirtByLocation

        newPersonDict =
            state.personDict
                |> incrementClearCount personId

        baseXP =
            calculateBaseXPForCleaning personId 10 state

        newState =
            state
                |> GameState.updateGameStateDirtDict newDirtDict
                |> GameState.updateGameStatePersonDict newPersonDict
                |> playerEarnsExperience personId baseXP
    in
    ( newState, ClearedPollution personId dirtData )


incrementCleanCount : PersonId -> SeqDict PersonId PersonData -> SeqDict PersonId PersonData
incrementCleanCount personId dict =
    SeqDict.update personId (Maybe.map PersonUtil.doIncrementCleanCount) dict


incrementClearCount : PersonId -> SeqDict PersonId PersonData -> SeqDict PersonId PersonData
incrementClearCount personId dict =
    SeqDict.update personId (Maybe.map PersonUtil.doIncrementClearCount) dict


updatePersonDictWithExperience : PersonId -> Int -> SeqDict PersonId PersonData -> SeqDict PersonId PersonData
updatePersonDictWithExperience personId totalXpEarned dict =
    SeqDict.update personId
        (Maybe.map
            (\person ->
                { person | experience = person.experience + totalXpEarned }
            )
        )
        dict


handleSplashBucket : Point -> RelicData -> PersonId -> GameState -> ( GameState, BackendTrigger )
handleSplashBucket location relic personId state =
    let
        adjacentPoints =
            [ { x = location.x + 1, y = location.y }
            , { x = location.x - 1, y = location.y }
            , { x = location.x, y = location.y + 1 }
            , { x = location.x, y = location.y - 1 }
            ]

        maybePlayer =
            SeqDict.get personId state.personDict

        splashStrength =
            case maybePlayer of
                Just player ->
                    let
                        playerCleanStrength =
                            cleanStrengthForPlayer state player

                        splashPercentage =
                            RelicUtil.splashBucketStrength relic.rarity relic.exp
                    in
                    ceiling (toFloat playerCleanStrength * splashPercentage / 100.0)

                Nothing ->
                    1
    in
    List.foldl
        (applyClean personId splashStrength)
        ( state, NoOpBackendTrigger )
        adjacentPoints


applyClean : PersonId -> Int -> Point -> ( GameState, BackendTrigger ) -> ( GameState, BackendTrigger )
applyClean personId splashStrength point ( accState, accTrigger ) =
    let
        ( newState, backendTrigger ) =
            doClean personId point splashStrength accState
    in
    ( newState, BatchTrigger [ accTrigger, backendTrigger ] )


handleDroppingDoubler : RelicId -> RelicData -> PersonId -> List PersonId -> GameState -> GameState
handleDroppingDoubler relicId relic personId people state =
    if relicId == relic.id then
        let
            newPersonList =
                List.Extra.uniqueBy personIdToString (personId :: people)

            newRelic =
                { relic | relicType = DropAndDouble newPersonList }
        in
        RelicUtil.updateRelicAtLocation (GameObjectTypes.HeldBy personId) newRelic state

    else
        state


xpMultiplierForPlayer : GameState -> PersonData -> Float
xpMultiplierForPlayer state person =
    let
        heldRelics =
            SeqDict.get (GameObjectTypes.HeldBy person.id) state.relicsByLocation
                |> Maybe.withDefault SeqDict.empty
                |> SeqDict.values
    in
    heldRelics
        |> List.foldl
            (\relic acc ->
                case relic.relicType of
                    MoreXP ->
                        acc * RelicUtil.xpMultiplier relic.rarity relic.exp

                    _ ->
                        acc
            )
            1


relicRarityBoostForPlayer : GameState -> PersonData -> Int
relicRarityBoostForPlayer state person =
    let
        -- Check for skill-based boosts
        skillBoost =
            if person.skillTree.relicHunter then
                10

            else
                0

        -- Check for relic-based boosts
        heldRelics =
            SeqDict.get (GameObjectTypes.HeldBy person.id) state.relicsByLocation
                |> Maybe.withDefault SeqDict.empty
                |> SeqDict.values

        relicBoost =
            heldRelics
                |> List.foldl
                    (\relic acc ->
                        case relic.relicType of
                            MetalDetector ->
                                acc + RelicUtil.metalDetectorBoost relic.rarity relic.exp

                            _ ->
                                acc
                    )
                    0
    in
    skillBoost + relicBoost


getRelicsAtFloorPoint : Point -> GameState -> RelicsById
getRelicsAtFloorPoint point state =
    SeqDict.get (GameObjectTypes.OnFloor point) state.relicsByLocation
        |> Maybe.withDefault SeqDict.empty


getRelicsHeldByPlayer : PersonId -> GameState -> RelicsById
getRelicsHeldByPlayer personId state =
    SeqDict.get (GameObjectTypes.HeldBy personId) state.relicsByLocation
        |> Maybe.withDefault SeqDict.empty


isRelicHeldByPerson : GameState -> RelicId -> PersonId -> Bool
isRelicHeldByPerson state relicId personId =
    SeqDict.member relicId (getRelicsHeldByPlayer personId state)


relicBody : Types.FrontendPlayingState -> RelicData -> PersonData -> List (Html.Html Types.FrontendMsg)
relicBody state relic me =
    let
        heldByMe =
            isRelicHeldByPerson state.backendConfirmedGameState relic.id state.myId
    in
    case relic.relicType of
        Broom ->
            RelicUtil.simpleRelicBody
                ("+"
                    ++ String.fromInt (RelicUtil.broomStrengthBonus relic)
                    ++ " to Cleaning Strength."
                )

        Mop ->
            RelicUtil.simpleRelicBody
                ("x"
                    ++ Util.readableStringFromFloat
                        (RelicUtil.mopStrengthMultiplier relic)
                    ++ " to Cleaning Strength."
                )

        MoreXP ->
            RelicUtil.simpleRelicBody
                ("x"
                    ++ Util.readableStringFromFloat
                        (RelicUtil.xpMultiplier relic.rarity relic.exp)
                    ++ " to all XP earned."
                )

        DropAndDouble people ->
            dropAndDoubleRelicBody state relic me people heldByMe

        SplashBucket ->
            RelicUtil.simpleRelicBody
                ("Also clean the dirt on adjacent squares at "
                    ++ Util.readableStringFromFloat (RelicUtil.splashBucketStrength relic.rarity relic.exp)
                    ++ "% of your clean strength."
                )

        GuestBook peopleWhoHaveHeldIt ->
            RelicUtil.simpleRelicBody
                ("Gets more powerful for each person who has held it. Currently increases clean strength by +"
                    ++ String.fromInt (RelicUtil.guestBookStrength relic peopleWhoHaveHeldIt)
                    ++ "%. List of IDs who have held it: "
                    ++ String.join ", " (List.map personIdToString (SeqSet.toList peopleWhoHaveHeldIt))
                    ++ "."
                )

        DiminishingPower { currentDirtPatch, currentPower } ->
            RelicUtil.simpleRelicBody
                ("Cleaning power starts at x"
                    ++ Util.readableStringFromFloat
                        (RelicUtil.diminishingPowerMultiplier relic
                            (Maybe.withDefault { x = 0, y = 0 } currentDirtPatch)
                        )
                    ++ " but diminishes by 20% each time you clean the same dirt patch. Current power: x"
                    ++ Util.readableStringFromFloat currentPower
                    ++ "."
                )

        HighFive ->
            RelicUtil.simpleRelicBody
                ("High five all players on your tile. Their clean strength is boosted by "
                    ++ String.fromInt (RelicUtil.highFiveBoostStrength relic.rarity relic.exp)
                    ++ ". Only the strongest high-five boost applies."
                )

        MetalDetector ->
            RelicUtil.simpleRelicBody
                ("Improves your chances of finding better relics when clearing dirt. Currently provides +"
                    ++ String.fromInt (RelicUtil.metalDetectorBoost relic.rarity relic.exp)
                    ++ " boost to relic rarity rolls."
                )


dropAndDoubleRelicBody : Types.FrontendPlayingState -> RelicData -> PersonData -> List PersonId -> Bool -> List (Html.Html Types.FrontendMsg)
dropAndDoubleRelicBody state relic me people heldByMe =
    let
        alreadyDropped =
            List.member state.myId people

        baseExp =
            RelicUtil.dropDoubleCurrentExperience relic.rarity relic.exp (List.length people)

        playerXpMultiplier =
            xpMultiplierForPlayer state.backendConfirmedGameState me

        finalExp =
            toFloat baseExp
                * playerXpMultiplier
                |> round
    in
    Markdown.toHtml Nothing
        ("Gain **"
            ++ String.fromInt finalExp
            ++ "xp** now, or drop this and double it for somebody else."
            ++ (if alreadyDropped then
                    " <br><br> You've already dropped this. Give it to somebody else!"

                else
                    ""
               )
        )
        ++ (if heldByMe then
                [ RelicUtil.dropAndDoubleActivationButton state.myId people relic.id
                ]

            else
                []
           )


addCleanStats : PersonId -> GameState -> GameState
addCleanStats personId state =
    { state | personDict = incrementCleanCount personId state.personDict }


calculateBaseXPForCleaning : PersonId -> Int -> GameState -> Int
calculateBaseXPForCleaning personId baseAmount state =
    case SeqDict.get personId state.personDict of
        Nothing ->
            baseAmount

        Just person ->
            if person.skillTree.learned then
                baseAmount + 5

            else
                baseAmount


cleanStrengthForPlayer : GameState -> PersonData -> Int
cleanStrengthForPlayer state person =
    let
        heldRelics =
            SeqDict.get (GameObjectTypes.HeldBy person.id) state.relicsByLocation
                |> Maybe.withDefault SeqDict.empty
                |> SeqDict.values

        baseCleanStrength =
            toFloat (10 + Util.levelForExp person.experience)
                + (case person.bestHighFiveBoost of
                    Nothing ->
                        0

                    Just boost ->
                        toFloat boost.boost
                  )

        -- First apply additive bonuses (Broom + Skills)
        strengthAfterAdditive =
            heldRelics
                |> List.foldl
                    (\relic acc ->
                        case relic.relicType of
                            Broom ->
                                acc + toFloat (RelicUtil.broomStrengthBonus relic)

                            _ ->
                                acc
                    )
                    baseCleanStrength
                |> (\acc ->
                        -- Add skill-based additive bonuses
                        acc
                            + (if person.skillTree.root then
                                5.0

                               else
                                0.0
                              )
                            + (if person.skillTree.cleaningFundamentals then
                                10.0

                               else
                                0.0
                              )
                   )

        -- Then apply multiplicative bonuses (Mop, GuestBook, DiminishingPower, Skills)
        strengthAfterMultiplicative =
            heldRelics
                |> List.foldl
                    (\relic acc ->
                        case relic.relicType of
                            Mop ->
                                acc * RelicUtil.mopStrengthMultiplier relic

                            GuestBook holders ->
                                acc * (1.0 + toFloat (RelicUtil.guestBookStrength relic holders) / 100.0)

                            DiminishingPower { currentPower } ->
                                acc * currentPower

                            _ ->
                                acc
                    )
                    strengthAfterAdditive
                |> (\acc ->
                        -- Add skill-based multiplicative bonuses
                        if person.skillTree.swiftCleaning then
                            acc * 1.1

                        else
                            acc
                   )
    in
    round strengthAfterMultiplicative


findSmallestAndLargestNearbyDirts : Point -> GameState -> Maybe ( DirtData, DirtData )
findSmallestAndLargestNearbyDirts playerPosition state =
    findNearbyDirt playerPosition state
        |> Util.listOutliers .amount


findNearbyDirt : Point -> GameState -> List DirtData
findNearbyDirt playerPosition state =
    let
        allDirt =
            SeqDict.values state.dirtByLocation

        distanceToPlayer dirt =
            abs (dirt.position.x - playerPosition.x) + abs (dirt.position.y - playerPosition.y)
    in
    allDirt
        |> List.filter (\dirt -> distanceToPlayer dirt <= 10)


handleGuestBookPickup : RelicId -> RelicData -> PersonId -> SeqSet PersonId -> GameState -> ( GameState, Types.BackendTrigger )
handleGuestBookPickup relicId relic personId peopleWhoHaveHeldIt state =
    if relicId == relic.id then
        let
            newPeopleWhoHaveHeldIt =
                SeqSet.insert personId peopleWhoHaveHeldIt

            newRelic =
                { relic | relicType = GuestBook newPeopleWhoHaveHeldIt }

            maybeLocation =
                SeqDict.get personId state.personDict
                    |> Maybe.map .position
        in
        case maybeLocation of
            Just location ->
                ( RelicUtil.updateRelicAtLocation
                    (GameObjectTypes.OnFloor location)
                    newRelic
                    state
                , NoOpBackendTrigger
                )

            Nothing ->
                BackendTriggerUtil.withNoOp state

    else
        BackendTriggerUtil.withNoOp (Debug.log "GuestBook relic is not the one we're looking for" state)


unlockSkill : PersonId -> GameObjectTypes.Skill -> GameState -> ( GameState, Types.BackendTrigger )
unlockSkill personId skill state =
    let
        updatePersonSkillTree person =
            let
                skillTree =
                    person.skillTree

                newSkillTree =
                    case skill of
                        GameObjectTypes.Root ->
                            { skillTree | root = True }

                        GameObjectTypes.Learned ->
                            { skillTree | learned = True }

                        GameObjectTypes.SwiftCleaning ->
                            { skillTree | swiftCleaning = True }

                        GameObjectTypes.CleaningFundamentals ->
                            { skillTree | cleaningFundamentals = True }

                        GameObjectTypes.RelicHunter ->
                            { skillTree | relicHunter = True }
            in
            { person | skillTree = newSkillTree }

        newPersonDict =
            SeqDict.update personId (Maybe.map updatePersonSkillTree) state.personDict
    in
    BackendTriggerUtil.withNoOp { state | personDict = newPersonDict }
