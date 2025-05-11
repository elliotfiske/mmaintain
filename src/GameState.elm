module GameState exposing (..)

import Dict exposing (Dict)
import DirtDict exposing (DirtDict)
import GameObjectIds exposing (PersonId)
import GameObjectTypes
import SeqDict exposing (SeqDict)
import Types exposing (GameState)


updateGameStatePersonDict : SeqDict PersonId GameObjectTypes.PersonData -> GameState -> GameState
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
    { personDict = SeqDict.empty
    , dirtByLocation = Dict.empty
    , relicsByPosition = Dict.empty
    }
