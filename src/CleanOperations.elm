module CleanOperations exposing (doClean)

import Dict
import GameObjectTypes exposing (..)
import GameState
import PersonDict exposing (PersonDict)
import Types exposing (BackendTrigger(..), DirtLocation, GameState)


doClean : PersonId -> Point -> Int -> GameState -> ( GameState, Types.BackendTrigger )
doClean personId location strength state =
    case Dict.get (pointToDirtLocation location) state.dirtByLocation of
        Nothing ->
            -- This might happen if the user is lagging and someone else cleared the dirt
            ( state, NoOpBackendTrigger )

        Just dirtData ->
            cleanDirt personId dirtData strength state


cleanDirt : PersonId -> DirtData -> Int -> GameState -> ( GameState, Types.BackendTrigger )
cleanDirt personId dirtData strength state =
    let
        newDirt =
            reduceDirtAmount strength dirtData
    in
    if newDirt.amount <= 0 then
        destroyDirt personId dirtData state

    else
        makeDirtSmaller personId newDirt state


makeDirtSmaller : PersonId -> DirtData -> GameState -> ( GameState, Types.BackendTrigger )
makeDirtSmaller personId newDirt state =
    let
        newDirtDict =
            Dict.insert (pointToDirtLocation newDirt.position) newDirt state.dirtByLocation
    in
    ( { state | dirtByLocation = newDirtDict }, NoOpBackendTrigger )


destroyDirt : PersonId -> DirtData -> GameState -> ( GameState, Types.BackendTrigger )
destroyDirt personId dirtData state =
    let
        newDirtDict =
            Dict.remove (pointToDirtLocation dirtData.position) state.dirtByLocation

        newPersonDict =
            state.personDict
                |> incrementClearCount personId

        newState =
            state
                |> GameState.updateGameStateDirtDict newDirtDict
                |> GameState.updateGameStatePersonDict newPersonDict
    in
    ( newState, ClearedPollution personId dirtData )


pointToDirtLocation : Point -> DirtLocation
pointToDirtLocation point =
    ( point.x, point.y )


reduceDirtAmount : Int -> DirtData -> DirtData
reduceDirtAmount cleanStrength dirt =
    { dirt | amount = dirt.amount - cleanStrength }


incrementClearCount : PersonId -> PersonDict PersonData -> PersonDict PersonData
incrementClearCount personId dict =
    PersonDict.update personId (Maybe.map doIncrementClearCount) dict


doIncrementClearCount : PersonData -> PersonData
doIncrementClearCount person =
    let
        stats =
            person.stats

        newStats =
            { stats | clearCount = stats.clearCount + 1 }
    in
    { person | stats = newStats }
