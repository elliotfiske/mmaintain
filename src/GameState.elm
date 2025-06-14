module GameState exposing (..)

import GameObjectIds exposing (PersonId, RelicId)
import GameObjectTypes
import SeqDict exposing (SeqDict)
import Types exposing (DirtByLocation, GameState, RelicsByLocation)


updateGameStatePersonDict : SeqDict PersonId GameObjectTypes.PersonData -> GameState -> GameState
updateGameStatePersonDict newPersonDict state =
    { state | personDict = newPersonDict }


updateGameStateRelicDict : RelicsByLocation -> GameState -> GameState
updateGameStateRelicDict newRelicDict state =
    updateRelicState newRelicDict state


updateRelicState : RelicsByLocation -> GameState -> GameState
updateRelicState newRelicsByLocation state =
    let
        newRelicIdToLocationIndex =
            calculateRelicIdToLocationIndex newRelicsByLocation
    in
    { state
        | relicsByLocation = newRelicsByLocation
        , relicIdToLocationIndex = newRelicIdToLocationIndex
    }


calculateRelicIdToLocationIndex : RelicsByLocation -> SeqDict RelicId GameObjectTypes.RelicPosition
calculateRelicIdToLocationIndex relicsByLocation =
    relicsByLocation
        |> SeqDict.toList
        |> List.concatMap
            (\( location, relicsDict ) ->
                relicsDict
                    |> SeqDict.keys
                    |> List.map (\relicId -> ( relicId, location ))
            )
        |> SeqDict.fromList


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
