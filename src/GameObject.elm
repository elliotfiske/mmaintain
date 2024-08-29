module GameObject exposing (..)

import DirtDict exposing (DirtDict)
import GameObjectTypes exposing (..)
import PersonDict exposing (PersonDict)
import RelicDict
import Types exposing (GameState, RealDirtDict)


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


createPerson : PersonId -> String -> PersonData
createPerson id name =
    { id = id
    , name = name
    , experience = 0
    , x = 0
    , y = 0
    }


movePersonWithId : PersonId -> Direction -> PersonDict PersonData -> PersonDict PersonData
movePersonWithId id direction dict =
    PersonDict.update id (Maybe.map (movePerson direction)) dict


cleanDirt : DirtData -> DirtData
cleanDirt dirt =
    { dirt | amount = dirt.amount - 1 }


setDirtAmount : Int -> DirtData -> DirtData
setDirtAmount amount dirt =
    { dirt | amount = amount }


makeDirtCleaner : DirtId -> DirtDict DirtData -> DirtDict DirtData
makeDirtCleaner id dict =
    DirtDict.update id (Maybe.map cleanDirt) dict


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


executeActionOnGameState : ActionOnGamestate -> GameState -> GameState
executeActionOnGameState actionOnGamestate state =
    case actionOnGamestate of
        Clean dirtId ->
            { state | dirtDict = makeDirtCleaner dirtId state.dirtDict }

        MovePerson personId direction ->
            { state | personDict = movePersonWithId personId direction state.personDict }

        AddPerson personData ->
            { state | personDict = PersonDict.insert personData.id personData state.personDict }

        PickUpRelic relicId personId ->
            { state | relicDict = RelicDict.update relicId (Maybe.map (pickUpRelic personId)) state.relicDict }

        ChangeDirtAmount dirtId int ->
            { state | dirtDict = changeDirtAmount dirtId int state.dirtDict }

        AddDirt dirtData ->
            { state | dirtDict = DirtDict.insert dirtData.id dirtData state.dirtDict }

        BatchAction actionList ->
            List.foldl executeActionOnGameState state actionList

        GameStateNoOp ->
            state
