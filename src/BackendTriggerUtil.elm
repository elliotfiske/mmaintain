module BackendTriggerUtil exposing (withNoOp)

import Types exposing (BackendTrigger(..), GameState)


withNoOp : GameState -> ( GameState, Types.BackendTrigger )
withNoOp state =
    ( state, NoOpBackendTrigger )
