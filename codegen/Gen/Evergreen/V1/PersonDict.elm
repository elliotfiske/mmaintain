module Gen.Evergreen.V1.PersonDict exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Evergreen.V1.PersonDict

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Evergreen", "V1", "PersonDict" ]


annotation_ : { personDict : Type.Annotation -> Type.Annotation }
annotation_ =
    { personDict =
        \personDictArg0 ->
            Type.namedWith
                [ "Evergreen", "V1", "PersonDict" ]
                "PersonDict"
                [ personDictArg0 ]
    }


make_ : { personDict : Elm.Expression -> Elm.Expression }
make_ =
    { personDict =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "PersonDict" ]
                     , name = "PersonDict"
                     , annotation =
                         Just (Type.namedWith [] "PersonDict" [ Type.var "v" ])
                     }
                )
                [ ar0 ]
    }


caseOf_ =
    { personDict =
        \personDictExpression personDictTags ->
            Elm.Case.custom
                personDictExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "PersonDict" ]
                     "PersonDict"
                     [ Type.var "v" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "PersonDict"
                       personDictTags.personDict |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "dictDict"
                                                                 (Type.namedWith
                                                                        [ "Dict"
                                                                        ]
                                                                        "Dict"
                                                                        [ Type.int
                                                                        , Type.tuple
                                                                              (Type.namedWith
                                                                                   [ "Evergreen"
                                                                                   , "V1"
                                                                                   , "GameObjectTypes"
                                                                                   ]
                                                                                   "PersonId"
                                                                                   []
                                                                              )
                                                                              (Type.var
                                                                                   "v"
                                                                              )
                                                                        ]
                                                                 )
                                                          )
                    )
                    Basics.identity
                ]
    }