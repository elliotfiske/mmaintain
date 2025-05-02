module Gen.Evergreen.V1.DirtDict exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Evergreen.V1.DirtDict

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Evergreen", "V1", "DirtDict" ]


annotation_ : { dirtDict : Type.Annotation -> Type.Annotation }
annotation_ =
    { dirtDict =
        \dirtDictArg0 ->
            Type.namedWith
                [ "Evergreen", "V1", "DirtDict" ]
                "DirtDict"
                [ dirtDictArg0 ]
    }


make_ : { dirtDict : Elm.Expression -> Elm.Expression }
make_ =
    { dirtDict =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Evergreen", "V1", "DirtDict" ]
                     , name = "DirtDict"
                     , annotation =
                         Just (Type.namedWith [] "DirtDict" [ Type.var "v" ])
                     }
                )
                [ ar0 ]
    }


caseOf_ =
    { dirtDict =
        \dirtDictExpression dirtDictTags ->
            Elm.Case.custom
                dirtDictExpression
                (Type.namedWith
                     [ "Evergreen", "V1", "DirtDict" ]
                     "DirtDict"
                     [ Type.var "v" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "DirtDict"
                       dirtDictTags.dirtDict |> Elm.Arg.item
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
                                                                               "DirtId"
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