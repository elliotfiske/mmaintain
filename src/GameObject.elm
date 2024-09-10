module GameObject exposing (..)

import DirtDict exposing (DirtDict)
import GameObjectTypes exposing (..)
import PersonDict exposing (PersonDict)
import RelicDict
import Types exposing (GameState, RealDirtDict, RealRelicDict)


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
    , x = 0
    , y = 0
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


makeDirtCleaner : Maybe DirtData -> DirtDict DirtData -> DirtDict DirtData
makeDirtCleaner dirtData dict =
    case dirtData of
        Nothing ->
            dict

        Just dirt ->
            updateDirtOrRemoveEmpty dirt dict


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


updateDirtOrRemoveEmpty : DirtData -> DirtDict DirtData -> DirtDict DirtData
updateDirtOrRemoveEmpty dirt dict =
    if dirt.amount <= 0 then
        DirtDict.remove dirt.id dict

    else
        DirtDict.insert dirt.id dirt dict


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
        |> List.head


relicHolder : RelicData -> Maybe PersonId
relicHolder relic =
    case relic.position of
        HeldBy personId ->
            Just personId

        OnFloor _ _ ->
            Nothing


relicModifiesAction : RelicData -> ActionOnGamestate -> ActionOnGamestate
relicModifiesAction relic action =
    case relic.relicType of
        CleanFast ->
            case action of
                Clean personId dirtId strength ->
                    if Just personId == relicHolder relic then
                        Clean personId dirtId (strength * 2)

                    else
                        action

                _ ->
                    action

        MoreXP ->
            -- unimplemented
            action


relicName : RelicType -> String
relicName relicType =
    case relicType of
        CleanFast ->
            "Clean Fast!"

        MoreXP ->
            "More XP!"


updateWithRelics : ActionOnGamestate -> GameState -> ActionOnGamestate
updateWithRelics action state =
    RelicDict.values state.relicDict
        |> List.foldl relicModifiesAction action


doClean : PersonId -> DirtId -> Int -> GameState -> ( GameState, ActionOnGamestate )
doClean personId dirtId strength state =
    case DirtDict.get dirtId state.dirtDict of
        Nothing ->
            -- TODO: Log error? Attempted to clean dirt not in dictionary.
            ( state, GameStateNoOp )

        Just dirtData ->
            let
                newDirt =
                    cleanDirt strength dirtData

                nextAction =
                    if newDirt.amount <= 0 then
                        ClearedPollution personId dirtData

                    else
                        GameStateNoOp
            in
            ( { state | dirtDict = DirtDict.insert dirtId newDirt state.dirtDict }
            , nextAction
            )


addCleanStats : PersonId -> GameState -> GameState
addCleanStats personId state =
    { state | personDict = incrementCleanCount personId state.personDict }


addClearStats : PersonId -> GameState -> GameState
addClearStats personId state =
    { state | personDict = incrementClearCount personId state.personDict }


withNoOp : GameState -> ( GameState, ActionOnGamestate )
withNoOp state =
    ( state, GameStateNoOp )


internalExecuteActionOnGameState : ActionOnGamestate -> GameState -> ( GameState, ActionOnGamestate )
internalExecuteActionOnGameState action state =
    case action of
        Clean personId dirtId strength ->
            state
                |> addCleanStats personId
                |> doClean personId dirtId strength

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
            -- TODO: Cool helper function like "return state unchanged if either of these are Nothing, otherwise execute update". I think I may do this a lot.
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

        ClearedPollution personId dirtData ->
            let
                newRelic =
                    { id = GameObjectTypes.RelicId (RelicDict.size state.relicDict * 11), relicType = GameObjectTypes.CleanFast, position = GameObjectTypes.OnFloor dirtData.x dirtData.y }

                newDirtDict =
                    DirtDict.remove dirtData.id state.dirtDict
            in
            ( addClearStats personId { state | dirtDict = newDirtDict }
            , AddRelic newRelic
            )


executeActionOnGameState : ActionOnGamestate -> GameState -> GameState
executeActionOnGameState actionOnGamestate state =
    case internalExecuteActionOnGameState (updateWithRelics actionOnGamestate state) state of
        ( newState, GameStateNoOp ) ->
            newState

        ( newState, nextAction ) ->
            executeActionOnGameState nextAction newState
