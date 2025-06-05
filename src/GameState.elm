module GameState exposing (..)

import GameObjectIds exposing (PersonId)
import GameObjectTypes
import SeqDict exposing (SeqDict)
import Types exposing (DirtByLocation, GameState, RelicsByLocation)


updateGameStatePersonDict : SeqDict PersonId GameObjectTypes.PersonData -> GameState -> GameState
updateGameStatePersonDict newPersonDict state =
    { state | personDict = newPersonDict }


updateGameStateRelicDict : RelicsByLocation -> GameState -> GameState
updateGameStateRelicDict newRelicDict state =
    { state | relicsByLocation = newRelicDict }


updateGameStateDirtDict : DirtByLocation -> GameState -> GameState
updateGameStateDirtDict newDirtDict state =
    { state | dirtByLocation = newDirtDict }


empty : GameState
empty =
    { personDict = SeqDict.empty
    , dirtByLocation = SeqDict.empty
    , relicsByLocation = SeqDict.empty
    , relicIdToLocationIndex = SeqDict.empty
    }
