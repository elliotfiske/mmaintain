module Gen.Backend exposing (annotation_, call_, forwardToEveryoneButMe, init, moduleName_, subscriptions, update, updateFromFrontend, values_)

{-| 
@docs moduleName_, forwardToEveryoneButMe, updateFromFrontend, update, init, subscriptions, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Backend" ]


{-| forwardToEveryoneButMe: 
    GameObjectTypes.ActionOnGamestate
    -> Lamdera.ClientId
    -> Backend.Model
    -> Backend.Cmd Backend.BackendMsg
-}
forwardToEveryoneButMe :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
forwardToEveryoneButMe forwardToEveryoneButMeArg forwardToEveryoneButMeArg0 forwardToEveryoneButMeArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Backend" ]
             , name = "forwardToEveryoneButMe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameObjectTypes" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith [ "Lamdera" ] "ClientId" []
                          , Type.namedWith [ "Backend" ] "Model" []
                          ]
                          (Type.namedWith
                               [ "Backend" ]
                               "Cmd"
                               [ Type.namedWith [ "Backend" ] "BackendMsg" [] ]
                          )
                     )
             }
        )
        [ forwardToEveryoneButMeArg
        , forwardToEveryoneButMeArg0
        , forwardToEveryoneButMeArg1
        ]


{-| updateFromFrontend: 
    Lamdera.SessionId
    -> Lamdera.ClientId
    -> Backend.ToBackend
    -> Backend.Model
    -> ( Backend.Model, Backend.Cmd Backend.BackendMsg )
-}
updateFromFrontend :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
updateFromFrontend updateFromFrontendArg updateFromFrontendArg0 updateFromFrontendArg1 updateFromFrontendArg2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Backend" ]
             , name = "updateFromFrontend"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Lamdera" ] "SessionId" []
                          , Type.namedWith [ "Lamdera" ] "ClientId" []
                          , Type.namedWith [ "Backend" ] "ToBackend" []
                          , Type.namedWith [ "Backend" ] "Model" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Backend" ] "Model" [])
                               (Type.namedWith
                                    [ "Backend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Backend" ]
                                        "BackendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ updateFromFrontendArg
        , updateFromFrontendArg0
        , updateFromFrontendArg1
        , updateFromFrontendArg2
        ]


{-| update: 
    Backend.BackendMsg
    -> Backend.Model
    -> ( Backend.Model, Backend.Cmd Backend.BackendMsg )
-}
update : Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg updateArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Backend" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Backend" ] "BackendMsg" []
                          , Type.namedWith [ "Backend" ] "Model" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Backend" ] "Model" [])
                               (Type.namedWith
                                    [ "Backend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Backend" ]
                                        "BackendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ updateArg, updateArg0 ]


{-| init: ( Backend.Model, Backend.Cmd Backend.BackendMsg ) -}
init : Elm.Expression
init =
    Elm.value
        { importFrom = [ "Backend" ]
        , name = "init"
        , annotation =
            Just
                (Type.tuple
                     (Type.namedWith [ "Backend" ] "Model" [])
                     (Type.namedWith
                          [ "Backend" ]
                          "Cmd"
                          [ Type.namedWith [ "Backend" ] "BackendMsg" [] ]
                     )
                )
        }


{-| subscriptions: a -> Backend.Sub Backend.BackendMsg -}
subscriptions : Elm.Expression -> Elm.Expression
subscriptions subscriptionsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Backend" ]
             , name = "subscriptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "Backend" ]
                               "Sub"
                               [ Type.namedWith [ "Backend" ] "BackendMsg" [] ]
                          )
                     )
             }
        )
        [ subscriptionsArg ]


annotation_ : { model : Type.Annotation }
annotation_ =
    { model =
        Type.alias
            moduleName_
            "Model"
            []
            (Type.namedWith [ "Backend" ] "BackendModel" [])
    }


call_ :
    { forwardToEveryoneButMe :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateFromFrontend :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression -> Elm.Expression
    , subscriptions : Elm.Expression -> Elm.Expression
    }
call_ =
    { forwardToEveryoneButMe =
        \forwardToEveryoneButMeArg forwardToEveryoneButMeArg0 forwardToEveryoneButMeArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Backend" ]
                     , name = "forwardToEveryoneButMe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith [ "Lamdera" ] "ClientId" []
                                  , Type.namedWith [ "Backend" ] "Model" []
                                  ]
                                  (Type.namedWith
                                       [ "Backend" ]
                                       "Cmd"
                                       [ Type.namedWith
                                           [ "Backend" ]
                                           "BackendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ forwardToEveryoneButMeArg
                , forwardToEveryoneButMeArg0
                , forwardToEveryoneButMeArg1
                ]
    , updateFromFrontend =
        \updateFromFrontendArg updateFromFrontendArg0 updateFromFrontendArg1 updateFromFrontendArg2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Backend" ]
                     , name = "updateFromFrontend"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Lamdera" ] "SessionId" []
                                  , Type.namedWith [ "Lamdera" ] "ClientId" []
                                  , Type.namedWith [ "Backend" ] "ToBackend" []
                                  , Type.namedWith [ "Backend" ] "Model" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Backend" ] "Model" [])
                                       (Type.namedWith
                                            [ "Backend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Backend" ]
                                                "BackendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ updateFromFrontendArg
                , updateFromFrontendArg0
                , updateFromFrontendArg1
                , updateFromFrontendArg2
                ]
    , update =
        \updateArg updateArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Backend" ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Backend" ] "BackendMsg" []
                                  , Type.namedWith [ "Backend" ] "Model" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Backend" ] "Model" [])
                                       (Type.namedWith
                                            [ "Backend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Backend" ]
                                                "BackendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ updateArg, updateArg0 ]
    , subscriptions =
        \subscriptionsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Backend" ]
                     , name = "subscriptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "Backend" ]
                                       "Sub"
                                       [ Type.namedWith
                                           [ "Backend" ]
                                           "BackendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ subscriptionsArg ]
    }


values_ :
    { forwardToEveryoneButMe : Elm.Expression
    , updateFromFrontend : Elm.Expression
    , update : Elm.Expression
    , init : Elm.Expression
    , subscriptions : Elm.Expression
    }
values_ =
    { forwardToEveryoneButMe =
        Elm.value
            { importFrom = [ "Backend" ]
            , name = "forwardToEveryoneButMe"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameObjectTypes" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith [ "Lamdera" ] "ClientId" []
                         , Type.namedWith [ "Backend" ] "Model" []
                         ]
                         (Type.namedWith
                              [ "Backend" ]
                              "Cmd"
                              [ Type.namedWith [ "Backend" ] "BackendMsg" [] ]
                         )
                    )
            }
    , updateFromFrontend =
        Elm.value
            { importFrom = [ "Backend" ]
            , name = "updateFromFrontend"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Lamdera" ] "SessionId" []
                         , Type.namedWith [ "Lamdera" ] "ClientId" []
                         , Type.namedWith [ "Backend" ] "ToBackend" []
                         , Type.namedWith [ "Backend" ] "Model" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Backend" ] "Model" [])
                              (Type.namedWith
                                   [ "Backend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Backend" ]
                                       "BackendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , update =
        Elm.value
            { importFrom = [ "Backend" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Backend" ] "BackendMsg" []
                         , Type.namedWith [ "Backend" ] "Model" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Backend" ] "Model" [])
                              (Type.namedWith
                                   [ "Backend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Backend" ]
                                       "BackendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , init =
        Elm.value
            { importFrom = [ "Backend" ]
            , name = "init"
            , annotation =
                Just
                    (Type.tuple
                         (Type.namedWith [ "Backend" ] "Model" [])
                         (Type.namedWith
                              [ "Backend" ]
                              "Cmd"
                              [ Type.namedWith [ "Backend" ] "BackendMsg" [] ]
                         )
                    )
            }
    , subscriptions =
        Elm.value
            { importFrom = [ "Backend" ]
            , name = "subscriptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "Backend" ]
                              "Sub"
                              [ Type.namedWith [ "Backend" ] "BackendMsg" [] ]
                         )
                    )
            }
    }