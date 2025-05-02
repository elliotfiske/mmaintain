module Gen.BackendTriggerUtil exposing ( moduleName_, withNoOp, call_, values_ )

{-|
# Generated bindings for BackendTriggerUtil

@docs moduleName_, withNoOp, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTriggerUtil" ]


{-| withNoOp: Types.GameState -> ( Types.GameState, Types.BackendTrigger ) -}
withNoOp : Elm.Expression -> Elm.Expression
withNoOp withNoOpArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTriggerUtil" ]
             , name = "withNoOp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "GameState" [] ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ withNoOpArg_ ]


call_ : { withNoOp : Elm.Expression -> Elm.Expression }
call_ =
    { withNoOp =
        \withNoOpArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTriggerUtil" ]
                     , name = "withNoOp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Types" ] "GameState" [] ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ withNoOpArg_ ]
    }


values_ : { withNoOp : Elm.Expression }
values_ =
    { withNoOp =
        Elm.value
            { importFrom = [ "BackendTriggerUtil" ]
            , name = "withNoOp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "GameState" [] ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    }