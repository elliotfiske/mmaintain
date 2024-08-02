module GameObject exposing (..)

import DirtDict exposing (DirtDict)
import GameObjectTypes exposing (..)
import PersonDict exposing (PersonDict)
import Types exposing (GameState)


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


makeDirtCleaner : DirtId -> DirtDict DirtData -> DirtDict DirtData
makeDirtCleaner id dict =
    DirtDict.update id (Maybe.map cleanDirt) dict


executeActionOnGameState : ActionOnGamestate -> GameState -> GameState
executeActionOnGameState actionOnGamestate state =
    case actionOnGamestate of
        Clean dirtId ->
            { state | dirtDict = makeDirtCleaner dirtId state.dirtDict }

        MovePerson personId direction ->
            { state | personDict = movePersonWithId personId direction state.personDict }

        AddPerson personData ->
            { state | personDict = PersonDict.insert personData.id personData state.personDict }
