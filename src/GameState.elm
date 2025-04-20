module GameState exposing (..)

import DirtDict exposing (DirtDict)
import Dict exposing (Dict)
import GameObjectTypes
import PersonDict exposing (PersonDict)
import Types exposing (GameState)


updateGameStatePersonDict : PersonDict GameObjectTypes.PersonData -> GameState -> GameState
updateGameStatePersonDict newPersonDict state =
    { state | personDict = newPersonDict }


updateGameStateRelicDict : Dict Types.RelicLocation Types.RealRelicDict -> GameState -> GameState
updateGameStateRelicDict newRelicDict state =
    { state | relicsByPosition = newRelicDict }


updateGameStateDirtDict : Dict Types.DirtLocation GameObjectTypes.DirtData -> GameState -> GameState
updateGameStateDirtDict newDirtDict state =
    { state | dirtByLocation = newDirtDict }


empty : GameState
empty =
    { personDict = PersonDict.empty
    , dirtByLocation = Dict.empty
    , relicsByPosition = Dict.empty
    }
