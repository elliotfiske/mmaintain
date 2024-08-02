module Gen.Frontend exposing (annotation_, call_, init, moduleName_, update, updateFromBackend, values_, view)

{-| 
@docs moduleName_, view, updateFromBackend, update, init, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Frontend" ]


{-| view: Frontend.Model -> Browser.Document Frontend.FrontendMsg -}
view : Elm.Expression -> Elm.Expression
view viewArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "view"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" [] ]
                          (Type.namedWith
                               [ "Browser" ]
                               "Document"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ viewArg ]


{-| updateFromBackend: 
    Frontend.ToFrontend
    -> Frontend.Model
    -> ( Frontend.Model, Frontend.Cmd Frontend.FrontendMsg )
-}
updateFromBackend : Elm.Expression -> Elm.Expression -> Elm.Expression
updateFromBackend updateFromBackendArg updateFromBackendArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updateFromBackend"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "ToFrontend" []
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Frontend" ] "Model" [])
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ updateFromBackendArg, updateFromBackendArg0 ]


{-| update: 
    Frontend.FrontendMsg
    -> Frontend.Model
    -> ( Frontend.Model, Frontend.Cmd Frontend.FrontendMsg )
-}
update : Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg updateArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Frontend" ] "Model" [])
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ updateArg, updateArg0 ]


{-| init: 
    Url.Url
    -> Browser.Navigation.Key
    -> ( Frontend.Model, Frontend.Cmd Frontend.FrontendMsg )
-}
init : Elm.Expression -> Elm.Expression -> Elm.Expression
init initArg initArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Url" ] "Url" []
                          , Type.namedWith [ "Browser", "Navigation" ] "Key" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Frontend" ] "Model" [])
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ initArg, initArg0 ]


annotation_ : { model : Type.Annotation }
annotation_ =
    { model =
        Type.alias
            moduleName_
            "Model"
            []
            (Type.namedWith [ "Frontend" ] "FrontendModel" [])
    }


call_ :
    { view : Elm.Expression -> Elm.Expression
    , updateFromBackend : Elm.Expression -> Elm.Expression -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression -> Elm.Expression
    , init : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { view =
        \viewArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "view"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" [] ]
                                  (Type.namedWith
                                       [ "Browser" ]
                                       "Document"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ viewArg ]
    , updateFromBackend =
        \updateFromBackendArg updateFromBackendArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updateFromBackend"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "ToFrontend"
                                      []
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Frontend" ] "Model" []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ updateFromBackendArg, updateFromBackendArg0 ]
    , update =
        \updateArg updateArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendMsg"
                                      []
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Frontend" ] "Model" []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ updateArg, updateArg0 ]
    , init =
        \initArg initArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Url" ] "Url" []
                                  , Type.namedWith
                                      [ "Browser", "Navigation" ]
                                      "Key"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Frontend" ] "Model" []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ initArg, initArg0 ]
    }


values_ :
    { view : Elm.Expression
    , updateFromBackend : Elm.Expression
    , update : Elm.Expression
    , init : Elm.Expression
    }
values_ =
    { view =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "view"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" [] ]
                         (Type.namedWith
                              [ "Browser" ]
                              "Document"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , updateFromBackend =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updateFromBackend"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "ToFrontend" []
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Frontend" ] "Model" [])
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , update =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Frontend" ] "Model" [])
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , init =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Url" ] "Url" []
                         , Type.namedWith [ "Browser", "Navigation" ] "Key" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Frontend" ] "Model" [])
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    }