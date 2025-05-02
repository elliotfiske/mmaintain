module Gen.Evergreen.V1.RelicDict exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Evergreen.V1.RelicDict

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Evergreen", "V1", "RelicDict" ]


annotation_ : { relicDict : Type.Annotation -> Type.Annotation }
annotation_ =
    { relicDict =
        \relicDictArg0 ->
            Type.namedWith
                [ "Evergreen", "V1", "RelicDict" ]
                "RelicDict"
                [ relicDictArg0 ]
    }


make_ : { relicDict : Elm.Expression -> Elm.Expression }
make_ =
    { relicDict =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "RelicDict" ]
                     , name = "RelicDict"
                     , annotation =
                         Just (Type.namedWith [] "RelicDict" [ Type.var "v" ])
                     }
                )
                [ ar0 ]
    }


caseOf_ =
    { relicDict =
        \relicDictExpression relicDictTags ->
            Elm.Case.custom
                relicDictExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "RelicDict" ]
                     "RelicDict"
                     [ Type.var "v" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "RelicDict"
                       relicDictTags.relicDict |> Elm.Arg.item
                                                        (Elm.Arg.varWith
                                                               "dictDict"
                                                               (Type.namedWith
                                                                      [ "Dict" ]
                                                                      "Dict"
                                                                      [ Type.int
                                                                      , Type.tuple
                                                                            (Type.namedWith
                                                                                 [ "Evergreen"
                                                                                 , "V1"
                                                                                 , "GameObjectTypes"
                                                                                 ]
                                                                                 "RelicId"
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