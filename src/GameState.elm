module GameState exposing (..)

import DirtDict exposing (DirtDict)
import GameObjectTypes exposing (DirtData, PersonData, RelicData)
import PersonDict exposing (PersonDict)
import RelicDict exposing (RelicDict)
import Types exposing (GameState)


updateGameStatePersonDict : PersonDict PersonData -> GameState -> GameState
updateGameStatePersonDict newPersonDict state =
    { state | personDict = newPersonDict }


updateGameStateRelicDict : RelicDict RelicData -> GameState -> GameState
updateGameStateRelicDict newRelicDict state =
    { state | relicDict = newRelicDict }


updateGameStateDirtDict : DirtDict DirtData -> GameState -> GameState
updateGameStateDirtDict newDirtDict state =
    { state | dirtDict = newDirtDict }


empty : GameState
empty =
    { personDict = PersonDict.empty
    , relicDict = RelicDict.empty
    , dirtDict = DirtDict.empty
    }
