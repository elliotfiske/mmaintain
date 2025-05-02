module Gen.Modals exposing ( moduleName_, render, call_, values_ )

{-|
# Generated bindings for Modals

@docs moduleName_, render, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Modals" ]


{-| render: 
    Modals.FrontendPlayingState
    -> Modals.PersonData
    -> Modals.Html Modals.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression -> Elm.Expression
render renderArg_ renderArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Modals" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Modals" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "Modals" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Modals" ]
                               "Html"
                               [ Type.namedWith [ "Modals" ] "FrontendMsg" [] ]
                          )
                     )
             }
        )
        [ renderArg_, renderArg_0 ]


call_ : { render : Elm.Expression -> Elm.Expression -> Elm.Expression }
call_ =
    { render =
        \renderArg_ renderArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Modals" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Modals" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith [ "Modals" ] "PersonData" []
                                  ]
                                  (Type.namedWith
                                       [ "Modals" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Modals" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderArg_, renderArg_0 ]
    }


values_ : { render : Elm.Expression }
values_ =
    { render =
        Elm.value
            { importFrom = [ "Modals" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Modals" ] "FrontendPlayingState" []
                         , Type.namedWith [ "Modals" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Modals" ]
                              "Html"
                              [ Type.namedWith [ "Modals" ] "FrontendMsg" [] ]
                         )
                    )
            }
    }