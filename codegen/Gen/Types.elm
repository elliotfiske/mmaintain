module Gen.Types exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Types" ]


annotation_ :
    { backendModel : Type.Annotation
    , frontendModel : Type.Annotation
    , toFrontend : Type.Annotation
    , backendMsg : Type.Annotation
    , toBackend : Type.Annotation
    , frontendMsg : Type.Annotation
    , frontendState : Type.Annotation
    }
annotation_ =
    { backendModel =
        Type.alias
            moduleName_
            "BackendModel"
            []
            (Type.record
                 [ ( "gameObjects"
                   , Type.namedWith
                         [ "GameObjectDict" ]
                         "GameObjectDict"
                         [ Type.namedWith [ "Types" ] "GameObject" [] ]
                   )
                 , ( "connectedClients"
                   , Type.list (Type.namedWith [ "Lamdera" ] "ClientId" [])
                   )
                 ]
            )
    , frontendModel =
        Type.alias
            moduleName_
            "FrontendModel"
            []
            (Type.record
                 [ ( "key"
                   , Type.namedWith [ "Browser", "Navigation" ] "Key" []
                   )
                 , ( "state", Type.namedWith [ "Types" ] "FrontendState" [] )
                 ]
            )
    , toFrontend = Type.namedWith [ "Types" ] "ToFrontend" []
    , backendMsg = Type.namedWith [ "Types" ] "BackendMsg" []
    , toBackend = Type.namedWith [ "Types" ] "ToBackend" []
    , frontendMsg = Type.namedWith [ "Types" ] "FrontendMsg" []
    , frontendState = Type.namedWith [ "Types" ] "FrontendState" []
    }


make_ :
    { backendModel :
        { gameObjects : Elm.Expression, connectedClients : Elm.Expression }
        -> Elm.Expression
    , frontendModel :
        { key : Elm.Expression, state : Elm.Expression } -> Elm.Expression
    , noOpToFrontend : Elm.Expression
    , otherClientPerformedAction : Elm.Expression -> Elm.Expression
    , updateFullState : Elm.Expression -> Elm.Expression -> Elm.Expression
    , noOpBackendMsg : Elm.Expression
    , clientConnected : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clientDisconnected : Elm.Expression -> Elm.Expression -> Elm.Expression
    , noOpToBackend : Elm.Expression
    , clientPerformsAction : Elm.Expression -> Elm.Expression
    , urlClicked : Elm.Expression -> Elm.Expression
    , urlChanged : Elm.Expression -> Elm.Expression
    , noOpFrontendMsg : Elm.Expression
    , performAction : Elm.Expression -> Elm.Expression
    , loading : Elm.Expression
    , playing : Elm.Expression -> Elm.Expression
    , error : Elm.Expression -> Elm.Expression
    }
make_ =
    { backendModel =
        \backendModel_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "BackendModel"
                     []
                     (Type.record
                          [ ( "gameObjects"
                            , Type.namedWith
                                  [ "GameObjectDict" ]
                                  "GameObjectDict"
                                  [ Type.namedWith [ "Types" ] "GameObject" [] ]
                            )
                          , ( "connectedClients"
                            , Type.list
                                  (Type.namedWith [ "Lamdera" ] "ClientId" [])
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "gameObjects" backendModel_args.gameObjects
                     , Tuple.pair
                         "connectedClients"
                         backendModel_args.connectedClients
                     ]
                )
    , frontendModel =
        \frontendModel_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "FrontendModel"
                     []
                     (Type.record
                          [ ( "key"
                            , Type.namedWith
                                  [ "Browser", "Navigation" ]
                                  "Key"
                                  []
                            )
                          , ( "state"
                            , Type.namedWith [ "Types" ] "FrontendState" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "key" frontendModel_args.key
                     , Tuple.pair "state" frontendModel_args.state
                     ]
                )
    , noOpToFrontend =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpToFrontend"
            , annotation = Just (Type.namedWith [] "ToFrontend" [])
            }
    , otherClientPerformedAction =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "OtherClientPerformedAction"
                     , annotation = Just (Type.namedWith [] "ToFrontend" [])
                     }
                )
                [ ar0 ]
    , updateFullState =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "UpdateFullState"
                     , annotation = Just (Type.namedWith [] "ToFrontend" [])
                     }
                )
                [ ar0, ar1 ]
    , noOpBackendMsg =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpBackendMsg"
            , annotation = Just (Type.namedWith [] "BackendMsg" [])
            }
    , clientConnected =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ClientConnected"
                     , annotation = Just (Type.namedWith [] "BackendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , clientDisconnected =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ClientDisconnected"
                     , annotation = Just (Type.namedWith [] "BackendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , noOpToBackend =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpToBackend"
            , annotation = Just (Type.namedWith [] "ToBackend" [])
            }
    , clientPerformsAction =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ClientPerformsAction"
                     , annotation = Just (Type.namedWith [] "ToBackend" [])
                     }
                )
                [ ar0 ]
    , urlClicked =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "UrlClicked"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , urlChanged =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "UrlChanged"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , noOpFrontendMsg =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpFrontendMsg"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , performAction =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "PerformAction"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , loading =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "Loading"
            , annotation = Just (Type.namedWith [] "FrontendState" [])
            }
    , playing =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "Playing"
                     , annotation = Just (Type.namedWith [] "FrontendState" [])
                     }
                )
                [ ar0 ]
    , error =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "Error"
                     , annotation = Just (Type.namedWith [] "FrontendState" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { toFrontend :
        Elm.Expression
        -> { toFrontendTags_0_0
            | noOpToFrontend : Elm.Expression
            , otherClientPerformedAction : Elm.Expression -> Elm.Expression
            , updateFullState :
                Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , backendMsg :
        Elm.Expression
        -> { backendMsgTags_1_0
            | noOpBackendMsg : Elm.Expression
            , clientConnected :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , clientDisconnected :
                Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , toBackend :
        Elm.Expression
        -> { toBackendTags_2_0
            | noOpToBackend : Elm.Expression
            , clientPerformsAction : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , frontendMsg :
        Elm.Expression
        -> { frontendMsgTags_3_0
            | urlClicked : Elm.Expression -> Elm.Expression
            , urlChanged : Elm.Expression -> Elm.Expression
            , noOpFrontendMsg : Elm.Expression
            , performAction : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , frontendState :
        Elm.Expression
        -> { frontendStateTags_4_0
            | loading : Elm.Expression
            , playing : Elm.Expression -> Elm.Expression
            , error : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { toFrontend =
        \toFrontendExpression toFrontendTags ->
            Elm.Case.custom
                toFrontendExpression
                (Type.namedWith [ "Types" ] "ToFrontend" [])
                [ Elm.Case.branch0
                    "NoOpToFrontend"
                    toFrontendTags.noOpToFrontend
                , Elm.Case.branch1
                    "OtherClientPerformedAction"
                    ( "typesActionOnGamestate"
                    , Type.namedWith [ "Types" ] "ActionOnGamestate" []
                    )
                    toFrontendTags.otherClientPerformedAction
                , Elm.Case.branch2
                    "UpdateFullState"
                    ( "gameObjectDictGameObjectDict"
                    , Type.namedWith
                          [ "GameObjectDict" ]
                          "GameObjectDict"
                          [ Type.namedWith [ "Types" ] "GameObject" [] ]
                    )
                    ( "typesGameObjectId"
                    , Type.namedWith [ "Types" ] "GameObjectId" []
                    )
                    toFrontendTags.updateFullState
                ]
    , backendMsg =
        \backendMsgExpression backendMsgTags ->
            Elm.Case.custom
                backendMsgExpression
                (Type.namedWith [ "Types" ] "BackendMsg" [])
                [ Elm.Case.branch0
                    "NoOpBackendMsg"
                    backendMsgTags.noOpBackendMsg
                , Elm.Case.branch2
                    "ClientConnected"
                    ( "lamderaSessionId"
                    , Type.namedWith [ "Lamdera" ] "SessionId" []
                    )
                    ( "lamderaClientId"
                    , Type.namedWith [ "Lamdera" ] "ClientId" []
                    )
                    backendMsgTags.clientConnected
                , Elm.Case.branch2
                    "ClientDisconnected"
                    ( "lamderaSessionId"
                    , Type.namedWith [ "Lamdera" ] "SessionId" []
                    )
                    ( "lamderaClientId"
                    , Type.namedWith [ "Lamdera" ] "ClientId" []
                    )
                    backendMsgTags.clientDisconnected
                ]
    , toBackend =
        \toBackendExpression toBackendTags ->
            Elm.Case.custom
                toBackendExpression
                (Type.namedWith [ "Types" ] "ToBackend" [])
                [ Elm.Case.branch0 "NoOpToBackend" toBackendTags.noOpToBackend
                , Elm.Case.branch1
                    "ClientPerformsAction"
                    ( "typesActionOnGamestate"
                    , Type.namedWith [ "Types" ] "ActionOnGamestate" []
                    )
                    toBackendTags.clientPerformsAction
                ]
    , frontendMsg =
        \frontendMsgExpression frontendMsgTags ->
            Elm.Case.custom
                frontendMsgExpression
                (Type.namedWith [ "Types" ] "FrontendMsg" [])
                [ Elm.Case.branch1
                    "UrlClicked"
                    ( "browserUrlRequest"
                    , Type.namedWith [ "Browser" ] "UrlRequest" []
                    )
                    frontendMsgTags.urlClicked
                , Elm.Case.branch1
                    "UrlChanged"
                    ( "urlUrl", Type.namedWith [ "Url" ] "Url" [] )
                    frontendMsgTags.urlChanged
                , Elm.Case.branch0
                    "NoOpFrontendMsg"
                    frontendMsgTags.noOpFrontendMsg
                , Elm.Case.branch1
                    "PerformAction"
                    ( "typesActionOnGamestate"
                    , Type.namedWith [ "Types" ] "ActionOnGamestate" []
                    )
                    frontendMsgTags.performAction
                ]
    , frontendState =
        \frontendStateExpression frontendStateTags ->
            Elm.Case.custom
                frontendStateExpression
                (Type.namedWith [ "Types" ] "FrontendState" [])
                [ Elm.Case.branch0 "Loading" frontendStateTags.loading
                , Elm.Case.branch1
                    "Playing"
                    ( "one"
                    , Type.record
                          [ ( "gameObjects"
                            , Type.namedWith
                                  [ "GameObjectDict" ]
                                  "GameObjectDict"
                                  [ Type.namedWith [ "Types" ] "GameObject" [] ]
                            )
                          , ( "myId"
                            , Type.namedWith [ "Types" ] "GameObjectId" []
                            )
                          ]
                    )
                    frontendStateTags.playing
                , Elm.Case.branch1
                    "Error"
                    ( "stringString", Type.string )
                    frontendStateTags.error
                ]
    }