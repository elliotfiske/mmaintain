module CleanOperations exposing (cleanDirt, doClean)

import Dict
import GameObjectTypes exposing (..)
import Types exposing (BackendTrigger(..), DirtByLocation, DirtLocation, GameState)


pointToDirtLocation : Point -> DirtLocation
pointToDirtLocation point =
    ( point.x, point.y )


cleanDirt : Int -> DirtData -> DirtData
cleanDirt cleanStrength dirt =
    { dirt | amount = dirt.amount - cleanStrength }


doClean : PersonId -> Point -> Int -> GameState -> ( GameState, Types.BackendTrigger )
doClean personId location strength state =
    case Dict.get (pointToDirtLocation location) state.dirtByLocation of
        Nothing ->
            -- This might happen if the user is lagging and someone else cleared the dirt
            ( state, NoOpBackendTrigger )

        Just dirtData ->
            let
                newDirt =
                    cleanDirt strength dirtData

                backendTrigger =
                    if newDirt.amount <= 0 then
                        ClearedPollution personId dirtData

                    else
                        NoOpBackendTrigger

                newDict =
                    if newDirt.amount <= 0 then
                        Dict.remove (pointToDirtLocation dirtData.position) state.dirtByLocation

                    else
                        Dict.insert (pointToDirtLocation dirtData.position) newDirt state.dirtByLocation
            in
            ( { state | dirtByLocation = newDict }
            , backendTrigger
            )
