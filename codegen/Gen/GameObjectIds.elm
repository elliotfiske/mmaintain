module Gen.GameObjectIds exposing
    ( moduleName_, relicIdToString, relicIdToInt, dirtIdToInt, personIdToString, personIdToInt
    , annotation_, make_, caseOf_, call_, values_
    )

{-|


# Generated bindings for GameObjectIds

@docs moduleName_, relicIdToString, relicIdToInt, dirtIdToInt, personIdToString, personIdToInt
@docs annotation_, make_, caseOf_, call_, values_

-}

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "GameObjectIds" ]


{-| relicIdToString: GameObjectIds.RelicId -> String
-}
relicIdToString : Elm.Expression -> Elm.Expression
relicIdToString relicIdToStringArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "relicIdToString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "RelicId" [] ]
                        Type.string
                    )
            }
        )
        [ relicIdToStringArg_ ]


{-| relicIdToInt: GameObjectIds.RelicId -> Int
-}
relicIdToInt : Elm.Expression -> Elm.Expression
relicIdToInt relicIdToIntArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "relicIdToInt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "RelicId" [] ]
                        Type.int
                    )
            }
        )
        [ relicIdToIntArg_ ]


{-| dirtIdToInt: GameObjectIds.DirtId -> Int
-}
dirtIdToInt : Elm.Expression -> Elm.Expression
dirtIdToInt dirtIdToIntArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "dirtIdToInt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "DirtId" [] ]
                        Type.int
                    )
            }
        )
        [ dirtIdToIntArg_ ]


{-| personIdToString: GameObjectIds.PersonId -> String
-}
personIdToString : Elm.Expression -> Elm.Expression
personIdToString personIdToStringArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "personIdToString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "PersonId" [] ]
                        Type.string
                    )
            }
        )
        [ personIdToStringArg_ ]


{-| personIdToInt: GameObjectIds.PersonId -> Int
-}
personIdToInt : Elm.Expression -> Elm.Expression
personIdToInt personIdToIntArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "personIdToInt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "PersonId" [] ]
                        Type.int
                    )
            }
        )
        [ personIdToIntArg_ ]


annotation_ :
    { relicId : Type.Annotation
    , dirtId : Type.Annotation
    , personId : Type.Annotation
    }
annotation_ =
    { relicId = Type.namedWith [ "GameObjectIds" ] "RelicId" []
    , dirtId = Type.namedWith [ "GameObjectIds" ] "DirtId" []
    , personId = Type.namedWith [ "GameObjectIds" ] "PersonId" []
    }


make_ :
    { relicId : Elm.Expression -> Elm.Expression
    , dirtId : Elm.Expression -> Elm.Expression
    , personId : Elm.Expression -> Elm.Expression
    }
make_ =
    { relicId =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "RelicId"
                    , annotation = Just (Type.namedWith [] "RelicId" [])
                    }
                )
                [ ar0 ]
    , dirtId =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "DirtId"
                    , annotation = Just (Type.namedWith [] "DirtId" [])
                    }
                )
                [ ar0 ]
    , personId =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "PersonId"
                    , annotation = Just (Type.namedWith [] "PersonId" [])
                    }
                )
                [ ar0 ]
    }


caseOf_ :
    { relicId :
        Elm.Expression
        -> { relicId : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    , dirtId :
        Elm.Expression
        -> { dirtId : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    , personId :
        Elm.Expression
        -> { personId : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { relicId =
        \relicIdExpression relicIdTags ->
            Elm.Case.custom
                relicIdExpression
                (Type.namedWith [ "GameObjectIds" ] "RelicId" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                        "RelicId"
                        relicIdTags.relicId
                        |> Elm.Arg.item
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
                (Type.namedWith [ "GameObjectIds" ] "DirtId" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                        "DirtId"
                        dirtIdTags.dirtId
                        |> Elm.Arg.item
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
                (Type.namedWith [ "GameObjectIds" ] "PersonId" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                        "PersonId"
                        personIdTags.personId
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "arg_0"
                                Type.int
                            )
                    )
                    Basics.identity
                ]
    }


call_ :
    { relicIdToString : Elm.Expression -> Elm.Expression
    , relicIdToInt : Elm.Expression -> Elm.Expression
    , dirtIdToInt : Elm.Expression -> Elm.Expression
    , personIdToString : Elm.Expression -> Elm.Expression
    , personIdToInt : Elm.Expression -> Elm.Expression
    }
call_ =
    { relicIdToString =
        \relicIdToStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "relicIdToString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "GameObjectIds" ]
                                    "RelicId"
                                    []
                                ]
                                Type.string
                            )
                    }
                )
                [ relicIdToStringArg_ ]
    , relicIdToInt =
        \relicIdToIntArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "relicIdToInt"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "GameObjectIds" ]
                                    "RelicId"
                                    []
                                ]
                                Type.int
                            )
                    }
                )
                [ relicIdToIntArg_ ]
    , dirtIdToInt =
        \dirtIdToIntArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "dirtIdToInt"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "GameObjectIds" ]
                                    "DirtId"
                                    []
                                ]
                                Type.int
                            )
                    }
                )
                [ dirtIdToIntArg_ ]
    , personIdToString =
        \personIdToStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "personIdToString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "GameObjectIds" ]
                                    "PersonId"
                                    []
                                ]
                                Type.string
                            )
                    }
                )
                [ personIdToStringArg_ ]
    , personIdToInt =
        \personIdToIntArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "GameObjectIds" ]
                    , name = "personIdToInt"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "GameObjectIds" ]
                                    "PersonId"
                                    []
                                ]
                                Type.int
                            )
                    }
                )
                [ personIdToIntArg_ ]
    }


values_ :
    { relicIdToString : Elm.Expression
    , relicIdToInt : Elm.Expression
    , dirtIdToInt : Elm.Expression
    , personIdToString : Elm.Expression
    , personIdToInt : Elm.Expression
    }
values_ =
    { relicIdToString =
        Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "relicIdToString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "RelicId" [] ]
                        Type.string
                    )
            }
    , relicIdToInt =
        Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "relicIdToInt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "RelicId" [] ]
                        Type.int
                    )
            }
    , dirtIdToInt =
        Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "dirtIdToInt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "DirtId" [] ]
                        Type.int
                    )
            }
    , personIdToString =
        Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "personIdToString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "PersonId" [] ]
                        Type.string
                    )
            }
    , personIdToInt =
        Elm.value
            { importFrom = [ "GameObjectIds" ]
            , name = "personIdToInt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "GameObjectIds" ] "PersonId" [] ]
                        Type.int
                    )
            }
    }
