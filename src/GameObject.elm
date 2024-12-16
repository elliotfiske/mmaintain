module GameObject exposing (..)

import DirtDict exposing (DirtDict)
import GameObjectTypes exposing (..)
import PersonDict exposing (PersonDict)
import Relic exposing (..)
import RelicDict
import Types exposing (BackendTrigger(..), GameState, RealDirtDict, RealRelicDict)
import Util


movePerson : Direction -> PersonData -> PersonData
movePerson direction person =
    case direction of
        Up ->
            { person | y = person.y - 1 }

        Down ->
            { person | y = person.y + 1 }

        Left ->
            { person | x = person.x - 1 }

        Right ->
            { person | x = person.x + 1 }


pickUpRelic : PersonId -> RelicData -> RelicData
pickUpRelic personId relic =
    { relic | position = HeldBy personId }


dropRelic : PersonData -> RelicData -> RelicData
dropRelic personData relicData =
    { relicData | position = OnFloor personData.x personData.y }


createPerson : PersonId -> String -> PersonData
createPerson id name =
    { id = id
    , name = name
    , experience = 0
    , x = 3
    , y = 3
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


changeDirtAmount : DirtId -> Int -> RealDirtDict -> RealDirtDict
changeDirtAmount id amount dict =
    DirtDict.update id (Maybe.map (setDirtAmount amount)) dict


dirtIsAtLocation : Int -> Int -> GameObjectTypes.DirtData -> Bool
dirtIsAtLocation x y dirtData =
    dirtData.x == x && dirtData.y == y


getDirtAtLocation : Int -> Int -> RealDirtDict -> Maybe DirtData
getDirtAtLocation x y dict =
    dict
        |> DirtDict.values
        |> List.filter (dirtIsAtLocation x y)
        |> List.head


relicIsAtLocation : Int -> Int -> GameObjectTypes.RelicData -> Bool
relicIsAtLocation x y { position } =
    case position of
        HeldBy _ ->
            False

        OnFloor relicX relicY ->
            x == relicX && y == relicY


getRelicAtLocation : Int -> Int -> RealRelicDict -> Maybe RelicData
getRelicAtLocation x y dict =
    dict
        |> RelicDict.values
        |> List.filter (relicIsAtLocation x y)
        |> List.sortBy byRelicRarity
        |> List.head


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


updateWithRelics : ActionOnGamestate -> GameState -> GameState
updateWithRelics action state =
    RelicDict.values state.relicDict
        -- todo: only have held relics modify state
        |> List.foldl (Relic.relicModifiesState action) state


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


doClean : PersonId -> DirtId -> Int -> GameState -> ( GameState, Types.BackendTrigger )
doClean personId dirtId strength state =
    case DirtDict.get dirtId state.dirtDict of
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
                        DirtDict.remove dirtId state.dirtDict

                    else
                        DirtDict.insert dirtId newDirt state.dirtDict
            in
            ( { state | dirtDict = newDict }
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


xpMultiplierForPlayer : RealRelicDict -> PersonData -> Float
xpMultiplierForPlayer relics person =
    let
        heldRelics =
            RelicDict.values relics
                |> List.filter (\relic -> relicHolder relic == Just person.id)
    in
    heldRelics
        |> List.foldl
            (\relic acc ->
                case relic.relicType of
                    MoreXP ->
                        acc * xpMultiplier relic.rarity person.experience

                    _ ->
                        acc
            )
            1


cleanStrengthForPlayer : RealRelicDict -> PersonData -> Int
cleanStrengthForPlayer relics person =
    let
        heldRelics =
            RelicDict.values relics
                |> List.filter (\relic -> relicHolder relic == Just person.id)

        baseXP =
            toFloat (10 + Util.levelForExp person.experience)
    in
    heldRelics
        |> List.foldl
            (\relic acc ->
                case relic.relicType of
                    CleanFast ->
                        acc * cleanFastStrengthMultiplier relic.rarity -37

                    _ ->
                        acc
            )
            baseXP
        |> round


earnExperienceFromClean : PersonId -> ( GameState, Types.BackendTrigger ) -> ( GameState, Types.BackendTrigger )
earnExperienceFromClean personId ( state, trigger ) =
    let
        person =
            PersonDict.get personId state.personDict

        baseXpEarned =
            case trigger of
                ClearedPollution _ _ ->
                    10

                _ ->
                    1
    in
    case person of
        Nothing ->
            ( state, NoOpBackendTrigger )

        Just fella ->
            let
                xpEarned =
                    baseXpEarned
                        * xpMultiplierForPlayer state.relicDict fella
                        |> round

                newPerson =
                    { fella | experience = fella.experience + xpEarned }

                newPersonDict =
                    PersonDict.insert personId newPerson state.personDict
            in
            ( { state | personDict = newPersonDict }, trigger )


withNoOp : GameState -> ( GameState, Types.BackendTrigger )
withNoOp state =
    ( state, NoOpBackendTrigger )


internalExecuteActionOnGameState : ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
internalExecuteActionOnGameState action state =
    case action of
        Clean personId dirtId ->
            let
                maybePlayer =
                    PersonDict.get personId state.personDict

                strength =
                    case maybePlayer of
                        Nothing ->
                            1

                        Just player ->
                            cleanStrengthForPlayer state.relicDict player
            in
            state
                |> addCleanStats personId
                |> doClean personId dirtId strength
                |> addClearStats personId
                |> earnExperienceFromClean personId

        MovePerson personId direction ->
            withNoOp { state | personDict = movePersonWithId personId direction state.personDict }

        AddPerson personData ->
            withNoOp { state | personDict = PersonDict.insert personData.id personData state.personDict }

        PickUpRelic relicId personId ->
            withNoOp { state | relicDict = RelicDict.update relicId (Maybe.map (pickUpRelic personId)) state.relicDict }

        DropRelic relicId personId ->
            let
                maybeDropper =
                    PersonDict.get personId state.personDict

                maybeRelic =
                    RelicDict.get relicId state.relicDict
            in
            case ( maybeDropper, maybeRelic ) of
                ( Just dropper, Just relic ) ->
                    withNoOp { state | relicDict = RelicDict.insert relicId (dropRelic dropper relic) state.relicDict }

                _ ->
                    withNoOp state

        ChangeDirtAmount dirtId int ->
            withNoOp { state | dirtDict = changeDirtAmount dirtId int state.dirtDict }

        AddDirt dirtData ->
            withNoOp { state | dirtDict = DirtDict.insert dirtData.id dirtData state.dirtDict }

        AddRelic relicData ->
            withNoOp { state | relicDict = RelicDict.insert relicData.id relicData state.relicDict }

        GameStateNoOp ->
            withNoOp state

        ActivateGenerosityTrap personId relicId numDoubles ->
            let
                maybeRelic =
                    RelicDict.get relicId state.relicDict

                maybeFella =
                    PersonDict.get personId state.personDict
            in
            case ( maybeRelic, maybeFella ) of
                ( Just relicData, Just fella ) ->
                    withNoOp (activateGenerosityTrap relicData fella numDoubles state)

                _ ->
                    withNoOp state


activateGenerosityTrap : RelicData -> PersonData -> Int -> GameState -> GameState
activateGenerosityTrap relicData personData numDoubles state =
    let
        newRelicDict =
            RelicDict.remove relicData.id state.relicDict

        xpEarned =
            Relic.dropDoubleCurrentExperience relicData.rarity numDoubles

        newPerson =
            { personData | experience = personData.experience + xpEarned }

        newPersonDict =
            PersonDict.insert personData.id newPerson state.personDict
    in
    { state | relicDict = newRelicDict, personDict = newPersonDict }


executeActionOnGameState : ActionOnGamestate -> GameState -> ( GameState, Types.BackendTrigger )
executeActionOnGameState actionOnGamestate state =
    let
        modifiedState =
            updateWithRelics actionOnGamestate state
    in
    internalExecuteActionOnGameState actionOnGamestate modifiedState
