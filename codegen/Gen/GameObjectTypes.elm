module Gen.GameObjectTypes exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for GameObjectTypes

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "GameObjectTypes" ]


annotation_ :
    { relicData : Type.Annotation
    , dirtData : Type.Annotation
    , personData : Type.Annotation
    , personStats : Type.Annotation
    , point : Type.Annotation
    , actionOnGamestate : Type.Annotation
    , direction : Type.Annotation
    , relicRarity : Type.Annotation
    , relicType : Type.Annotation
    , relicPosition : Type.Annotation
    }
annotation_ =
    { relicData =
        Type.alias
            moduleName_
            "RelicData"
            []
            (Type.record
                 [ ( "id", Type.namedWith [ "GameObjectIds" ] "RelicId" [] )
                 , ( "relicType"
                   , Type.namedWith [ "GameObjectTypes" ] "RelicType" []
                   )
                 , ( "rarity"
                   , Type.namedWith [ "GameObjectTypes" ] "RelicRarity" []
                   )
                 , ( "exp", Type.int )
                 ]
            )
    , dirtData =
        Type.alias
            moduleName_
            "DirtData"
            []
            (Type.record
                 [ ( "id", Type.namedWith [ "GameObjectIds" ] "DirtId" [] )
                 , ( "amount", Type.int )
                 , ( "position"
                   , Type.namedWith [ "GameObjectTypes" ] "Point" []
                   )
                 ]
            )
    , personData =
        Type.alias
            moduleName_
            "PersonData"
            []
            (Type.record
                 [ ( "id", Type.namedWith [ "GameObjectIds" ] "PersonId" [] )
                 , ( "name", Type.string )
                 , ( "experience", Type.int )
                 , ( "position"
                   , Type.namedWith [ "GameObjectTypes" ] "Point" []
                   )
                 , ( "stats"
                   , Type.namedWith [ "GameObjectTypes" ] "PersonStats" []
                   )
                 ]
            )
    , personStats =
        Type.alias
            moduleName_
            "PersonStats"
            []
            (Type.record
                 [ ( "cleanCount", Type.int ), ( "clearCount", Type.int ) ]
            )
    , point =
        Type.alias
            moduleName_
            "Point"
            []
            (Type.record [ ( "x", Type.int ), ( "y", Type.int ) ])
    , actionOnGamestate =
        Type.namedWith [ "GameObjectTypes" ] "ActionOnGamestate" []
    , direction = Type.namedWith [ "GameObjectTypes" ] "Direction" []
    , relicRarity = Type.namedWith [ "GameObjectTypes" ] "RelicRarity" []
    , relicType = Type.namedWith [ "GameObjectTypes" ] "RelicType" []
    , relicPosition = Type.namedWith [ "GameObjectTypes" ] "RelicPosition" []
    }


make_ :
    { relicData :
        { id : Elm.Expression
        , relicType : Elm.Expression
        , rarity : Elm.Expression
        , exp : Elm.Expression
        }
        -> Elm.Expression
    , dirtData :
        { id : Elm.Expression
        , amount : Elm.Expression
        , position : Elm.Expression
        }
        -> Elm.Expression
    , personData :
        { id : Elm.Expression
        , name : Elm.Expression
        , experience : Elm.Expression
        , position : Elm.Expression
        , stats : Elm.Expression
        }
        -> Elm.Expression
    , personStats :
        { cleanCount : Elm.Expression, clearCount : Elm.Expression }
        -> Elm.Expression
    , point : { x : Elm.Expression, y : Elm.Expression } -> Elm.Expression
    , movePerson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clean : Elm.Expression -> Elm.Expression -> Elm.Expression
    , addDirt : Elm.Expression -> Elm.Expression
    , addRelic : Elm.Expression -> Elm.Expression -> Elm.Expression
    , addPerson : Elm.Expression -> Elm.Expression
    , pickUpRelic : Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropRelic : Elm.Expression -> Elm.Expression -> Elm.Expression
    , activateGenerosityTrap :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , batchAction : Elm.Expression -> Elm.Expression
    , gameStateNoOp : Elm.Expression
    , up : Elm.Expression
    , down : Elm.Expression
    , left : Elm.Expression
    , right : Elm.Expression
    , upLeft : Elm.Expression
    , upRight : Elm.Expression
    , downLeft : Elm.Expression
    , downRight : Elm.Expression
    , common : Elm.Expression
    , uncommon : Elm.Expression
    , rare : Elm.Expression
    , epic : Elm.Expression
    , legendary : Elm.Expression
    , cleanFast : Elm.Expression
    , moreXP : Elm.Expression
    , dropAndDouble : Elm.Expression -> Elm.Expression
    , splashBucket : Elm.Expression
    , guestBook : Elm.Expression -> Elm.Expression
    , heldBy : Elm.Expression -> Elm.Expression
    , onFloor : Elm.Expression -> Elm.Expression
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
                            , Type.namedWith [ "GameObjectIds" ] "RelicId" []
                            )
                          , ( "relicType"
                            , Type.namedWith
                                  [ "GameObjectTypes" ]
                                  "RelicType"
                                  []
                            )
                          , ( "rarity"
                            , Type.namedWith
                                  [ "GameObjectTypes" ]
                                  "RelicRarity"
                                  []
                            )
                          , ( "exp", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "id" relicData_args.id
                     , Tuple.pair "relicType" relicData_args.relicType
                     , Tuple.pair "rarity" relicData_args.rarity
                     , Tuple.pair "exp" relicData_args.exp
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
                            , Type.namedWith [ "GameObjectIds" ] "DirtId" []
                            )
                          , ( "amount", Type.int )
                          , ( "position"
                            , Type.namedWith [ "GameObjectTypes" ] "Point" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "id" dirtData_args.id
                     , Tuple.pair "amount" dirtData_args.amount
                     , Tuple.pair "position" dirtData_args.position
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
                            , Type.namedWith [ "GameObjectIds" ] "PersonId" []
                            )
                          , ( "name", Type.string )
                          , ( "experience", Type.int )
                          , ( "position"
                            , Type.namedWith [ "GameObjectTypes" ] "Point" []
                            )
                          , ( "stats"
                            , Type.namedWith
                                  [ "GameObjectTypes" ]
                                  "PersonStats"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "id" personData_args.id
                     , Tuple.pair "name" personData_args.name
                     , Tuple.pair "experience" personData_args.experience
                     , Tuple.pair "position" personData_args.position
                     , Tuple.pair "stats" personData_args.stats
                     ]
                )
    , personStats =
        \personStats_args ->
            Elm.withType
                (Type.alias
                     [ "GameObjectTypes" ]
                     "PersonStats"
                     []
                     (Type.record
                          [ ( "cleanCount", Type.int )
                          , ( "clearCount", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "cleanCount" personStats_args.cleanCount
                     , Tuple.pair "clearCount" personStats_args.clearCount
                     ]
                )
    , point =
        \point_args ->
            Elm.withType
                (Type.alias
                     [ "GameObjectTypes" ]
                     "Point"
                     []
                     (Type.record [ ( "x", Type.int ), ( "y", Type.int ) ])
                )
                (Elm.record
                     [ Tuple.pair "x" point_args.x
                     , Tuple.pair "y" point_args.y
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
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "Clean"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0, ar1 ]
    , addDirt =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "AddDirt"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0 ]
    , addRelic =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "AddRelic"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0, ar1 ]
    , addPerson =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "AddPerson"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0 ]
    , pickUpRelic =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "PickUpRelic"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0, ar1 ]
    , dropRelic =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "DropRelic"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0, ar1 ]
    , activateGenerosityTrap =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "ActivateGenerosityTrap"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0, ar1, ar2 ]
    , batchAction =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "BatchAction"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0 ]
    , gameStateNoOp =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "GameStateNoOp"
            , annotation = Just (Type.namedWith [] "ActionOnGamestate" [])
            }
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
    , upLeft =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "UpLeft"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , upRight =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "UpRight"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , downLeft =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "DownLeft"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , downRight =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "DownRight"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , common =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Common"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , uncommon =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Uncommon"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , rare =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Rare"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , epic =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Epic"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , legendary =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "Legendary"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
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
    , dropAndDouble =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "DropAndDouble"
                     , annotation = Just (Type.namedWith [] "RelicType" [])
                     }
                )
                [ ar0 ]
    , splashBucket =
        Elm.value
            { importFrom = [ "GameObjectTypes" ]
            , name = "SplashBucket"
            , annotation = Just (Type.namedWith [] "RelicType" [])
            }
    , guestBook =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "GuestBook"
                     , annotation = Just (Type.namedWith [] "RelicType" [])
                     }
                )
                [ ar0 ]
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
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameObjectTypes" ]
                     , name = "OnFloor"
                     , annotation = Just (Type.namedWith [] "RelicPosition" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ =
    { actionOnGamestate =
        \actionOnGamestateExpression actionOnGamestateTags ->
            Elm.Case.custom
                actionOnGamestateExpression
                (Type.namedWith [ "GameObjectTypes" ] "ActionOnGamestate" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "MovePerson"
                       actionOnGamestateTags.movePerson |> Elm.Arg.item
                                                                 (Elm.Arg.varWith
                                                                        "gameObjectIdsPersonId"
                                                                        (Type.namedWith
                                                                               [ "GameObjectIds"
                                                                               ]
                                                                               "PersonId"
                                                                               []
                                                                        )
                                                                 ) |> Elm.Arg.item
                                                                            (Elm.Arg.varWith
                                                                                   "gameObjectTypesDirection"
                                                                                   (Type.namedWith
                                                                                          [ "GameObjectTypes"
                                                                                          ]
                                                                                          "Direction"
                                                                                          []
                                                                                   )
                                                                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Clean"
                       actionOnGamestateTags.clean |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "gameObjectIdsPersonId"
                                                                   (Type.namedWith
                                                                          [ "GameObjectIds"
                                                                          ]
                                                                          "PersonId"
                                                                          []
                                                                   )
                                                            ) |> Elm.Arg.item
                                                                       (Elm.Arg.varWith
                                                                              "gameObjectTypesPoint"
                                                                              (Type.namedWith
                                                                                     [ "GameObjectTypes"
                                                                                     ]
                                                                                     "Point"
                                                                                     []
                                                                              )
                                                                       )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "AddDirt"
                       actionOnGamestateTags.addDirt |> Elm.Arg.item
                                                              (Elm.Arg.varWith
                                                                     "gameObjectTypesDirtData"
                                                                     (Type.namedWith
                                                                            [ "GameObjectTypes"
                                                                            ]
                                                                            "DirtData"
                                                                            []
                                                                     )
                                                              )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "AddRelic"
                       actionOnGamestateTags.addRelic |> Elm.Arg.item
                                                               (Elm.Arg.varWith
                                                                      "gameObjectTypesRelicData"
                                                                      (Type.namedWith
                                                                             [ "GameObjectTypes"
                                                                             ]
                                                                             "RelicData"
                                                                             []
                                                                      )
                                                               ) |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "gameObjectTypesPoint"
                                                                                 (Type.namedWith
                                                                                        [ "GameObjectTypes"
                                                                                        ]
                                                                                        "Point"
                                                                                        []
                                                                                 )
                                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "AddPerson"
                       actionOnGamestateTags.addPerson |> Elm.Arg.item
                                                                (Elm.Arg.varWith
                                                                       "gameObjectTypesPersonData"
                                                                       (Type.namedWith
                                                                              [ "GameObjectTypes"
                                                                              ]
                                                                              "PersonData"
                                                                              []
                                                                       )
                                                                )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PickUpRelic"
                       actionOnGamestateTags.pickUpRelic |> Elm.Arg.item
                                                                  (Elm.Arg.varWith
                                                                         "gameObjectIdsRelicId"
                                                                         (Type.namedWith
                                                                                [ "GameObjectIds"
                                                                                ]
                                                                                "RelicId"
                                                                                []
                                                                         )
                                                                  ) |> Elm.Arg.item
                                                                             (Elm.Arg.varWith
                                                                                    "gameObjectIdsPersonId"
                                                                                    (Type.namedWith
                                                                                           [ "GameObjectIds"
                                                                                           ]
                                                                                           "PersonId"
                                                                                           []
                                                                                    )
                                                                             )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DropRelic"
                       actionOnGamestateTags.dropRelic |> Elm.Arg.item
                                                                (Elm.Arg.varWith
                                                                       "gameObjectIdsRelicId"
                                                                       (Type.namedWith
                                                                              [ "GameObjectIds"
                                                                              ]
                                                                              "RelicId"
                                                                              []
                                                                       )
                                                                ) |> Elm.Arg.item
                                                                           (Elm.Arg.varWith
                                                                                  "gameObjectIdsPersonId"
                                                                                  (Type.namedWith
                                                                                         [ "GameObjectIds"
                                                                                         ]
                                                                                         "PersonId"
                                                                                         []
                                                                                  )
                                                                           )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ActivateGenerosityTrap"
                       actionOnGamestateTags.activateGenerosityTrap |> Elm.Arg.item
                                                                             (Elm.Arg.varWith
                                                                                    "gameObjectIdsPersonId"
                                                                                    (Type.namedWith
                                                                                           [ "GameObjectIds"
                                                                                           ]
                                                                                           "PersonId"
                                                                                           []
                                                                                    )
                                                                             ) |> Elm.Arg.item
                                                                                        (Elm.Arg.varWith
                                                                                               "gameObjectIdsRelicId"
                                                                                               (Type.namedWith
                                                                                                      [ "GameObjectIds"
                                                                                                      ]
                                                                                                      "RelicId"
                                                                                                      []
                                                                                               )
                                                                                        ) |> Elm.Arg.item
                                                                                                   (Elm.Arg.varWith
                                                                                                          "arg_2"
                                                                                                          Type.int
                                                                                                   )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BatchAction"
                       actionOnGamestateTags.batchAction |> Elm.Arg.item
                                                                  (Elm.Arg.varWith
                                                                         "arg_0"
                                                                         (Type.list
                                                                                (Type.namedWith
                                                                                       [ "GameObjectTypes"
                                                                                       ]
                                                                                       "ActionOnGamestate"
                                                                                       []
                                                                                )
                                                                         )
                                                                  )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "GameStateNoOp"
                       actionOnGamestateTags.gameStateNoOp
                    )
                    Basics.identity
                ]
    , direction =
        \directionExpression directionTags ->
            Elm.Case.custom
                directionExpression
                (Type.namedWith [ "GameObjectTypes" ] "Direction" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Up" directionTags.up)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Down" directionTags.down)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Left" directionTags.left)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Right" directionTags.right)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "UpLeft" directionTags.upLeft)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "UpRight" directionTags.upRight)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "DownLeft" directionTags.downLeft)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "DownRight" directionTags.downRight)
                    Basics.identity
                ]
    , relicRarity =
        \relicRarityExpression relicRarityTags ->
            Elm.Case.custom
                relicRarityExpression
                (Type.namedWith [ "GameObjectTypes" ] "RelicRarity" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Common" relicRarityTags.common)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Uncommon" relicRarityTags.uncommon)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Rare" relicRarityTags.rare)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Epic" relicRarityTags.epic)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Legendary" relicRarityTags.legendary)
                    Basics.identity
                ]
    , relicType =
        \relicTypeExpression relicTypeTags ->
            Elm.Case.custom
                relicTypeExpression
                (Type.namedWith [ "GameObjectTypes" ] "RelicType" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "CleanFast" relicTypeTags.cleanFast)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "MoreXP" relicTypeTags.moreXP)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DropAndDouble"
                       relicTypeTags.dropAndDouble |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "arg_0"
                                                                   (Type.list
                                                                          (Type.namedWith
                                                                                 [ "GameObjectIds"
                                                                                 ]
                                                                                 "PersonId"
                                                                                 []
                                                                          )
                                                                   )
                                                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "SplashBucket"
                       relicTypeTags.splashBucket
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "GuestBook"
                       relicTypeTags.guestBook |> Elm.Arg.item
                                                        (Elm.Arg.varWith
                                                               "setSet"
                                                               (Type.namedWith
                                                                      [ "Set" ]
                                                                      "Set"
                                                                      [ Type.string
                                                                      ]
                                                               )
                                                        )
                    )
                    Basics.identity
                ]
    , relicPosition =
        \relicPositionExpression relicPositionTags ->
            Elm.Case.custom
                relicPositionExpression
                (Type.namedWith [ "GameObjectTypes" ] "RelicPosition" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "HeldBy"
                       relicPositionTags.heldBy |> Elm.Arg.item
                                                         (Elm.Arg.varWith
                                                                "gameObjectIdsPersonId"
                                                                (Type.namedWith
                                                                       [ "GameObjectIds"
                                                                       ]
                                                                       "PersonId"
                                                                       []
                                                                )
                                                         )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "OnFloor"
                       relicPositionTags.onFloor |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "gameObjectTypesPoint"
                                                                 (Type.namedWith
                                                                        [ "GameObjectTypes"
                                                                        ]
                                                                        "Point"
                                                                        []
                                                                 )
                                                          )
                    )
                    Basics.identity
                ]
    }