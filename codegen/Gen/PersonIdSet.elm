module Gen.PersonIdSet exposing
    ( moduleName_, member, remove, insert, size, annotation_
    , make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for PersonIdSet

@docs moduleName_, member, remove, insert, size, annotation_
@docs make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "PersonIdSet" ]


{-| member: GameObjectIds.PersonId -> PersonIdSet.PersonIdSet -> Bool -}
member : Elm.Expression -> Elm.Expression -> Elm.Expression
member memberArg_ memberArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonIdSet" ]
             , name = "member"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                          , Type.namedWith [ "PersonIdSet" ] "PersonIdSet" []
                          ]
                          Type.bool
                     )
             }
        )
        [ memberArg_, memberArg_0 ]


{-| remove: GameObjectIds.PersonId -> PersonIdSet.PersonIdSet -> PersonIdSet.PersonIdSet -}
remove : Elm.Expression -> Elm.Expression -> Elm.Expression
remove removeArg_ removeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonIdSet" ]
             , name = "remove"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                          , Type.namedWith [ "PersonIdSet" ] "PersonIdSet" []
                          ]
                          (Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [])
                     )
             }
        )
        [ removeArg_, removeArg_0 ]


{-| insert: GameObjectIds.PersonId -> PersonIdSet.PersonIdSet -> PersonIdSet.PersonIdSet -}
insert : Elm.Expression -> Elm.Expression -> Elm.Expression
insert insertArg_ insertArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonIdSet" ]
             , name = "insert"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                          , Type.namedWith [ "PersonIdSet" ] "PersonIdSet" []
                          ]
                          (Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [])
                     )
             }
        )
        [ insertArg_, insertArg_0 ]


{-| size: PersonIdSet.PersonIdSet -> Int -}
size : Elm.Expression -> Elm.Expression
size sizeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "PersonIdSet" ]
             , name = "size"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [] ]
                          Type.int
                     )
             }
        )
        [ sizeArg_ ]


annotation_ : { personIdSet : Type.Annotation }
annotation_ =
    { personIdSet = Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [] }


make_ : { personIdSet : Elm.Expression -> Elm.Expression }
make_ =
    { personIdSet =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonIdSet" ]
                     , name = "PersonIdSet"
                     , annotation = Just (Type.namedWith [] "PersonIdSet" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { personIdSet :
        Elm.Expression
        -> { personIdSet : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { personIdSet =
        \personIdSetExpression personIdSetTags ->
            Elm.Case.custom
                personIdSetExpression
                (Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "PersonIdSet"
                       personIdSetTags.personIdSet |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "setSet"
                                                                   (Type.namedWith
                                                                          [ "Set"
                                                                          ]
                                                                          "Set"
                                                                          [ Type.string
                                                                          ]
                                                                   )
                                                            )
                    )
                    Basics.identity
                ]
    }


call_ :
    { member : Elm.Expression -> Elm.Expression -> Elm.Expression
    , remove : Elm.Expression -> Elm.Expression -> Elm.Expression
    , insert : Elm.Expression -> Elm.Expression -> Elm.Expression
    , size : Elm.Expression -> Elm.Expression
    }
call_ =
    { member =
        \memberArg_ memberArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonIdSet" ]
                     , name = "member"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectIds" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "PersonIdSet" ]
                                      "PersonIdSet"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ memberArg_, memberArg_0 ]
    , remove =
        \removeArg_ removeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonIdSet" ]
                     , name = "remove"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectIds" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "PersonIdSet" ]
                                      "PersonIdSet"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "PersonIdSet" ]
                                       "PersonIdSet"
                                       []
                                  )
                             )
                     }
                )
                [ removeArg_, removeArg_0 ]
    , insert =
        \insertArg_ insertArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonIdSet" ]
                     , name = "insert"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectIds" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "PersonIdSet" ]
                                      "PersonIdSet"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "PersonIdSet" ]
                                       "PersonIdSet"
                                       []
                                  )
                             )
                     }
                )
                [ insertArg_, insertArg_0 ]
    , size =
        \sizeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PersonIdSet" ]
                     , name = "size"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "PersonIdSet" ]
                                      "PersonIdSet"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ sizeArg_ ]
    }


values_ :
    { member : Elm.Expression
    , remove : Elm.Expression
    , insert : Elm.Expression
    , size : Elm.Expression
    }
values_ =
    { member =
        Elm.value
            { importFrom = [ "PersonIdSet" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                         , Type.namedWith [ "PersonIdSet" ] "PersonIdSet" []
                         ]
                         Type.bool
                    )
            }
    , remove =
        Elm.value
            { importFrom = [ "PersonIdSet" ]
            , name = "remove"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                         , Type.namedWith [ "PersonIdSet" ] "PersonIdSet" []
                         ]
                         (Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [])
                    )
            }
    , insert =
        Elm.value
            { importFrom = [ "PersonIdSet" ]
            , name = "insert"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectIds" ] "PersonId" []
                         , Type.namedWith [ "PersonIdSet" ] "PersonIdSet" []
                         ]
                         (Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [])
                    )
            }
    , size =
        Elm.value
            { importFrom = [ "PersonIdSet" ]
            , name = "size"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "PersonIdSet" ] "PersonIdSet" [] ]
                         Type.int
                    )
            }
    }