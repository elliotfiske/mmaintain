module GameState exposing (..)

import Dict exposing (Dict)
import DirtDict exposing (DirtDict)
import GameObjectTypes
import PersonDict exposing (PersonDict)
import Types exposing (GameState)


updateGameStatePersonDict : PersonDict GameObjectTypes.PersonData -> GameState -> GameState
updateGameStatePersonDict newPersonDict state =
    { state | personDict = newPersonDict }


updateGameStateRelicDict : Dict Types.RelicLocation Types.RealRelicDict -> GameState -> GameState
updateGameStateRelicDict newRelicDict state =
    { state | relicsByPosition = newRelicDict }


updateGameStateDirtDict : DirtDict GameObjectTypes.DirtData -> GameState -> GameState
updateGameStateDirtDict newDirtDict state =
    { state | dirtDict = newDirtDict }


empty : GameState
empty =
    { personDict = PersonDict.empty
    , dirtDict = DirtDict.empty
    , relicsByPosition = Dict.empty
    }
