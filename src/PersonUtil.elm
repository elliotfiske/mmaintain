module PersonUtil exposing (createPerson, doIncrementCleanCount, doIncrementClearCount, movePersonWithId)

import GameObjectIds exposing (PersonId)
import GameObjectTypes exposing (..)
import PointUtil
import SeqDict exposing (SeqDict)
import Util


movePerson : GameObjectTypes.Direction -> GameObjectTypes.PersonData -> GameObjectTypes.PersonData
movePerson direction person =
    let
        destination =
            PointUtil.newPoint direction person.position

        tooLow =
            destination.y < Util.yOrigin || destination.x < Util.xOrigin

        tooHigh =
            destination.y >= Util.mapYMax || destination.x >= Util.mapXMax
    in
    if tooLow || tooHigh then
        -- out of bounds, don't complete the move
        person

    else
        { person | position = PointUtil.newPoint direction person.position }


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
    , bestHighFiveBoost = Nothing
    , skillTree =
        { root = False
        , learned = False
        , relicHunter = False
        , swiftCleaning = False
        , cleaningFundamentals = False
        , powerCleaning = False
        }
    }


movePersonWithId : PersonId -> Direction -> SeqDict PersonId PersonData -> SeqDict PersonId PersonData
movePersonWithId id direction dict =
    SeqDict.update id (Maybe.map (movePerson direction)) dict


doIncrementCleanCount : PersonData -> PersonData
doIncrementCleanCount person =
    let
        stats =
            person.stats

        newStats =
            { stats | cleanCount = stats.cleanCount + 1 }
    in
    { person | stats = newStats }


doIncrementClearCount : PersonData -> PersonData
doIncrementClearCount person =
    let
        stats =
            person.stats

        newStats =
            { stats | clearCount = stats.clearCount + 1 }
    in
    { person | stats = newStats }
