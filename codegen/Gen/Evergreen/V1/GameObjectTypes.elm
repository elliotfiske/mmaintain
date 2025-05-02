module Gen.Evergreen.V1.GameObjectTypes exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Evergreen.V1.GameObjectTypes

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Evergreen", "V1", "GameObjectTypes" ]


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
                 [ ( "id"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "RelicId"
                         []
                   )
                 , ( "relicType"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "RelicType"
                         []
                   )
                 , ( "rarity"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "RelicRarity"
                         []
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
                 [ ( "id"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "DirtId"
                         []
                   )
                 , ( "amount", Type.int )
                 , ( "position"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "Point"
                         []
                   )
                 ]
            )
    , personData =
        Type.alias
            moduleName_
            "PersonData"
            []
            (Type.record
                 [ ( "id"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "PersonId"
                         []
                   )
                 , ( "name", Type.string )
                 , ( "experience", Type.int )
                 , ( "position"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "Point"
                         []
                   )
                 , ( "stats"
                   , Type.namedWith
                         [ "Evergreen", "V1", "GameObjectTypes" ]
                         "PersonStats"
                         []
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
        Type.namedWith
            [ "Evergreen", "V1", "GameObjectTypes" ]
            "ActionOnGamestate"
            []
    , direction =
        Type.namedWith [ "Evergreen", "V1", "GameObjectTypes" ] "Direction" []
    , relicRarity =
        Type.namedWith [ "Evergreen", "V1", "GameObjectTypes" ] "RelicRarity" []
    , relicType =
        Type.namedWith [ "Evergreen", "V1", "GameObjectTypes" ] "RelicType" []
    , relicId =
        Type.namedWith [ "Evergreen", "V1", "GameObjectTypes" ] "RelicId" []
    , dirtId =
        Type.namedWith [ "Evergreen", "V1", "GameObjectTypes" ] "DirtId" []
    , personId =
        Type.namedWith [ "Evergreen", "V1", "GameObjectTypes" ] "PersonId" []
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
    , relicId : Elm.Expression -> Elm.Expression
    , dirtId : Elm.Expression -> Elm.Expression
    , personId : Elm.Expression -> Elm.Expression
    }
make_ =
    { relicData =
        \relicData_args ->
            Elm.withType
                (Type.alias
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "RelicData"
                     []
                     (Type.record
                          [ ( "id"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "RelicId"
                                  []
                            )
                          , ( "relicType"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "RelicType"
                                  []
                            )
                          , ( "rarity"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "DirtData"
                     []
                     (Type.record
                          [ ( "id"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "DirtId"
                                  []
                            )
                          , ( "amount", Type.int )
                          , ( "position"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "Point"
                                  []
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
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "PersonData"
                     []
                     (Type.record
                          [ ( "id"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "PersonId"
                                  []
                            )
                          , ( "name", Type.string )
                          , ( "experience", Type.int )
                          , ( "position"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
                                  "Point"
                                  []
                            )
                          , ( "stats"
                            , Type.namedWith
                                  [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
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
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
                     , name = "ActivateGenerosityTrap"
                     , annotation =
                         Just (Type.namedWith [] "ActionOnGamestate" [])
                     }
                )
                [ ar0, ar1, ar2 ]
    , gameStateNoOp =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "GameStateNoOp"
            , annotation = Just (Type.namedWith [] "ActionOnGamestate" [])
            }
    , up =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Up"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , down =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Down"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , left =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Left"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , right =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Right"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , upLeft =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "UpLeft"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , upRight =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "UpRight"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , downLeft =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "DownLeft"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , downRight =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "DownRight"
            , annotation = Just (Type.namedWith [] "Direction" [])
            }
    , common =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Common"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , uncommon =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Uncommon"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , rare =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Rare"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , epic =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Epic"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , legendary =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "Legendary"
            , annotation = Just (Type.namedWith [] "RelicRarity" [])
            }
    , cleanFast =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "CleanFast"
            , annotation = Just (Type.namedWith [] "RelicType" [])
            }
    , moreXP =
        Elm.value
            { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
            , name = "MoreXP"
            , annotation = Just (Type.namedWith [] "RelicType" [])
            }
    , dropAndDouble =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
                     , name = "DropAndDouble"
                     , annotation = Just (Type.namedWith [] "RelicType" [])
                     }
                )
                [ ar0 ]
    , relicId =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
                     , name = "RelicId"
                     , annotation = Just (Type.namedWith [] "RelicId" [])
                     }
                )
                [ ar0 ]
    , dirtId =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
                     , name = "DirtId"
                     , annotation = Just (Type.namedWith [] "DirtId" [])
                     }
                )
                [ ar0 ]
    , personId =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "GameObjectTypes" ]
                     , name = "PersonId"
                     , annotation = Just (Type.namedWith [] "PersonId" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ =
    { actionOnGamestate =
        \actionOnGamestateExpression actionOnGamestateTags ->
            Elm.Case.custom
                actionOnGamestateExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "ActionOnGamestate"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "MovePerson"
                       actionOnGamestateTags.movePerson |> Elm.Arg.item
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
                                                                                   "evergreenV1GameObjectTypesDirection"
                                                                                   (Type.namedWith
                                                                                          [ "Evergreen"
                                                                                          , "V1"
                                                                                          , "GameObjectTypes"
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
                                                                              "evergreenV1GameObjectTypesDirtId"
                                                                              (Type.namedWith
                                                                                     [ "Evergreen"
                                                                                     , "V1"
                                                                                     , "GameObjectTypes"
                                                                                     ]
                                                                                     "DirtId"
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
                                                                     "evergreenV1GameObjectTypesDirtData"
                                                                     (Type.namedWith
                                                                            [ "Evergreen"
                                                                            , "V1"
                                                                            , "GameObjectTypes"
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
                                                                      "evergreenV1GameObjectTypesRelicData"
                                                                      (Type.namedWith
                                                                             [ "Evergreen"
                                                                             , "V1"
                                                                             , "GameObjectTypes"
                                                                             ]
                                                                             "RelicData"
                                                                             []
                                                                      )
                                                               ) |> Elm.Arg.item
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
                       "AddPerson"
                       actionOnGamestateTags.addPerson |> Elm.Arg.item
                                                                (Elm.Arg.varWith
                                                                       "evergreenV1GameObjectTypesPersonData"
                                                                       (Type.namedWith
                                                                              [ "Evergreen"
                                                                              , "V1"
                                                                              , "GameObjectTypes"
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
                                                                         "evergreenV1GameObjectTypesRelicId"
                                                                         (Type.namedWith
                                                                                [ "Evergreen"
                                                                                , "V1"
                                                                                , "GameObjectTypes"
                                                                                ]
                                                                                "RelicId"
                                                                                []
                                                                         )
                                                                  ) |> Elm.Arg.item
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
                    (Elm.Arg.customType
                       "DropRelic"
                       actionOnGamestateTags.dropRelic |> Elm.Arg.item
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
                                                                ) |> Elm.Arg.item
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
                    (Elm.Arg.customType
                       "ActivateGenerosityTrap"
                       actionOnGamestateTags.activateGenerosityTrap |> Elm.Arg.item
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
                                                                                        ) |> Elm.Arg.item
                                                                                                   (Elm.Arg.varWith
                                                                                                          "arg_2"
                                                                                                          Type.int
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
                (Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "Direction"
                     []
                )
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
                (Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "RelicRarity"
                     []
                )
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
                (Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "RelicType"
                     []
                )
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
                                                                                 [ "Evergreen"
                                                                                 , "V1"
                                                                                 , "GameObjectTypes"
                                                                                 ]
                                                                                 "PersonId"
                                                                                 []
                                                                          )
                                                                   )
                                                            )
                    )
                    Basics.identity
                ]
    , relicId =
        \relicIdExpression relicIdTags ->
            Elm.Case.custom
                relicIdExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "RelicId"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "RelicId"
                       relicIdTags.relicId |> Elm.Arg.item
                                                    (Elm.Arg.varWith
                                                           "arg_0"
                                                           Type.int
                                                    )
                    )
                    Basics.identity
                ]
    , dirtId =
        \dirtIdExpression dirtIdTags ->
            Elm.Case.custom
                dirtIdExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "DirtId"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "DirtId"
                       dirtIdTags.dirtId |> Elm.Arg.item
                                                  (Elm.Arg.varWith
                                                         "arg_0"
                                                         Type.int
                                                  )
                    )
                    Basics.identity
                ]
    , personId =
        \personIdExpression personIdTags ->
            Elm.Case.custom
                personIdExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "GameObjectTypes" ]
                     "PersonId"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "PersonId"
                       personIdTags.personId |> Elm.Arg.item
                                                      (Elm.Arg.varWith
                                                             "arg_0"
                                                             Type.int
                                                      )
                    )
                    Basics.identity
                ]
    }