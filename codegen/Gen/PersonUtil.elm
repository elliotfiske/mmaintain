module Gen.PersonUtil exposing
    ( moduleName_, doIncrementClearCount, doIncrementCleanCount, movePersonWithId, createPerson, movePerson
    , call_, values_
    )

{-|
# Generated bindings for PersonUtil

@docs moduleName_, doIncrementClearCount, doIncrementCleanCount, movePersonWithId, createPerson, movePerson
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "PersonUtil" ]


{-| doIncrementClearCount: PersonUtil.PersonData -> PersonUtil.PersonData -}
doIncrementClearCount : Elm.Expression -> Elm.Expression
doIncrementClearCount doIncrementClearCountArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonUtil" ]
             , name = "doIncrementClearCount"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "PersonUtil" ] "PersonData" [] ]
                          (Type.namedWith [ "PersonUtil" ] "PersonData" [])
                     )
             }
        )
        [ doIncrementClearCountArg_ ]


{-| doIncrementCleanCount: PersonUtil.PersonData -> PersonUtil.PersonData -}
doIncrementCleanCount : Elm.Expression -> Elm.Expression
doIncrementCleanCount doIncrementCleanCountArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonUtil" ]
             , name = "doIncrementCleanCount"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "PersonUtil" ] "PersonData" [] ]
                          (Type.namedWith [ "PersonUtil" ] "PersonData" [])
                     )
             }
        )
        [ doIncrementCleanCountArg_ ]


{-| movePersonWithId: 
    GameObjectIds.PersonId
    -> PersonUtil.Direction
    -> PersonDict.PersonDict PersonUtil.PersonData
    -> PersonDict.PersonDict PersonUtil.PersonData
-}
movePersonWithId :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
movePersonWithId movePersonWithIdArg_ movePersonWithIdArg_0 movePersonWithIdArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonUtil" ]
             , name = "movePersonWithId"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                          , Type.namedWith [ "PersonUtil" ] "Direction" []
                          , Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith [ "PersonUtil" ] "PersonData" []
                              ]
                          ]
                          (Type.namedWith
                               [ "PersonDict" ]
                               "PersonDict"
                               [ Type.namedWith [ "PersonUtil" ] "PersonData" []
                               ]
                          )
                     )
             }
        )
        [ movePersonWithIdArg_, movePersonWithIdArg_0, movePersonWithIdArg_1 ]


{-| createPerson: GameObjectIds.PersonId -> String -> PersonUtil.PersonData -}
createPerson : Elm.Expression -> String -> Elm.Expression
createPerson createPersonArg_ createPersonArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonUtil" ]
             , name = "createPerson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                          , Type.string
                          ]
                          (Type.namedWith [ "PersonUtil" ] "PersonData" [])
                     )
             }
        )
        [ createPersonArg_, Elm.string createPersonArg_0 ]


{-| movePerson: 
    GameObjectTypes.Direction
    -> GameObjectTypes.PersonData
    -> GameObjectTypes.PersonData
-}
movePerson : Elm.Expression -> Elm.Expression -> Elm.Expression
movePerson movePersonArg_ movePersonArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonUtil" ]
             , name = "movePerson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Direction" []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith [ "GameObjectTypes" ] "PersonData" [])
                     )
             }
        )
        [ movePersonArg_, movePersonArg_0 ]


call_ :
    { doIncrementClearCount : Elm.Expression -> Elm.Expression
    , doIncrementCleanCount : Elm.Expression -> Elm.Expression
    , movePersonWithId :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , createPerson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , movePerson : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { doIncrementClearCount =
        \doIncrementClearCountArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonUtil" ]
                     , name = "doIncrementClearCount"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "PersonUtil" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "PersonUtil" ]
                                       "PersonData"
                                       []
                                  )
                             )
                     }
                )
                [ doIncrementClearCountArg_ ]
    , doIncrementCleanCount =
        \doIncrementCleanCountArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonUtil" ]
                     , name = "doIncrementCleanCount"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "PersonUtil" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "PersonUtil" ]
                                       "PersonData"
                                       []
                                  )
                             )
                     }
                )
                [ doIncrementCleanCountArg_ ]
    , movePersonWithId =
        \movePersonWithIdArg_ movePersonWithIdArg_0 movePersonWithIdArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonUtil" ]
                     , name = "movePersonWithId"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectIds" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "PersonUtil" ]
                                      "Direction"
                                      []
                                  , Type.namedWith
                                      [ "PersonDict" ]
                                      "PersonDict"
                                      [ Type.namedWith
                                            [ "PersonUtil" ]
                                            "PersonData"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "PersonDict" ]
                                       "PersonDict"
                                       [ Type.namedWith
                                           [ "PersonUtil" ]
                                           "PersonData"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ movePersonWithIdArg_
                , movePersonWithIdArg_0
                , movePersonWithIdArg_1
                ]
    , createPerson =
        \createPersonArg_ createPersonArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonUtil" ]
                     , name = "createPerson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectIds" ]
                                      "PersonId"
                                      []
                                  , Type.string
                                  ]
                                  (Type.namedWith
                                       [ "PersonUtil" ]
                                       "PersonData"
                                       []
                                  )
                             )
                     }
                )
                [ createPersonArg_, createPersonArg_0 ]
    , movePerson =
        \movePersonArg_ movePersonArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonUtil" ]
                     , name = "movePerson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Direction"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "PersonData"
                                       []
                                  )
                             )
                     }
                )
                [ movePersonArg_, movePersonArg_0 ]
    }


values_ :
    { doIncrementClearCount : Elm.Expression
    , doIncrementCleanCount : Elm.Expression
    , movePersonWithId : Elm.Expression
    , createPerson : Elm.Expression
    , movePerson : Elm.Expression
    }
values_ =
    { doIncrementClearCount =
        Elm.value
            { importFrom = [ "PersonUtil" ]
            , name = "doIncrementClearCount"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "PersonUtil" ] "PersonData" [] ]
                         (Type.namedWith [ "PersonUtil" ] "PersonData" [])
                    )
            }
    , doIncrementCleanCount =
        Elm.value
            { importFrom = [ "PersonUtil" ]
            , name = "doIncrementCleanCount"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "PersonUtil" ] "PersonData" [] ]
                         (Type.namedWith [ "PersonUtil" ] "PersonData" [])
                    )
            }
    , movePersonWithId =
        Elm.value
            { importFrom = [ "PersonUtil" ]
            , name = "movePersonWithId"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                         , Type.namedWith [ "PersonUtil" ] "Direction" []
                         , Type.namedWith
                             [ "PersonDict" ]
                             "PersonDict"
                             [ Type.namedWith [ "PersonUtil" ] "PersonData" [] ]
                         ]
                         (Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith [ "PersonUtil" ] "PersonData" []
                              ]
                         )
                    )
            }
    , createPerson =
        Elm.value
            { importFrom = [ "PersonUtil" ]
            , name = "createPerson"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                         , Type.string
                         ]
                         (Type.namedWith [ "PersonUtil" ] "PersonData" [])
                    )
            }
    , movePerson =
        Elm.value
            { importFrom = [ "PersonUtil" ]
            , name = "movePerson"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Direction" []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith [ "GameObjectTypes" ] "PersonData" [])
                    )
            }
    }