module Gen.Evergreen.V1.Types exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Evergreen.V1.Types

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Evergreen", "V1", "Types" ]


annotation_ :
    { backendToFrontendState : Type.Annotation
    , backendModel : Type.Annotation
    , frontendModel : Type.Annotation
    , frontendPlayingState : Type.Annotation
    , gameState : Type.Annotation
    , relicsByLocation : Type.Annotation
    , realRelicDict : Type.Annotation
    , relicLocation : Type.Annotation
    , realDirtDict : Type.Annotation
    , toFrontend : Type.Annotation
    , actionPerformer : Type.Annotation
    , backendMsg : Type.Annotation
    , toBackend : Type.Annotation
    , frontendMsg : Type.Annotation
    , frontendState : Type.Annotation
    }
annotation_ =
    { backendToFrontendState =
        Type.alias
            moduleName_
            "BackendToFrontendState"
            []
            (Type.record
                 [ ( "gameState"
                   , Type.namedWith
                         [ "Evergreen", "V1", "Types" ]
                         "GameState"
                         []
                   )
                 , ( "myId"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "PersonId"
                         []
                   )
                 ]
            )
    , backendModel =
        Type.alias
            moduleName_
            "BackendModel"
            []
            (Type.record
                 [ ( "gameState"
                   , Type.namedWith
                         [ "Evergreen", "V1", "Types" ]
                         "GameState"
                         []
                   )
                 , ( "connectedClients"
                   , Type.list (Type.namedWith [ "Lamdera" ] "ClientId" [])
                   )
                 , ( "sessionIdToPersonId"
                   , Type.namedWith
                         [ "Dict" ]
                         "Dict"
                         [ Type.namedWith [ "Lamdera" ] "SessionId" []
                         , Type.namedWith
                             [ "Evergreen", "V1", "GameObjectTypes" ]
                             "PersonId"
                             []
                         ]
                   )
                 , ( "biggestId", Type.int )
                 , ( "bigRandom", Type.int )
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
                 , ( "state"
                   , Type.namedWith
                         [ "Evergreen", "V1", "Types" ]
                         "FrontendState"
                         []
                   )
                 ]
            )
    , frontendPlayingState =
        Type.alias
            moduleName_
            "FrontendPlayingState"
            []
            (Type.record
                 [ ( "gameState"
                   , Type.namedWith
                         [ "Evergreen", "V1", "Types" ]
                         "GameState"
                         []
                   )
                 , ( "myId"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "PersonId"
                         []
                   )
                 , ( "targetPosition"
                   , Type.maybe
                         (Type.namedWith
                              [ "Evergreen", "V1", "GameObjectTypes" ]
                              "Point"
                              []
                         )
                   )
                 , ( "showingDebugStuff", Type.bool )
                 , ( "mapSize"
                   , Type.maybe
                         (Type.record
                              [ ( "width", Type.float )
                              , ( "height", Type.float )
                              ]
                         )
                   )
                 , ( "cameraPosition"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "Point"
                         []
                   )
                 , ( "mobileRelicMenuOpen", Type.bool )
                 ]
            )
    , gameState =
        Type.alias
            moduleName_
            "GameState"
            []
            (Type.record
                 [ ( "personDict"
                   , Type.namedWith
                         [ "Evergreen", "V1", "PersonDict" ]
                         "PersonDict"
                         [ Type.namedWith
                             [ "Evergreen", "V1", "GameObjectTypes" ]
                             "PersonData"
                             []
                         ]
                   )
                 , ( "dirtDict"
                   , Type.namedWith
                         [ "Evergreen", "V1", "Types" ]
                         "RealDirtDict"
                         []
                   )
                 , ( "relicsByPosition"
                   , Type.namedWith
                         [ "Evergreen", "V1", "Types" ]
                         "RelicsByLocation"
                         []
                   )
                 ]
            )
    , relicsByLocation =
        Type.alias
            moduleName_
            "RelicsByLocation"
            []
            (Type.namedWith
                 [ "Dict" ]
                 "Dict"
                 [ Type.namedWith
                     [ "Evergreen", "V1", "Types" ]
                     "RelicLocation"
                     []
                 , Type.namedWith
                     [ "Evergreen", "V1", "Types" ]
                     "RealRelicDict"
                     []
                 ]
            )
    , realRelicDict =
        Type.alias
            moduleName_
            "RealRelicDict"
            []
            (Type.namedWith
                 [ "Evergreen", "V1", "RelicDict" ]
                 "RelicDict"
                 [ Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "RelicData"
                     []
                 ]
            )
    , relicLocation =
        Type.alias
            moduleName_
            "RelicLocation"
            []
            (Type.triple Type.int Type.int Type.int)
    , realDirtDict =
        Type.alias
            moduleName_
            "RealDirtDict"
            []
            (Type.namedWith
                 [ "Evergreen", "V1", "DirtDict" ]
                 "DirtDict"
                 [ Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "DirtData"
                     []
                 ]
            )
    , toFrontend = Type.namedWith [ "Evergreen", "V1", "Types" ] "ToFrontend" []
    , actionPerformer =
        Type.namedWith [ "Evergreen", "V1", "Types" ] "ActionPerformer" []
    , backendMsg = Type.namedWith [ "Evergreen", "V1", "Types" ] "BackendMsg" []
    , toBackend = Type.namedWith [ "Evergreen", "V1", "Types" ] "ToBackend" []
    , frontendMsg =
        Type.namedWith [ "Evergreen", "V1", "Types" ] "FrontendMsg" []
    , frontendState =
        Type.namedWith [ "Evergreen", "V1", "Types" ] "FrontendState" []
    }


make_ :
    { backendToFrontendState :
        { gameState : Elm.Expression, myId : Elm.Expression } -> Elm.Expression
    , backendModel :
        { gameState : Elm.Expression
        , connectedClients : Elm.Expression
        , sessionIdToPersonId : Elm.Expression
        , biggestId : Elm.Expression
        , bigRandom : Elm.Expression
        }
        -> Elm.Expression
    , frontendModel :
        { key : Elm.Expression, state : Elm.Expression } -> Elm.Expression
    , frontendPlayingState :
        { gameState : Elm.Expression
        , myId : Elm.Expression
        , targetPosition : Elm.Expression
        , showingDebugStuff : Elm.Expression
        , mapSize : Elm.Expression
        , cameraPosition : Elm.Expression
        , mobileRelicMenuOpen : Elm.Expression
        }
        -> Elm.Expression
    , gameState :
        { personDict : Elm.Expression
        , dirtDict : Elm.Expression
        , relicsByPosition : Elm.Expression
        }
        -> Elm.Expression
    , noOpToFrontend : Elm.Expression
    , otherClientPerformedAction :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateFullState : Elm.Expression -> Elm.Expression
    , client : Elm.Expression -> Elm.Expression
    , server : Elm.Expression
    , noOpBackendMsg : Elm.Expression
    , clientConnected : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clientDisconnected : Elm.Expression -> Elm.Expression -> Elm.Expression
    , noOpToBackend : Elm.Expression
    , clientPerformsAction : Elm.Expression -> Elm.Expression
    , pleaseMakeMeDirty : Elm.Expression
    , pleaseGenerateRelic : Elm.Expression
    , pleaseActivateRelic : Elm.Expression -> Elm.Expression -> Elm.Expression
    , urlClicked : Elm.Expression -> Elm.Expression
    , urlChanged : Elm.Expression -> Elm.Expression
    , performAction : Elm.Expression -> Elm.Expression
    , clickedPleaseMakeMeDirty : Elm.Expression
    , debugGenerateRelic : Elm.Expression
    , activatedRelic : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clickTarget : Elm.Expression -> Elm.Expression
    , tick : Elm.Expression -> Elm.Expression
    , toggleDebugStuff : Elm.Expression
    , receivedMapSize : Elm.Expression -> Elm.Expression
    , toggleMobileRelicMenu : Elm.Expression
    , noOpFrontendMsg : Elm.Expression
    , loading : Elm.Expression
    , playing : Elm.Expression -> Elm.Expression
    , error : Elm.Expression -> Elm.Expression
    }
make_ =
    { backendToFrontendState =
        \backendToFrontendState_args ->
            Elm.withType
                (Type.alias
                     [ "Evergreen", "V1", "Types" ]
                     "BackendToFrontendState"
                     []
                     (Type.record
                          [ ( "gameState"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "Types" ]
                                  "GameState"
                                  []
                            )
                          , ( "myId"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "PersonId"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair
                         "gameState"
                         backendToFrontendState_args.gameState
                     , Tuple.pair "myId" backendToFrontendState_args.myId
                     ]
                )
    , backendModel =
        \backendModel_args ->
            Elm.withType
                (Type.alias
                     [ "Evergreen", "V1", "Types" ]
                     "BackendModel"
                     []
                     (Type.record
                          [ ( "gameState"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "Types" ]
                                  "GameState"
                                  []
                            )
                          , ( "connectedClients"
                            , Type.list
                                  (Type.namedWith [ "Lamdera" ] "ClientId" [])
                            )
                          , ( "sessionIdToPersonId"
                            , Type.namedWith
                                  [ "Dict" ]
                                  "Dict"
                                  [ Type.namedWith [ "Lamdera" ] "SessionId" []
                                  , Type.namedWith
                                      [ "Evergreen", "V1", "GameObjectTypes" ]
                                      "PersonId"
                                      []
                                  ]
                            )
                          , ( "biggestId", Type.int )
                          , ( "bigRandom", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "gameState" backendModel_args.gameState
                     , Tuple.pair
                         "connectedClients"
                         backendModel_args.connectedClients
                     , Tuple.pair
                         "sessionIdToPersonId"
                         backendModel_args.sessionIdToPersonId
                     , Tuple.pair "biggestId" backendModel_args.biggestId
                     , Tuple.pair "bigRandom" backendModel_args.bigRandom
                     ]
                )
    , frontendModel =
        \frontendModel_args ->
            Elm.withType
                (Type.alias
                     [ "Evergreen", "V1", "Types" ]
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
                            , Type.namedWith
                                  [ "Evergreen", "V1", "Types" ]
                                  "FrontendState"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "key" frontendModel_args.key
                     , Tuple.pair "state" frontendModel_args.state
                     ]
                )
    , frontendPlayingState =
        \frontendPlayingState_args ->
            Elm.withType
                (Type.alias
                     [ "Evergreen", "V1", "Types" ]
                     "FrontendPlayingState"
                     []
                     (Type.record
                          [ ( "gameState"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "Types" ]
                                  "GameState"
                                  []
                            )
                          , ( "myId"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "PersonId"
                                  []
                            )
                          , ( "targetPosition"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "Evergreen", "V1", "GameObjectTypes" ]
                                       "Point"
                                       []
                                  )
                            )
                          , ( "showingDebugStuff", Type.bool )
                          , ( "mapSize"
                            , Type.maybe
                                  (Type.record
                                       [ ( "width", Type.float )
                                       , ( "height", Type.float )
                                       ]
                                  )
                            )
                          , ( "cameraPosition"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "Point"
                                  []
                            )
                          , ( "mobileRelicMenuOpen", Type.bool )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair
                         "gameState"
                         frontendPlayingState_args.gameState
                     , Tuple.pair "myId" frontendPlayingState_args.myId
                     , Tuple.pair
                         "targetPosition"
                         frontendPlayingState_args.targetPosition
                     , Tuple.pair
                         "showingDebugStuff"
                         frontendPlayingState_args.showingDebugStuff
                     , Tuple.pair "mapSize" frontendPlayingState_args.mapSize
                     , Tuple.pair
                         "cameraPosition"
                         frontendPlayingState_args.cameraPosition
                     , Tuple.pair
                         "mobileRelicMenuOpen"
                         frontendPlayingState_args.mobileRelicMenuOpen
                     ]
                )
    , gameState =
        \gameState_args ->
            Elm.withType
                (Type.alias
                     [ "Evergreen", "V1", "Types" ]
                     "GameState"
                     []
                     (Type.record
                          [ ( "personDict"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "PersonDict" ]
                                  "PersonDict"
                                  [ Type.namedWith
                                      [ "Evergreen", "V1", "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                            )
                          , ( "dirtDict"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "Types" ]
                                  "RealDirtDict"
                                  []
                            )
                          , ( "relicsByPosition"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "Types" ]
                                  "RelicsByLocation"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "personDict" gameState_args.personDict
                     , Tuple.pair "dirtDict" gameState_args.dirtDict
                     , Tuple.pair
                         "relicsByPosition"
                         gameState_args.relicsByPosition
                     ]
                )
    , noOpToFrontend =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "NoOpToFrontend"
            , annotation = Just (Type.namedWith [] "ToFrontend" [])
            }
    , otherClientPerformedAction =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "OtherClientPerformedAction"
                     , annotation = Just (Type.namedWith [] "ToFrontend" [])
                     }
                )
                [ ar0, ar1 ]
    , updateFullState =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "UpdateFullState"
                     , annotation = Just (Type.namedWith [] "ToFrontend" [])
                     }
                )
                [ ar0 ]
    , client =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "Client"
                     , annotation =
                         Just (Type.namedWith [] "ActionPerformer" [])
                     }
                )
                [ ar0 ]
    , server =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "Server"
            , annotation = Just (Type.namedWith [] "ActionPerformer" [])
            }
    , noOpBackendMsg =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "NoOpBackendMsg"
            , annotation = Just (Type.namedWith [] "BackendMsg" [])
            }
    , clientConnected =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "ClientConnected"
                     , annotation = Just (Type.namedWith [] "BackendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , clientDisconnected =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "ClientDisconnected"
                     , annotation = Just (Type.namedWith [] "BackendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , noOpToBackend =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "NoOpToBackend"
            , annotation = Just (Type.namedWith [] "ToBackend" [])
            }
    , clientPerformsAction =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "ClientPerformsAction"
                     , annotation = Just (Type.namedWith [] "ToBackend" [])
                     }
                )
                [ ar0 ]
    , pleaseMakeMeDirty =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "PleaseMakeMeDirty"
            , annotation = Just (Type.namedWith [] "ToBackend" [])
            }
    , pleaseGenerateRelic =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "PleaseGenerateRelic"
            , annotation = Just (Type.namedWith [] "ToBackend" [])
            }
    , pleaseActivateRelic =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "PleaseActivateRelic"
                     , annotation = Just (Type.namedWith [] "ToBackend" [])
                     }
                )
                [ ar0, ar1 ]
    , urlClicked =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "UrlClicked"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , urlChanged =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "UrlChanged"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , performAction =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "PerformAction"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , clickedPleaseMakeMeDirty =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "ClickedPleaseMakeMeDirty"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , debugGenerateRelic =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "DebugGenerateRelic"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , activatedRelic =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "ActivatedRelic"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , clickTarget =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "ClickTarget"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , tick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "Tick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , toggleDebugStuff =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "ToggleDebugStuff"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , receivedMapSize =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "ReceivedMapSize"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , toggleMobileRelicMenu =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "ToggleMobileRelicMenu"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , noOpFrontendMsg =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "NoOpFrontendMsg"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , loading =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "Types" ]
            , name = "Loading"
            , annotation = Just (Type.namedWith [] "FrontendState" [])
            }
    , playing =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "Playing"
                     , annotation = Just (Type.namedWith [] "FrontendState" [])
                     }
                )
                [ ar0 ]
    , error =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "Types" ]
                     , name = "Error"
                     , annotation = Just (Type.namedWith [] "FrontendState" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ =
    { toFrontend =
        \toFrontendExpression toFrontendTags ->
            Elm.Case.custom
                toFrontendExpression
                (Type.namedWith [ "Evergreen", "V1", "Types" ] "ToFrontend" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "NoOpToFrontend"
                       toFrontendTags.noOpToFrontend
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "OtherClientPerformedAction"
                       toFrontendTags.otherClientPerformedAction |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "evergreenV1TypesActionPerformer"
                                                                                 (Type.namedWith
                                                                                        [ "Evergreen"
                                                                                        , "V1"
                                                                                        , "Types"
                                                                                        ]
                                                                                        "ActionPerformer"
                                                                                        []
                                                                                 )
                                                                          ) |> Elm.Arg.item
                                                                                     (Elm.Arg.varWith
                                                                                            "evergreenV1GameObjectTypesActionOnGamestate"
                                                                                            (Type.namedWith
                                                                                                   [ "Evergreen"
                                                                                                   , "V1"
                                                                                                   , "GameObjectTypes"
                                                                                                   ]
                                                                                                   "ActionOnGamestate"
                                                                                                   []
                                                                                            )
                                                                                     )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "UpdateFullState"
                       toFrontendTags.updateFullState |> Elm.Arg.item
                                                               (Elm.Arg.varWith
                                                                      "evergreenV1TypesBackendToFrontendState"
                                                                      (Type.namedWith
                                                                             [ "Evergreen"
                                                                             , "V1"
                                                                             , "Types"
                                                                             ]
                                                                             "BackendToFrontendState"
                                                                             []
                                                                      )
                                                               )
                    )
                    Basics.identity
                ]
    , actionPerformer =
        \actionPerformerExpression actionPerformerTags ->
            Elm.Case.custom
                actionPerformerExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "Types" ]
                     "ActionPerformer"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "Client"
                       actionPerformerTags.client |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "evergreenV1GameObjectTypesPersonId"
                                                                  (Type.namedWith
                                                                         [ "Evergreen"
                                                                         , "V1"
                                                                         , "GameObjectTypes"
                                                                         ]
                                                                         "PersonId"
                                                                         []
                                                                  )
                                                           )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Server" actionPerformerTags.server)
                    Basics.identity
                ]
    , backendMsg =
        \backendMsgExpression backendMsgTags ->
            Elm.Case.custom
                backendMsgExpression
                (Type.namedWith [ "Evergreen", "V1", "Types" ] "BackendMsg" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "NoOpBackendMsg"
                       backendMsgTags.noOpBackendMsg
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ClientConnected"
                       backendMsgTags.clientConnected |> Elm.Arg.item
                                                               (Elm.Arg.varWith
                                                                      "lamderaSessionId"
                                                                      (Type.namedWith
                                                                             [ "Lamdera"
                                                                             ]
                                                                             "SessionId"
                                                                             []
                                                                      )
                                                               ) |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "lamderaClientId"
                                                                                 (Type.namedWith
                                                                                        [ "Lamdera"
                                                                                        ]
                                                                                        "ClientId"
                                                                                        []
                                                                                 )
                                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ClientDisconnected"
                       backendMsgTags.clientDisconnected |> Elm.Arg.item
                                                                  (Elm.Arg.varWith
                                                                         "lamderaSessionId"
                                                                         (Type.namedWith
                                                                                [ "Lamdera"
                                                                                ]
                                                                                "SessionId"
                                                                                []
                                                                         )
                                                                  ) |> Elm.Arg.item
                                                                             (Elm.Arg.varWith
                                                                                    "lamderaClientId"
                                                                                    (Type.namedWith
                                                                                           [ "Lamdera"
                                                                                           ]
                                                                                           "ClientId"
                                                                                           []
                                                                                    )
                                                                             )
                    )
                    Basics.identity
                ]
    , toBackend =
        \toBackendExpression toBackendTags ->
            Elm.Case.custom
                toBackendExpression
                (Type.namedWith [ "Evergreen", "V1", "Types" ] "ToBackend" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "NoOpToBackend"
                       toBackendTags.noOpToBackend
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ClientPerformsAction"
                       toBackendTags.clientPerformsAction |> Elm.Arg.item
                                                                   (Elm.Arg.varWith
                                                                          "evergreenV1GameObjectTypesActionOnGamestate"
                                                                          (Type.namedWith
                                                                                 [ "Evergreen"
                                                                                 , "V1"
                                                                                 , "GameObjectTypes"
                                                                                 ]
                                                                                 "ActionOnGamestate"
                                                                                 []
                                                                          )
                                                                   )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PleaseMakeMeDirty"
                       toBackendTags.pleaseMakeMeDirty
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PleaseGenerateRelic"
                       toBackendTags.pleaseGenerateRelic
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PleaseActivateRelic"
                       toBackendTags.pleaseActivateRelic |> Elm.Arg.item
                                                                  (Elm.Arg.varWith
                                                                         "evergreenV1GameObjectTypesPersonId"
                                                                         (Type.namedWith
                                                                                [ "Evergreen"
                                                                                , "V1"
                                                                                , "GameObjectTypes"
                                                                                ]
                                                                                "PersonId"
                                                                                []
                                                                         )
                                                                  ) |> Elm.Arg.item
                                                                             (Elm.Arg.varWith
                                                                                    "evergreenV1GameObjectTypesRelicId"
                                                                                    (Type.namedWith
                                                                                           [ "Evergreen"
                                                                                           , "V1"
                                                                                           , "GameObjectTypes"
                                                                                           ]
                                                                                           "RelicId"
                                                                                           []
                                                                                    )
                                                                             )
                    )
                    Basics.identity
                ]
    , frontendMsg =
        \frontendMsgExpression frontendMsgTags ->
            Elm.Case.custom
                frontendMsgExpression
                (Type.namedWith [ "Evergreen", "V1", "Types" ] "FrontendMsg" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "UrlClicked"
                       frontendMsgTags.urlClicked |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "browserUrlRequest"
                                                                  (Type.namedWith
                                                                         [ "Browser"
                                                                         ]
                                                                         "UrlRequest"
                                                                         []
                                                                  )
                                                           )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "UrlChanged"
                       frontendMsgTags.urlChanged |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "urlUrl"
                                                                  (Type.namedWith
                                                                         [ "Url"
                                                                         ]
                                                                         "Url"
                                                                         []
                                                                  )
                                                           )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PerformAction"
                       frontendMsgTags.performAction |> Elm.Arg.item
                                                              (Elm.Arg.varWith
                                                                     "evergreenV1GameObjectTypesActionOnGamestate"
                                                                     (Type.namedWith
                                                                            [ "Evergreen"
                                                                            , "V1"
                                                                            , "GameObjectTypes"
                                                                            ]
                                                                            "ActionOnGamestate"
                                                                            []
                                                                     )
                                                              )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ClickedPleaseMakeMeDirty"
                       frontendMsgTags.clickedPleaseMakeMeDirty
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DebugGenerateRelic"
                       frontendMsgTags.debugGenerateRelic
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ActivatedRelic"
                       frontendMsgTags.activatedRelic |> Elm.Arg.item
                                                               (Elm.Arg.varWith
                                                                      "evergreenV1GameObjectTypesPersonId"
                                                                      (Type.namedWith
                                                                             [ "Evergreen"
                                                                             , "V1"
                                                                             , "GameObjectTypes"
                                                                             ]
                                                                             "PersonId"
                                                                             []
                                                                      )
                                                               ) |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "evergreenV1GameObjectTypesRelicId"
                                                                                 (Type.namedWith
                                                                                        [ "Evergreen"
                                                                                        , "V1"
                                                                                        , "GameObjectTypes"
                                                                                        ]
                                                                                        "RelicId"
                                                                                        []
                                                                                 )
                                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ClickTarget"
                       frontendMsgTags.clickTarget |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "evergreenV1GameObjectTypesPoint"
                                                                   (Type.namedWith
                                                                          [ "Evergreen"
                                                                          , "V1"
                                                                          , "GameObjectTypes"
                                                                          ]
                                                                          "Point"
                                                                          []
                                                                   )
                                                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Tick"
                       frontendMsgTags.tick |> Elm.Arg.item
                                                     (Elm.Arg.varWith
                                                            "timePosix"
                                                            (Type.namedWith
                                                                   [ "Time" ]
                                                                   "Posix"
                                                                   []
                                                            )
                                                     )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ToggleDebugStuff"
                       frontendMsgTags.toggleDebugStuff
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ReceivedMapSize"
                       frontendMsgTags.receivedMapSize |> Elm.Arg.item
                                                                (Elm.Arg.varWith
                                                                       "arg_0"
                                                                       (Type.record
                                                                              [ ( "width"
                                                                                , Type.float
                                                                                )
                                                                              , ( "height"
                                                                                , Type.float
                                                                                )
                                                                              ]
                                                                       )
                                                                )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ToggleMobileRelicMenu"
                       frontendMsgTags.toggleMobileRelicMenu
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "NoOpFrontendMsg"
                       frontendMsgTags.noOpFrontendMsg
                    )
                    Basics.identity
                ]
    , frontendState =
        \frontendStateExpression frontendStateTags ->
            Elm.Case.custom
                frontendStateExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "Types" ]
                     "FrontendState"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "Loading" frontendStateTags.loading)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Playing"
                       frontendStateTags.playing |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "evergreenV1TypesFrontendPlayingState"
                                                                 (Type.namedWith
                                                                        [ "Evergreen"
                                                                        , "V1"
                                                                        , "Types"
                                                                        ]
                                                                        "FrontendPlayingState"
                                                                        []
                                                                 )
                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Error"
                       frontendStateTags.error |> Elm.Arg.item
                                                        (Elm.Arg.varWith
                                                               "arg_0"
                                                               Type.string
                                                        )
                    )
                    Basics.identity
                ]
    }