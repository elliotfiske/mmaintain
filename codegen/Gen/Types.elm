module Gen.Types exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Types

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Types" ]


annotation_ :
    { backendModel : Type.Annotation
    , backendToFrontendState : Type.Annotation
    , frontendPlayingState : Type.Annotation
    , frontendModel : Type.Annotation
    , gameState : Type.Annotation
    , dirtByLocation : Type.Annotation
    , dirtLocation : Type.Annotation
    , relicsByLocation : Type.Annotation
    , relicLocation : Type.Annotation
    , personWithRelics : Type.Annotation
    , realDirtDict : Type.Annotation
    , realRelicDict : Type.Annotation
    , realPersonDict : Type.Annotation
    , toFrontend : Type.Annotation
    , actionPerformer : Type.Annotation
    , backendMsg : Type.Annotation
    , toBackend : Type.Annotation
    , frontendMsg : Type.Annotation
    , backendTrigger : Type.Annotation
    , frontendState : Type.Annotation
    }
annotation_ =
    { backendModel =
        Type.alias
            moduleName_
            "BackendModel"
            []
            (Type.record
                 [ ( "gameState", Type.namedWith [ "Types" ] "GameState" [] )
                 , ( "connectedClients"
                   , Type.list (Type.namedWith [ "Lamdera" ] "ClientId" [])
                   )
                 , ( "sessionIdToPersonId"
                   , Type.namedWith
                         [ "Dict" ]
                         "Dict"
                         [ Type.namedWith [ "Lamdera" ] "SessionId" []
                         , Type.namedWith [ "Types" ] "PersonId" []
                         ]
                   )
                 , ( "biggestId", Type.int )
                 , ( "bigRandom", Type.int )
                 ]
            )
    , backendToFrontendState =
        Type.alias
            moduleName_
            "BackendToFrontendState"
            []
            (Type.record
                 [ ( "gameState", Type.namedWith [ "Types" ] "GameState" [] )
                 , ( "myId", Type.namedWith [ "Types" ] "PersonId" [] )
                 ]
            )
    , frontendPlayingState =
        Type.alias
            moduleName_
            "FrontendPlayingState"
            []
            (Type.record
                 [ ( "gameState", Type.namedWith [ "Types" ] "GameState" [] )
                 , ( "myId", Type.namedWith [ "Types" ] "PersonId" [] )
                 , ( "targetPosition"
                   , Type.maybe (Type.namedWith [ "Types" ] "Point" [])
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
                 , ( "cameraPosition", Type.namedWith [ "Types" ] "Point" [] )
                 , ( "mobileRelicMenuOpen", Type.bool )
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
    , gameState =
        Type.alias
            moduleName_
            "GameState"
            []
            (Type.record
                 [ ( "personDict"
                   , Type.namedWith
                         [ "PersonDict" ]
                         "PersonDict"
                         [ Type.namedWith [ "Types" ] "PersonData" [] ]
                   )
                 , ( "relicsByPosition"
                   , Type.namedWith [ "Types" ] "RelicsByLocation" []
                   )
                 , ( "dirtByLocation"
                   , Type.namedWith [ "Types" ] "DirtByLocation" []
                   )
                 ]
            )
    , dirtByLocation =
        Type.alias
            moduleName_
            "DirtByLocation"
            []
            (Type.namedWith
                 [ "Dict" ]
                 "Dict"
                 [ Type.namedWith [ "Types" ] "DirtLocation" []
                 , Type.namedWith [ "Types" ] "DirtData" []
                 ]
            )
    , dirtLocation =
        Type.alias moduleName_ "DirtLocation" [] (Type.tuple Type.int Type.int)
    , relicsByLocation =
        Type.alias
            moduleName_
            "RelicsByLocation"
            []
            (Type.namedWith
                 [ "Dict" ]
                 "Dict"
                 [ Type.namedWith [ "Types" ] "RelicLocation" []
                 , Type.namedWith [ "Types" ] "RealRelicDict" []
                 ]
            )
    , relicLocation =
        Type.alias
            moduleName_
            "RelicLocation"
            []
            (Type.triple Type.int Type.int Type.int)
    , personWithRelics =
        Type.alias
            moduleName_
            "PersonWithRelics"
            []
            (Type.record
                 [ ( "person", Type.namedWith [ "Types" ] "PersonData" [] )
                 , ( "heldRelics"
                   , Type.list (Type.namedWith [ "Types" ] "RelicData" [])
                   )
                 ]
            )
    , realDirtDict =
        Type.alias
            moduleName_
            "RealDirtDict"
            []
            (Type.namedWith
                 [ "DirtDict" ]
                 "DirtDict"
                 [ Type.namedWith [ "Types" ] "DirtData" [] ]
            )
    , realRelicDict =
        Type.alias
            moduleName_
            "RealRelicDict"
            []
            (Type.namedWith
                 [ "RelicDict" ]
                 "RelicDict"
                 [ Type.namedWith [ "Types" ] "RelicData" [] ]
            )
    , realPersonDict =
        Type.alias
            moduleName_
            "RealPersonDict"
            []
            (Type.namedWith
                 [ "PersonDict" ]
                 "PersonDict"
                 [ Type.namedWith [ "Types" ] "PersonData" [] ]
            )
    , toFrontend = Type.namedWith [ "Types" ] "ToFrontend" []
    , actionPerformer = Type.namedWith [ "Types" ] "ActionPerformer" []
    , backendMsg = Type.namedWith [ "Types" ] "BackendMsg" []
    , toBackend = Type.namedWith [ "Types" ] "ToBackend" []
    , frontendMsg = Type.namedWith [ "Types" ] "FrontendMsg" []
    , backendTrigger = Type.namedWith [ "Types" ] "BackendTrigger" []
    , frontendState = Type.namedWith [ "Types" ] "FrontendState" []
    }


make_ :
    { backendModel :
        { gameState : Elm.Expression
        , connectedClients : Elm.Expression
        , sessionIdToPersonId : Elm.Expression
        , biggestId : Elm.Expression
        , bigRandom : Elm.Expression
        }
        -> Elm.Expression
    , backendToFrontendState :
        { gameState : Elm.Expression, myId : Elm.Expression } -> Elm.Expression
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
    , frontendModel :
        { key : Elm.Expression, state : Elm.Expression } -> Elm.Expression
    , gameState :
        { personDict : Elm.Expression
        , relicsByPosition : Elm.Expression
        , dirtByLocation : Elm.Expression
        }
        -> Elm.Expression
    , personWithRelics :
        { person : Elm.Expression, heldRelics : Elm.Expression }
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
    , noOpBackendTrigger : Elm.Expression
    , clearedPollution : Elm.Expression -> Elm.Expression -> Elm.Expression
    , batchTrigger : Elm.Expression -> Elm.Expression
    , nuhUh : Elm.Expression -> Elm.Expression
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
                          [ ( "gameState"
                            , Type.namedWith [ "Types" ] "GameState" []
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
                                  , Type.namedWith [ "Types" ] "PersonId" []
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
    , backendToFrontendState =
        \backendToFrontendState_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "BackendToFrontendState"
                     []
                     (Type.record
                          [ ( "gameState"
                            , Type.namedWith [ "Types" ] "GameState" []
                            )
                          , ( "myId", Type.namedWith [ "Types" ] "PersonId" [] )
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
    , frontendPlayingState =
        \frontendPlayingState_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "FrontendPlayingState"
                     []
                     (Type.record
                          [ ( "gameState"
                            , Type.namedWith [ "Types" ] "GameState" []
                            )
                          , ( "myId", Type.namedWith [ "Types" ] "PersonId" [] )
                          , ( "targetPosition"
                            , Type.maybe (Type.namedWith [ "Types" ] "Point" [])
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
                            , Type.namedWith [ "Types" ] "Point" []
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
    , gameState =
        \gameState_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "GameState"
                     []
                     (Type.record
                          [ ( "personDict"
                            , Type.namedWith
                                  [ "PersonDict" ]
                                  "PersonDict"
                                  [ Type.namedWith [ "Types" ] "PersonData" [] ]
                            )
                          , ( "relicsByPosition"
                            , Type.namedWith [ "Types" ] "RelicsByLocation" []
                            )
                          , ( "dirtByLocation"
                            , Type.namedWith [ "Types" ] "DirtByLocation" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "personDict" gameState_args.personDict
                     , Tuple.pair
                         "relicsByPosition"
                         gameState_args.relicsByPosition
                     , Tuple.pair "dirtByLocation" gameState_args.dirtByLocation
                     ]
                )
    , personWithRelics =
        \personWithRelics_args ->
            Elm.withType
                (Type.alias
                     [ "Types" ]
                     "PersonWithRelics"
                     []
                     (Type.record
                          [ ( "person"
                            , Type.namedWith [ "Types" ] "PersonData" []
                            )
                          , ( "heldRelics"
                            , Type.list
                                  (Type.namedWith [ "Types" ] "RelicData" [])
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "person" personWithRelics_args.person
                     , Tuple.pair "heldRelics" personWithRelics_args.heldRelics
                     ]
                )
    , noOpToFrontend =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpToFrontend"
            , annotation = Just (Type.namedWith [] "ToFrontend" [])
            }
    , otherClientPerformedAction =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "OtherClientPerformedAction"
                     , annotation = Just (Type.namedWith [] "ToFrontend" [])
                     }
                )
                [ ar0, ar1 ]
    , updateFullState =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "UpdateFullState"
                     , annotation = Just (Type.namedWith [] "ToFrontend" [])
                     }
                )
                [ ar0 ]
    , client =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "Client"
                     , annotation =
                         Just (Type.namedWith [] "ActionPerformer" [])
                     }
                )
                [ ar0 ]
    , server =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "Server"
            , annotation = Just (Type.namedWith [] "ActionPerformer" [])
            }
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
    , pleaseMakeMeDirty =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "PleaseMakeMeDirty"
            , annotation = Just (Type.namedWith [] "ToBackend" [])
            }
    , pleaseGenerateRelic =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "PleaseGenerateRelic"
            , annotation = Just (Type.namedWith [] "ToBackend" [])
            }
    , pleaseActivateRelic =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "PleaseActivateRelic"
                     , annotation = Just (Type.namedWith [] "ToBackend" [])
                     }
                )
                [ ar0, ar1 ]
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
    , clickedPleaseMakeMeDirty =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ClickedPleaseMakeMeDirty"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , debugGenerateRelic =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "DebugGenerateRelic"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , activatedRelic =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ActivatedRelic"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0, ar1 ]
    , clickTarget =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ClickTarget"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , tick =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "Tick"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , toggleDebugStuff =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ToggleDebugStuff"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , receivedMapSize =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ReceivedMapSize"
                     , annotation = Just (Type.namedWith [] "FrontendMsg" [])
                     }
                )
                [ ar0 ]
    , toggleMobileRelicMenu =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "ToggleMobileRelicMenu"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , noOpFrontendMsg =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpFrontendMsg"
            , annotation = Just (Type.namedWith [] "FrontendMsg" [])
            }
    , noOpBackendTrigger =
        Elm.value
            { importFrom = [ "Types" ]
            , name = "NoOpBackendTrigger"
            , annotation = Just (Type.namedWith [] "BackendTrigger" [])
            }
    , clearedPollution =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "ClearedPollution"
                     , annotation = Just (Type.namedWith [] "BackendTrigger" [])
                     }
                )
                [ ar0, ar1 ]
    , batchTrigger =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "BatchTrigger"
                     , annotation = Just (Type.namedWith [] "BackendTrigger" [])
                     }
                )
                [ ar0 ]
    , nuhUh =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Types" ]
                     , name = "NuhUh"
                     , annotation = Just (Type.namedWith [] "BackendTrigger" [])
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


caseOf_ =
    { toFrontend =
        \toFrontendExpression toFrontendTags ->
            Elm.Case.custom
                toFrontendExpression
                (Type.namedWith [ "Types" ] "ToFrontend" [])
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
                                                                                 "typesActionPerformer"
                                                                                 (Type.namedWith
                                                                                        [ "Types"
                                                                                        ]
                                                                                        "ActionPerformer"
                                                                                        []
                                                                                 )
                                                                          ) |> Elm.Arg.item
                                                                                     (Elm.Arg.varWith
                                                                                            "typesActionOnGamestate"
                                                                                            (Type.namedWith
                                                                                                   [ "Types"
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
                                                                      "typesBackendToFrontendState"
                                                                      (Type.namedWith
                                                                             [ "Types"
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
                (Type.namedWith [ "Types" ] "ActionPerformer" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "Client"
                       actionPerformerTags.client |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "typesPersonId"
                                                                  (Type.namedWith
                                                                         [ "Types"
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
                (Type.namedWith [ "Types" ] "BackendMsg" [])
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
                (Type.namedWith [ "Types" ] "ToBackend" [])
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
                                                                          "typesActionOnGamestate"
                                                                          (Type.namedWith
                                                                                 [ "Types"
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
                                                                         "typesPersonId"
                                                                         (Type.namedWith
                                                                                [ "Types"
                                                                                ]
                                                                                "PersonId"
                                                                                []
                                                                         )
                                                                  ) |> Elm.Arg.item
                                                                             (Elm.Arg.varWith
                                                                                    "typesRelicId"
                                                                                    (Type.namedWith
                                                                                           [ "Types"
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
                (Type.namedWith [ "Types" ] "FrontendMsg" [])
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
                                                                     "typesActionOnGamestate"
                                                                     (Type.namedWith
                                                                            [ "Types"
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
                                                                      "typesPersonId"
                                                                      (Type.namedWith
                                                                             [ "Types"
                                                                             ]
                                                                             "PersonId"
                                                                             []
                                                                      )
                                                               ) |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "typesRelicId"
                                                                                 (Type.namedWith
                                                                                        [ "Types"
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
                                                                   "typesPoint"
                                                                   (Type.namedWith
                                                                          [ "Types"
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
    , backendTrigger =
        \backendTriggerExpression backendTriggerTags ->
            Elm.Case.custom
                backendTriggerExpression
                (Type.namedWith [ "Types" ] "BackendTrigger" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "NoOpBackendTrigger"
                       backendTriggerTags.noOpBackendTrigger
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ClearedPollution"
                       backendTriggerTags.clearedPollution |> Elm.Arg.item
                                                                    (Elm.Arg.varWith
                                                                           "typesPersonId"
                                                                           (Type.namedWith
                                                                                  [ "Types"
                                                                                  ]
                                                                                  "PersonId"
                                                                                  []
                                                                           )
                                                                    ) |> Elm.Arg.item
                                                                               (Elm.Arg.varWith
                                                                                      "typesDirtData"
                                                                                      (Type.namedWith
                                                                                             [ "Types"
                                                                                             ]
                                                                                             "DirtData"
                                                                                             []
                                                                                      )
                                                                               )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BatchTrigger"
                       backendTriggerTags.batchTrigger |> Elm.Arg.item
                                                                (Elm.Arg.varWith
                                                                       "arg_0"
                                                                       (Type.list
                                                                              (Type.namedWith
                                                                                     [ "Types"
                                                                                     ]
                                                                                     "BackendTrigger"
                                                                                     []
                                                                              )
                                                                       )
                                                                )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "NuhUh"
                       backendTriggerTags.nuhUh |> Elm.Arg.item
                                                         (Elm.Arg.varWith
                                                                "typesPersonId"
                                                                (Type.namedWith
                                                                       [ "Types"
                                                                       ]
                                                                       "PersonId"
                                                                       []
                                                                )
                                                         )
                    )
                    Basics.identity
                ]
    , frontendState =
        \frontendStateExpression frontendStateTags ->
            Elm.Case.custom
                frontendStateExpression
                (Type.namedWith [ "Types" ] "FrontendState" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Loading" frontendStateTags.loading)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Playing"
                       frontendStateTags.playing |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "typesFrontendPlayingState"
                                                                 (Type.namedWith
                                                                        [ "Types"
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