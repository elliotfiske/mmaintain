module GameStateManipulation exposing (activateGenerosityTrap, activateRelicWithPersonData, addCleanStats, addOrModifyDirt, applyClean, applyRelicMiddleware, changeDirtAmount, cleanDirt, cleanStrengthForPlayer, combineBatchActionResult, createActionOnGameStateFromRelicActivation, destroyDirt, doClean, dropAndDoubleRelicBody, dropRelic, executeActionOnGameState, getDirtAtLocation, getRarestRelicAtLocation, getRelicsAtFloorPoint, getRelicsHeldByPlayer, handleActivateGenerosityTrap, handleBatchAction, handleDroppingDoubler, handleSplashBucket, incrementCleanCount, incrementClearCount, internalExecuteActionOnGameState, isRelicHeldByPerson, makeDirtSmaller, maybeActivateRelic, moveRelicFromFloorToPlayer, moveRelicFromPlayerToFloor, pickUpRelic, playerEarnsExperience, relicBody, relicMiddleware, relicsAtLocation, updateDirtAtLocation, updatePersonDictWithExperience, updateRelicsByPositionWithExperience, updateWithRelics, xpMultiplierForPlayer)

import BackendTriggerUtil
import Dict
import DirtUtil
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import GameState
import Html
import List.Extra
import Markdown
import PersonIdSet
import PersonUtil
import RelicDict
import RelicUtil
import SeqDict exposing (SeqDict)
import SeqSet exposing (SeqSet)
import Types exposing (BackendTrigger(..), GameState, RealRelicDict)
import Util


pickUpRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
pickUpRelic takerId relicId state =
    let
        maybeTaker =
            SeqDict.get takerId state.personDict

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
            Dict.get (RelicUtil.playerHolderToLocation taker.id) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty

        newHeldRelics =
            RelicDict.insert relicData.id relicData existingHeldRelics

        newRelicsByPosition =
            state.relicsByPosition
                |> Dict.insert (RelicUtil.playerHolderToLocation taker.id) newHeldRelics
                |> Dict.insert (RelicUtil.floorPointToLocation taker.position) newFloorRelicDict
    in
    { state | relicsByPosition = newRelicsByPosition }


dropRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
dropRelic dropperId relicId state =
    let
        maybeDropper =
            SeqDict.get dropperId state.personDict

        existingRelicsHeldByPlayer =
            getRelicsHeldByPlayer dropperId state

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
            Dict.get (RelicUtil.floorPointToLocation dropper.position) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty

        newFloorRelics =
            RelicDict.insert relicData.id relicData existingFloorRelics

        newRelicsByPosition =
            state.relicsByPosition
                |> Dict.insert (RelicUtil.playerHolderToLocation dropper.id) newHeldRelicDict
                |> Dict.insert (RelicUtil.floorPointToLocation dropper.position) newFloorRelics
    in
    { state | relicsByPosition = newRelicsByPosition }


changeDirtAmount : Types.DirtLocation -> Int -> Types.DirtByLocation -> Types.DirtByLocation
changeDirtAmount location amount dict =
    Dict.update location (Maybe.map (DirtUtil.setDirtAmount amount)) dict


getDirtAtLocation : GameObjectTypes.Point -> Types.DirtByLocation -> Maybe DirtData
getDirtAtLocation point dirtByLocation =
    Dict.get (DirtUtil.pointToDirtLocation point) dirtByLocation


updateDirtAtLocation : GameObjectTypes.Point -> DirtData -> Types.DirtByLocation -> Types.DirtByLocation
updateDirtAtLocation point dirtData dirtByLocation =
    Dict.insert (DirtUtil.pointToDirtLocation point) dirtData dirtByLocation


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
                    changeDirtAmount (DirtUtil.pointToDirtLocation existingDirt.position) dirtData.amount state.dirtByLocation
            in
            ( { state | dirtByLocation = newDirtDict }, NoOpBackendTrigger )


getRarestRelicAtLocation : GameObjectTypes.Point -> GameState -> Maybe RelicData
getRarestRelicAtLocation point state =
    relicsAtLocation point state
        |> List.sortBy RelicUtil.byRelicRarity
        |> List.head


relicsAtLocation : GameObjectTypes.Point -> GameState -> List RelicData
relicsAtLocation point state =
    Dict.get (RelicUtil.floorPointToLocation point) state.relicsByPosition
        |> Maybe.withDefault RelicDict.empty
        |> RelicDict.values


updateWithRelics : Types.ActionPerformer -> ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
updateWithRelics actorId action state =
    case actorId of
        Types.Server ->
            -- Don't apply relic middleware for server actions
            BackendTriggerUtil.withNoOp state

        Types.Client personId ->
            Dict.get (RelicUtil.playerHolderToLocation personId) state.relicsByPosition
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
            relicMiddleware action relic accState
    in
    ( newState, newTrigger :: accTriggers )


{-| Some relics are interested in actions against the GameState. This function
lets relics modify the GameState in response to actions.
-}
relicMiddleware : ActionOnGamestate -> RelicData -> GameState -> ( GameState, BackendTrigger )
relicMiddleware action relic state =
    case relic.relicType of
        CleanFast ->
            BackendTriggerUtil.withNoOp state

        MoreXP ->
            -- Handled in earnExperienceFromClean
            BackendTriggerUtil.withNoOp state

        DropAndDouble people ->
            case action of
                DropRelic relicId personId ->
                    handleDroppingDoubler relicId relic personId people state
                        |> BackendTriggerUtil.withNoOp

                _ ->
                    BackendTriggerUtil.withNoOp state

        SplashBucket ->
            case action of
                Clean personId location ->
                    handleSplashBucket location relic personId state

                _ ->
                    BackendTriggerUtil.withNoOp state

        GuestBook peopleWhoHaveHeldIt ->
            case action of
                PickUpRelic _ personId ->
                    let
                        newPeopleWhoHaveHeldIt =
                            SeqSet.insert personId peopleWhoHaveHeldIt

                        newRelic =
                            { relic | relicType = GuestBook newPeopleWhoHaveHeldIt }

                        updatedRelicDict =
                            RelicUtil.updateRelicAtLocation

                        -- todo: this doesn't work. Need to update the relic data and put it back in the state.
                    in
                    ( state, NoOpBackendTrigger )

                _ ->
                    BackendTriggerUtil.withNoOp state


updateRelicsByPositionWithExperience : PersonId -> Int -> Dict.Dict Types.RelicLocation RealRelicDict -> Dict.Dict Types.RelicLocation RealRelicDict
updateRelicsByPositionWithExperience personId totalXpEarned relicsByPosition =
    let
        heldRelics =
            Dict.get (RelicUtil.playerHolderToLocation personId) relicsByPosition
                |> Maybe.withDefault RelicDict.empty

        newHeldRelics =
            heldRelics
                |> RelicDict.map
                    (\_ relic ->
                        { relic | exp = relic.exp + totalXpEarned }
                    )
    in
    Dict.insert (RelicUtil.playerHolderToLocation personId) newHeldRelics relicsByPosition


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
            Dict.get (RelicUtil.playerHolderToLocation personId) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty
                |> RelicDict.get relicId

        maybeFella =
            SeqDict.get personId state.personDict
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
                    Dict.get (RelicUtil.floorPointToLocation floorPoint) state.relicsByPosition
                        |> Maybe.withDefault RelicDict.empty

                newRelicDict =
                    RelicDict.insert relicData.id relicData existingRelicDict
            in
            BackendTriggerUtil.withNoOp { state | relicsByPosition = Dict.insert (RelicUtil.floorPointToLocation floorPoint) newRelicDict state.relicsByPosition }

        GameStateNoOp ->
            BackendTriggerUtil.withNoOp state

        ActivateGenerosityTrap personId relicId numDoubles ->
            handleActivateGenerosityTrap personId relicId numDoubles state

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

        ( _, _ ) ->
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
        relicsHeldByPlayer =
            getRelicsHeldByPlayer personData.id state

        newRelicDict =
            RelicDict.remove relicData.id relicsHeldByPlayer

        newRelicsByPosition =
            state.relicsByPosition
                |> Dict.insert (RelicUtil.playerHolderToLocation personData.id) newRelicDict

        xpEarned =
            RelicUtil.dropDoubleCurrentExperience relicData.rarity relicData.exp numDoubles

        newState =
            playerEarnsExperience personData.id xpEarned state
    in
    { newState | relicsByPosition = newRelicsByPosition }


doClean : PersonId -> Point -> Int -> GameState -> ( GameState, Types.BackendTrigger )
doClean personId location strength state =
    case Dict.get (DirtUtil.pointToDirtLocation location) state.dirtByLocation of
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
            Dict.insert (DirtUtil.pointToDirtLocation newDirt.position) newDirt state.dirtByLocation

        newState =
            state
                |> GameState.updateGameStateDirtDict newDirtDict
                |> playerEarnsExperience personId 1
    in
    ( newState, NoOpBackendTrigger )


destroyDirt : PersonId -> DirtData -> GameState -> ( GameState, Types.BackendTrigger )
destroyDirt personId dirtData state =
    let
        newDirtDict =
            Dict.remove (DirtUtil.pointToDirtLocation dirtData.position) state.dirtByLocation

        newPersonDict =
            state.personDict
                |> incrementClearCount personId

        newState =
            state
                |> GameState.updateGameStateDirtDict newDirtDict
                |> GameState.updateGameStatePersonDict newPersonDict
                |> playerEarnsExperience personId 10
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

        splashStrength =
            RelicUtil.splashBucketStrength relic.rarity relic.exp
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
        RelicUtil.updateRelicAtLocation (RelicUtil.playerHolderToLocation personId) newRelic state

    else
        state


xpMultiplierForPlayer : GameState -> PersonData -> Float
xpMultiplierForPlayer state person =
    let
        heldRelics =
            Dict.get (RelicUtil.playerHolderToLocation person.id) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty
                |> RelicDict.values
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


getRelicsAtFloorPoint : Point -> GameState -> RealRelicDict
getRelicsAtFloorPoint point state =
    Dict.get (RelicUtil.floorPointToLocation point) state.relicsByPosition
        |> Maybe.withDefault RelicDict.empty


getRelicsHeldByPlayer : PersonId -> GameState -> RealRelicDict
getRelicsHeldByPlayer personId state =
    Dict.get (RelicUtil.playerHolderToLocation personId) state.relicsByPosition
        |> Maybe.withDefault RelicDict.empty


isRelicHeldByPerson : GameState -> RelicId -> PersonId -> Bool
isRelicHeldByPerson state relicId personId =
    RelicDict.member relicId (getRelicsHeldByPlayer personId state)


relicBody : Types.FrontendPlayingState -> RelicData -> PersonData -> List (Html.Html Types.FrontendMsg)
relicBody state relic me =
    let
        heldByMe =
            isRelicHeldByPerson state.gameState relic.id state.myId
    in
    case relic.relicType of
        CleanFast ->
            RelicUtil.simpleRelicBody ("x" ++ Util.readableStringFromFloat (RelicUtil.cleanFastStrengthMultiplier relic.rarity relic.exp) ++ " to Cleaning Strength.")

        MoreXP ->
            RelicUtil.simpleRelicBody ("x" ++ Util.readableStringFromFloat (RelicUtil.xpMultiplier relic.rarity relic.exp) ++ " to all XP earned.")

        DropAndDouble people ->
            dropAndDoubleRelicBody state relic me people heldByMe

        SplashBucket ->
            RelicUtil.simpleRelicBody ("Also clean the dirt on adjacent squares at " ++ String.fromInt (RelicUtil.splashBucketStrength relic.rarity relic.exp) ++ " strength.")

        GuestBook peopleWhoHaveHeldIt ->
            RelicUtil.simpleRelicBody
                ("Gets more powerful for each person who has held it. Currently increases clean strength by "
                    ++ String.fromInt (RelicUtil.guestBookStrength relic.rarity relic.exp (SeqSet.size peopleWhoHaveHeldIt))
                    ++ ". List of IDs who have held it: "
                    ++ String.join ", " (List.map personIdToString (SeqSet.toList peopleWhoHaveHeldIt))
                    ++ "."
                )


dropAndDoubleRelicBody : Types.FrontendPlayingState -> RelicData -> PersonData -> List PersonId -> Bool -> List (Html.Html Types.FrontendMsg)
dropAndDoubleRelicBody state relic me people heldByMe =
    let
        alreadyDropped =
            List.member state.myId people

        baseExp =
            RelicUtil.dropDoubleCurrentExperience relic.rarity relic.exp (List.length people)

        playerXpMultiplier =
            xpMultiplierForPlayer state.gameState me

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


createActionOnGameStateFromRelicActivation : PersonId -> RelicId -> GameState -> ActionOnGamestate
createActionOnGameStateFromRelicActivation activatorId relicId state =
    let
        maybeRelic =
            RelicUtil.getRelicAtLocation (RelicUtil.playerHolderToLocation activatorId) relicId state

        maybePerson =
            SeqDict.get activatorId state.personDict
    in
    case ( maybeRelic, maybePerson ) of
        ( Just relic, Just person ) ->
            case relic.relicType of
                DropAndDouble people ->
                    ActivateGenerosityTrap activatorId relicId (List.length people)

                _ ->
                    GameStateNoOp

        _ ->
            GameStateNoOp


maybeActivateRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
maybeActivateRelic activatorId relicId state =
    let
        maybeRelic =
            RelicUtil.getRelicAtLocation (RelicUtil.playerHolderToLocation activatorId) relicId state

        maybePerson =
            SeqDict.get activatorId state.personDict
    in
    case ( maybeRelic, maybePerson ) of
        ( Just relic, Just person ) ->
            activateRelicWithPersonData state person relic

        _ ->
            ( state, NoOpBackendTrigger )


activateRelicWithPersonData : GameState -> PersonData -> RelicData -> ( GameState, Types.BackendTrigger )
activateRelicWithPersonData state person relic =
    case relic.relicType of
        DropAndDouble people ->
            let
                newPersonState =
                    { person | experience = person.experience + RelicUtil.dropDoubleCurrentExperience relic.rarity relic.exp (List.length people) }
            in
            ( { state | personDict = SeqDict.insert person.id newPersonState state.personDict }, NoOpBackendTrigger )

        _ ->
            ( state, NoOpBackendTrigger )


addCleanStats : PersonId -> GameState -> GameState
addCleanStats personId state =
    { state | personDict = incrementCleanCount personId state.personDict }


cleanStrengthForPlayer : GameState -> PersonData -> Int
cleanStrengthForPlayer state person =
    let
        heldRelics =
            Dict.get (RelicUtil.playerHolderToLocation person.id) state.relicsByPosition
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
                        acc * RelicUtil.cleanFastStrengthMultiplier relic.rarity relic.exp

                    _ ->
                        acc
            )
            baseXP
        |> round
