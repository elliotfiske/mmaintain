module Gen.GameObject exposing (call_, cleanDirt, executeActionOnGameState, makeDirtCleaner, moduleName_, movePerson, movePersonWithId, values_)

{-| 
@docs moduleName_, executeActionOnGameState, makeDirtCleaner, cleanDirt, movePersonWithId, movePerson, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "GameObject" ]


{-| executeActionOnGameState: 
    GameObject.ActionOnGamestate
    -> GameObjectDict.GameObjectDict GameObject.GameObject
    -> GameObjectDict.GameObjectDict GameObject.GameObject
-}
executeActionOnGameState : Elm.Expression -> Elm.Expression -> Elm.Expression
executeActionOnGameState executeActionOnGameStateArg executeActionOnGameStateArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObject" ]
             , name = "executeActionOnGameState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameObject" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith
                              [ "GameObjectDict" ]
                              "GameObjectDict"
                              [ Type.namedWith [ "GameObject" ] "GameObject" []
                              ]
                          ]
                          (Type.namedWith
                               [ "GameObjectDict" ]
                               "GameObjectDict"
                               [ Type.namedWith [ "GameObject" ] "GameObject" []
                               ]
                          )
                     )
             }
        )
        [ executeActionOnGameStateArg, executeActionOnGameStateArg0 ]


{-| makeDirtCleaner: 
    GameObject.DirtId
    -> GameObjectDict.GameObjectDict GameObject.GameObject
    -> GameObjectDict.GameObjectDict GameObject.GameObject
-}
makeDirtCleaner : Elm.Expression -> Elm.Expression -> Elm.Expression
makeDirtCleaner makeDirtCleanerArg makeDirtCleanerArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObject" ]
             , name = "makeDirtCleaner"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObject" ] "DirtId" []
                          , Type.namedWith
                              [ "GameObjectDict" ]
                              "GameObjectDict"
                              [ Type.namedWith [ "GameObject" ] "GameObject" []
                              ]
                          ]
                          (Type.namedWith
                               [ "GameObjectDict" ]
                               "GameObjectDict"
                               [ Type.namedWith [ "GameObject" ] "GameObject" []
                               ]
                          )
                     )
             }
        )
        [ makeDirtCleanerArg, makeDirtCleanerArg0 ]


{-| cleanDirt: GameObject.DirtData -> GameObject.DirtData -}
cleanDirt : Elm.Expression -> Elm.Expression
cleanDirt cleanDirtArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObject" ]
             , name = "cleanDirt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObject" ] "DirtData" [] ]
                          (Type.namedWith [ "GameObject" ] "DirtData" [])
                     )
             }
        )
        [ cleanDirtArg ]


{-| movePersonWithId: 
    GameObject.PersonId
    -> GameObject.Direction
    -> GameObjectDict.GameObjectDict GameObject.GameObject
    -> GameObjectDict.GameObjectDict GameObject.GameObject
-}
movePersonWithId :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
movePersonWithId movePersonWithIdArg movePersonWithIdArg0 movePersonWithIdArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObject" ]
             , name = "movePersonWithId"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObject" ] "PersonId" []
                          , Type.namedWith [ "GameObject" ] "Direction" []
                          , Type.namedWith
                              [ "GameObjectDict" ]
                              "GameObjectDict"
                              [ Type.namedWith [ "GameObject" ] "GameObject" []
                              ]
                          ]
                          (Type.namedWith
                               [ "GameObjectDict" ]
                               "GameObjectDict"
                               [ Type.namedWith [ "GameObject" ] "GameObject" []
                               ]
                          )
                     )
             }
        )
        [ movePersonWithIdArg, movePersonWithIdArg0, movePersonWithIdArg1 ]


{-| movePerson: GameObject.Direction -> GameObject.PersonData -> GameObject.PersonData -}
movePerson : Elm.Expression -> Elm.Expression -> Elm.Expression
movePerson movePersonArg movePersonArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObject" ]
             , name = "movePerson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObject" ] "Direction" []
                          , Type.namedWith [ "GameObject" ] "PersonData" []
                          ]
                          (Type.namedWith [ "GameObject" ] "PersonData" [])
                     )
             }
        )
        [ movePersonArg, movePersonArg0 ]


call_ :
    { executeActionOnGameState :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , makeDirtCleaner : Elm.Expression -> Elm.Expression -> Elm.Expression
    , cleanDirt : Elm.Expression -> Elm.Expression
    , movePersonWithId :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , movePerson : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { executeActionOnGameState =
        \executeActionOnGameStateArg executeActionOnGameStateArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObject" ]
                     , name = "executeActionOnGameState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObject" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectDict" ]
                                      "GameObjectDict"
                                      [ Type.namedWith
                                            [ "GameObject" ]
                                            "GameObject"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectDict" ]
                                       "GameObjectDict"
                                       [ Type.namedWith
                                           [ "GameObject" ]
                                           "GameObject"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ executeActionOnGameStateArg, executeActionOnGameStateArg0 ]
    , makeDirtCleaner =
        \makeDirtCleanerArg makeDirtCleanerArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObject" ]
                     , name = "makeDirtCleaner"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "GameObject" ] "DirtId" []
                                  , Type.namedWith
                                      [ "GameObjectDict" ]
                                      "GameObjectDict"
                                      [ Type.namedWith
                                            [ "GameObject" ]
                                            "GameObject"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectDict" ]
                                       "GameObjectDict"
                                       [ Type.namedWith
                                           [ "GameObject" ]
                                           "GameObject"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ makeDirtCleanerArg, makeDirtCleanerArg0 ]
    , cleanDirt =
        \cleanDirtArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObject" ]
                     , name = "cleanDirt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObject" ]
                                      "DirtData"
                                      []
                                  ]
                                  (Type.namedWith [ "GameObject" ] "DirtData" []
                                  )
                             )
                     }
                )
                [ cleanDirtArg ]
    , movePersonWithId =
        \movePersonWithIdArg movePersonWithIdArg0 movePersonWithIdArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObject" ]
                     , name = "movePersonWithId"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObject" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameObject" ]
                                      "Direction"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectDict" ]
                                      "GameObjectDict"
                                      [ Type.namedWith
                                            [ "GameObject" ]
                                            "GameObject"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectDict" ]
                                       "GameObjectDict"
                                       [ Type.namedWith
                                           [ "GameObject" ]
                                           "GameObject"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ movePersonWithIdArg
                , movePersonWithIdArg0
                , movePersonWithIdArg1
                ]
    , movePerson =
        \movePersonArg movePersonArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObject" ]
                     , name = "movePerson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObject" ]
                                      "Direction"
                                      []
                                  , Type.namedWith
                                      [ "GameObject" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObject" ]
                                       "PersonData"
                                       []
                                  )
                             )
                     }
                )
                [ movePersonArg, movePersonArg0 ]
    }


values_ :
    { executeActionOnGameState : Elm.Expression
    , makeDirtCleaner : Elm.Expression
    , cleanDirt : Elm.Expression
    , movePersonWithId : Elm.Expression
    , movePerson : Elm.Expression
    }
values_ =
    { executeActionOnGameState =
        Elm.value
            { importFrom = [ "GameObject" ]
            , name = "executeActionOnGameState"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameObject" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith
                             [ "GameObjectDict" ]
                             "GameObjectDict"
                             [ Type.namedWith [ "GameObject" ] "GameObject" [] ]
                         ]
                         (Type.namedWith
                              [ "GameObjectDict" ]
                              "GameObjectDict"
                              [ Type.namedWith [ "GameObject" ] "GameObject" []
                              ]
                         )
                    )
            }
    , makeDirtCleaner =
        Elm.value
            { importFrom = [ "GameObject" ]
            , name = "makeDirtCleaner"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObject" ] "DirtId" []
                         , Type.namedWith
                             [ "GameObjectDict" ]
                             "GameObjectDict"
                             [ Type.namedWith [ "GameObject" ] "GameObject" [] ]
                         ]
                         (Type.namedWith
                              [ "GameObjectDict" ]
                              "GameObjectDict"
                              [ Type.namedWith [ "GameObject" ] "GameObject" []
                              ]
                         )
                    )
            }
    , cleanDirt =
        Elm.value
            { importFrom = [ "GameObject" ]
            , name = "cleanDirt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObject" ] "DirtData" [] ]
                         (Type.namedWith [ "GameObject" ] "DirtData" [])
                    )
            }
    , movePersonWithId =
        Elm.value
            { importFrom = [ "GameObject" ]
            , name = "movePersonWithId"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObject" ] "PersonId" []
                         , Type.namedWith [ "GameObject" ] "Direction" []
                         , Type.namedWith
                             [ "GameObjectDict" ]
                             "GameObjectDict"
                             [ Type.namedWith [ "GameObject" ] "GameObject" [] ]
                         ]
                         (Type.namedWith
                              [ "GameObjectDict" ]
                              "GameObjectDict"
                              [ Type.namedWith [ "GameObject" ] "GameObject" []
                              ]
                         )
                    )
            }
    , movePerson =
        Elm.value
            { importFrom = [ "GameObject" ]
            , name = "movePerson"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObject" ] "Direction" []
                         , Type.namedWith [ "GameObject" ] "PersonData" []
                         ]
                         (Type.namedWith [ "GameObject" ] "PersonData" [])
                    )
            }
    }