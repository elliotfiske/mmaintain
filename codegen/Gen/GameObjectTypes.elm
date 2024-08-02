module Gen.GameObjectTypes exposing (annotation_, call_, caseOf_, dirtIdToInt, make_, moduleName_, personIdToInt, relicIdToInt, values_)

{-| 
@docs moduleName_, relicIdToInt, dirtIdToInt, personIdToInt, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "GameObjectTypes" ]


{-| relicIdToInt: GameObjectTypes.RelicId -> Int -}
relicIdToInt : Elm.Expression -> Elm.Expression
relicIdToInt relicIdToIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObjectTypes" ]
             , name = "relicIdToInt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "RelicId" [] ]
                          Type.int
                     )
             }
        )
        [ relicIdToIntArg ]


{-| dirtIdToInt: GameObjectTypes.DirtId -> Int -}
dirtIdToInt : Elm.Expression -> Elm.Expression
dirtIdToInt dirtIdToIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObjectTypes" ]
             , name = "dirtIdToInt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "DirtId" [] ]
                          Type.int
                     )
             }
        )
        [ dirtIdToIntArg ]


{-| personIdToInt: GameObjectTypes.PersonId -> Int -}
personIdToInt : Elm.Expression -> Elm.Expression
personIdToInt personIdToIntArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameObjectTypes" ]
             , name = "personIdToInt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "PersonId" [] ]
                          Type.int
                     )
             }
        )
        [ personIdToIntArg ]


annotation_ :
    { relicData : Type.Annotation
    , dirtData : Type.Annotation
    , personData : Type.Annotation
    , actionOnGamestate : Type.Annotation
    , direction : Type.Annotation
    , relicType : Type.Annotation
    , relicPosition : Type.Annotation
    , gameObject : Type.Annotation
    , relicId : Type.Annotation
    , dirtId : Type.Annotation
    , personId : Type.Annotation
    }
annotation_ =
    { relicData =
        Type.alias
            moduleName_
            "RelicData"
            []
            (Type.record
                 [ ( "id", Type.namedWith [ "GameObjectTypes" ] "RelicId" [] )
                 , ( "relicType"
                   , Type.namedWith [ "GameObjectTypes" ] "RelicType" []
                   )
                 , ( "position"
                   , Type.namedWith [ "GameObjectTypes" ] "RelicPosition" []
                   )
                 ]
            )
    , dirtData =
        Type.alias
            moduleName_
            "DirtData"
            []
            (Type.record
                 [ ( "id", Type.namedWith [ "GameObjectTypes" ] "DirtId" [] )
                 , ( "amount", Type.int )
                 , ( "x", Type.int )
                 , ( "y", Type.int )
                 ]
            )
    , personData =
        Type.alias
            moduleName_
            "PersonData"
            []
            (Type.record
                 [ ( "id", Type.namedWith [ "GameObjectTypes" ] "PersonId" [] )
                 , ( "name", Type.string )
                 , ( "experience", Type.int )
                 , ( "x", Type.int )
                 , ( "y", Type.int )
                 ]
            )
    , actionOnGamestate =
        Type.namedWith [ "GameObjectTypes" ] "ActionOnGamestate" []
    , direction = Type.namedWith [ "GameObjectTypes" ] "Direction" []
    , relicType = Type.namedWith [ "GameObjectTypes" ] "RelicType" []
    , relicPosition = Type.namedWith [ "GameObjectTypes" ] "RelicPosition" []
    , gameObject = Type.namedWith [ "GameObjectTypes" ] "GameObject" []
    , relicId = Type.namedWith [ "GameObjectTypes" ] "RelicId" []
    , dirtId = Type.namedWith [ "GameObjectTypes" ] "DirtId" []
    , personId = Type.namedWith [ "GameObjectTypes" ] "PersonId" []
    }


make_ :
    { relicData :
        { id : Elm.Expression
        , relicType : Elm.Expression
        , position : Elm.Expression
        }
        -> Elm.Expression
    , dirtData :
        { id : Elm.Expression
        , amount : Elm.Expression
        , x : Elm.Expression
        , y : Elm.Expression
        }
        -> Elm.Expression
    , personData :
        { id : Elm.Expression
        , name : Elm.Expression
        , experience : Elm.Expression
        , x : Elm.Expression
        , y : Elm.Expression
        }
        -> Elm.Expression
    , movePerson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clean : Elm.Expression -> Elm.Expression
    , up : Elm.Expression
    , down : Elm.Expression
    , left : Elm.Expression
    , right : Elm.Expression
    , cleanFast : Elm.Expression
    , moreXP : Elm.Expression
    , heldBy : Elm.Expression -> Elm.Expression
    , onFloor : Elm.Expression -> Elm.Expression -> Elm.Expression
    , person : Elm.Expression -> Elm.Expression
    , dirt : Elm.Expression -> Elm.Expression
    , relic : Elm.Expression -> Elm.Expression
    , relicId : Elm.Expression -> Elm.Expression
    , dirtId : Elm.Expression -> Elm.Expression
    , personId : Elm.Expression -> Elm.Expression
    }
make_ =
    { relicData =
        \relicData_args ->
            Elm.withType
                (Type.alias
                     [ "GameObjectTypes" ]
                     "RelicData"
                     []
                     (Type.record
                          [ ( "id"
                            , Type.namedWith [ "GameObjectTypes" ] "RelicId" []
                            )
                          , ( "relicType"
                            , Type.namedWith
                                  [ "GameObjectTypes" ]
                                  "RelicType"
                                  []
                            )
                          , ( "position"
                            , Type.namedWith
                                  [ "GameObjectTypes" ]
                                  "RelicPosition"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "id" relicData_args.id
                     , Tuple.pair "relicType" relicData_args.relicType
                     , Tuple.pair "position" relicData_args.position
                     ]
                )
    , dirtData =
        \dirtData_args ->
            Elm.withType
                (Type.alias
                     [ "GameObjectTypes" ]
                     "DirtData"
                     []
                     (Type.record
                          [ ( "id"
                            , Type.namedWith [ "GameObjectTypes" ] "DirtId" []
                            )
                          , ( "amount", Type.int )
                          , ( "x", Type.int )
                          , ( "y", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "id" dirtData_args.id
                     , Tuple.pair "amount" dirtData_args.amount
                     , Tuple.pair "x" dirtData_args.x
                     , Tuple.pair "y" dirtData_args.y
                     ]
                )
    , personData =
        \personData_args ->
            Elm.withType
                (Type.alias
                     [ "GameObjectTypes" ]
                     "PersonData"
                     []
                     (Type.record
                          [ ( "id"
                            , Type.namedWith [ "GameObjectTypes" ] "PersonId" []
                            )
                          , ( "name", Type.string )
                          , ( "experience", Type.int )
                          , ( "x", Type.int )
                          , ( "y", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "id" personData_args.id
                     , Tuple.pair "name" personData_args.name
                     , Tuple.pair "experience" personData_args.experience
                     , Tuple.pair "x" personData_args.x
                     , Tuple.pair "y" personData_args.y
                     ]
                )
    , movePerson =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "MovePerson"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0, ar1 ]
    , clean =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "Clean"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0 ]
    , up =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Up"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , down =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Down"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , left =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Left"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , right =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Right"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , cleanFast =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "CleanFast"
            , annotation = Just (Type.namedWith [] "RelicType" [])
            }
    , moreXP =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "MoreXP"
            , annotation = Just (Type.namedWith [] "RelicType" [])
            }
    , heldBy =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "HeldBy"
                     , annotation = Just (Type.namedWith [] "RelicPosition" [])
                     }
                )
                [ ar0 ]
    , onFloor =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "OnFloor"
                     , annotation = Just (Type.namedWith [] "RelicPosition" [])
                     }
                )
                [ ar0, ar1 ]
    , person =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "Person"
                     , annotation = Just (Type.namedWith [] "GameObject" [])
                     }
                )
                [ ar0 ]
    , dirt =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "Dirt"
                     , annotation = Just (Type.namedWith [] "GameObject" [])
                     }
                )
                [ ar0 ]
    , relic =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "Relic"
                     , annotation = Just (Type.namedWith [] "GameObject" [])
                     }
                )
                [ ar0 ]
    , relicId =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "RelicId"
                     , annotation = Just (Type.namedWith [] "RelicId" [])
                     }
                )
                [ ar0 ]
    , dirtId =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "DirtId"
                     , annotation = Just (Type.namedWith [] "DirtId" [])
                     }
                )
                [ ar0 ]
    , personId =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "PersonId"
                     , annotation = Just (Type.namedWith [] "PersonId" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { actionOnGamestate :
        Elm.Expression
        -> { actionOnGamestateTags_0_0
            | movePerson : Elm.Expression -> Elm.Expression -> Elm.Expression
            , clean : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , direction :
        Elm.Expression
        -> { directionTags_1_0
            | up : Elm.Expression
            , down : Elm.Expression
            , left : Elm.Expression
            , right : Elm.Expression
        }
        -> Elm.Expression
    , relicType :
        Elm.Expression
        -> { relicTypeTags_2_0
            | cleanFast : Elm.Expression
            , moreXP : Elm.Expression
        }
        -> Elm.Expression
    , relicPosition :
        Elm.Expression
        -> { relicPositionTags_3_0
            | heldBy : Elm.Expression -> Elm.Expression
            , onFloor : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , gameObject :
        Elm.Expression
        -> { gameObjectTags_4_0
            | person : Elm.Expression -> Elm.Expression
            , dirt : Elm.Expression -> Elm.Expression
            , relic : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , relicId :
        Elm.Expression
        -> { relicIdTags_5_0 | relicId : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    , dirtId :
        Elm.Expression
        -> { dirtIdTags_6_0 | dirtId : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    , personId :
        Elm.Expression
        -> { personIdTags_7_0 | personId : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { actionOnGamestate =
        \actionOnGamestateExpression actionOnGamestateTags ->
            Elm.Case.custom
                actionOnGamestateExpression
                (Type.namedWith [ "GameObjectTypes" ] "ActionOnGamestate" [])
                [ Elm.Case.branch2
                    "MovePerson"
                    ( "gameObjectTypesPersonId"
                    , Type.namedWith [ "GameObjectTypes" ] "PersonId" []
                    )
                    ( "gameObjectTypesDirection"
                    , Type.namedWith [ "GameObjectTypes" ] "Direction" []
                    )
                    actionOnGamestateTags.movePerson
                , Elm.Case.branch1
                    "Clean"
                    ( "gameObjectTypesDirtId"
                    , Type.namedWith [ "GameObjectTypes" ] "DirtId" []
                    )
                    actionOnGamestateTags.clean
                ]
    , direction =
        \directionExpression directionTags ->
            Elm.Case.custom
                directionExpression
                (Type.namedWith [ "GameObjectTypes" ] "Direction" [])
                [ Elm.Case.branch0 "Up" directionTags.up
                , Elm.Case.branch0 "Down" directionTags.down
                , Elm.Case.branch0 "Left" directionTags.left
                , Elm.Case.branch0 "Right" directionTags.right
                ]
    , relicType =
        \relicTypeExpression relicTypeTags ->
            Elm.Case.custom
                relicTypeExpression
                (Type.namedWith [ "GameObjectTypes" ] "RelicType" [])
                [ Elm.Case.branch0 "CleanFast" relicTypeTags.cleanFast
                , Elm.Case.branch0 "MoreXP" relicTypeTags.moreXP
                ]
    , relicPosition =
        \relicPositionExpression relicPositionTags ->
            Elm.Case.custom
                relicPositionExpression
                (Type.namedWith [ "GameObjectTypes" ] "RelicPosition" [])
                [ Elm.Case.branch1
                    "HeldBy"
                    ( "gameObjectTypesPersonId"
                    , Type.namedWith [ "GameObjectTypes" ] "PersonId" []
                    )
                    relicPositionTags.heldBy
                , Elm.Case.branch2
                    "OnFloor"
                    ( "basicsInt", Type.int )
                    ( "basicsInt", Type.int )
                    relicPositionTags.onFloor
                ]
    , gameObject =
        \gameObjectExpression gameObjectTags ->
            Elm.Case.custom
                gameObjectExpression
                (Type.namedWith [ "GameObjectTypes" ] "GameObject" [])
                [ Elm.Case.branch1
                    "Person"
                    ( "gameObjectTypesPersonData"
                    , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                    )
                    gameObjectTags.person
                , Elm.Case.branch1
                    "Dirt"
                    ( "gameObjectTypesDirtData"
                    , Type.namedWith [ "GameObjectTypes" ] "DirtData" []
                    )
                    gameObjectTags.dirt
                , Elm.Case.branch1
                    "Relic"
                    ( "gameObjectTypesRelicData"
                    , Type.namedWith [ "GameObjectTypes" ] "RelicData" []
                    )
                    gameObjectTags.relic
                ]
    , relicId =
        \relicIdExpression relicIdTags ->
            Elm.Case.custom
                relicIdExpression
                (Type.namedWith [ "GameObjectTypes" ] "RelicId" [])
                [ Elm.Case.branch1
                    "RelicId"
                    ( "basicsInt", Type.int )
                    relicIdTags.relicId
                ]
    , dirtId =
        \dirtIdExpression dirtIdTags ->
            Elm.Case.custom
                dirtIdExpression
                (Type.namedWith [ "GameObjectTypes" ] "DirtId" [])
                [ Elm.Case.branch1
                    "DirtId"
                    ( "basicsInt", Type.int )
                    dirtIdTags.dirtId
                ]
    , personId =
        \personIdExpression personIdTags ->
            Elm.Case.custom
                personIdExpression
                (Type.namedWith [ "GameObjectTypes" ] "PersonId" [])
                [ Elm.Case.branch1
                    "PersonId"
                    ( "basicsInt", Type.int )
                    personIdTags.personId
                ]
    }


call_ :
    { relicIdToInt : Elm.Expression -> Elm.Expression
    , dirtIdToInt : Elm.Expression -> Elm.Expression
    , personIdToInt : Elm.Expression -> Elm.Expression
    }
call_ =
    { relicIdToInt =
        \relicIdToIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "relicIdToInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "RelicId"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ relicIdToIntArg ]
    , dirtIdToInt =
        \dirtIdToIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "dirtIdToInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "DirtId"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ dirtIdToIntArg ]
    , personIdToInt =
        \personIdToIntArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "personIdToInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonId"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ personIdToIntArg ]
    }


values_ :
    { relicIdToInt : Elm.Expression
    , dirtIdToInt : Elm.Expression
    , personIdToInt : Elm.Expression
    }
values_ =
    { relicIdToInt =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "relicIdToInt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "RelicId" [] ]
                         Type.int
                    )
            }
    , dirtIdToInt =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "dirtIdToInt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "DirtId" [] ]
                         Type.int
                    )
            }
    , personIdToInt =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "personIdToInt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "PersonId" [] ]
                         Type.int
                    )
            }
    }