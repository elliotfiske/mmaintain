module Gen.MapRenderer exposing ( moduleName_, render, call_, values_ )

{-|
# Generated bindings for MapRenderer

@docs moduleName_, render, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "MapRenderer" ]


{-| render: 
    MapRenderer.FrontendPlayingState
    -> MapRenderer.PersonData
    -> Html.Html MapRenderer.FrontendMsg
-}
render : Elm.Expression -> Elm.Expression -> Elm.Expression
render renderArg_ renderArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "MapRenderer" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "MapRenderer" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "MapRenderer" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith
                                   [ "MapRenderer" ]
                                   "FrontendMsg"
                                   []
                               ]
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
                     { importFrom = [ "MapRenderer" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "MapRenderer" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "MapRenderer" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "MapRenderer" ]
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
            { importFrom = [ "MapRenderer" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "MapRenderer" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "MapRenderer" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith
                                  [ "MapRenderer" ]
                                  "FrontendMsg"
                                  []
                              ]
                         )
                    )
            }
    }