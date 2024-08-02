module Gen.GenericDict exposing (annotation_, call_, generateDeclarations, generateFile, init, moduleName_, useElmFastDict, values_, withTypeName)

{-| 
@docs moduleName_, init, withTypeName, useElmFastDict, generateFile, generateDeclarations, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "GenericDict" ]


{-| Starts building a custom dictionary, given the type of the key, the namespace of the resulting file, and a `toComparable` function.

The `toComparable` function will be _copied_ in each declaration, so it should be kept very simple (or extracted to a function, and then passed in like `{ toComparable = Gen.YourType.toString }`, or similar).

init: 
    { keyType : Elm.Annotation.Annotation
    , namespace : List String
    , toComparable : Elm.Expression -> Elm.Expression
    }
    -> GenericDict.Config
-}
init :
    { keyType : Elm.Expression
    , namespace : List String
    , toComparable : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
init initArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GenericDict" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "keyType"
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                              , ( "namespace", Type.list Type.string )
                              , ( "toComparable"
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              ]
                          ]
                          (Type.namedWith [ "GenericDict" ] "Config" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "keyType" initArg.keyType
            , Tuple.pair
                  "namespace"
                  (Elm.list (List.map Elm.string initArg.namespace))
            , Tuple.pair
                  "toComparable"
                  (Elm.functionReduced "initUnpack" initArg.toComparable)
            ]
        ]


{-| Use a custom type name for the dictionary type.

withTypeName: String -> GenericDict.Config -> GenericDict.Config
-}
withTypeName : String -> Elm.Expression -> Elm.Expression
withTypeName withTypeNameArg withTypeNameArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GenericDict" ]
             , name = "withTypeName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "GenericDict" ] "Config" []
                          ]
                          (Type.namedWith [ "GenericDict" ] "Config" [])
                     )
             }
        )
        [ Elm.string withTypeNameArg, withTypeNameArg0 ]


{-| Use `miniBill/elm-fast-dict` as the backing container.
This means that generated code will depend on that package but gives the advantages of that package (read `elm-fast-dict`'s README for pros and cons).

useElmFastDict: GenericDict.Config -> GenericDict.Config
-}
useElmFastDict : Elm.Expression -> Elm.Expression
useElmFastDict useElmFastDictArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GenericDict" ]
             , name = "useElmFastDict"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GenericDict" ] "Config" [] ]
                          (Type.namedWith [ "GenericDict" ] "Config" [])
                     )
             }
        )
        [ useElmFastDictArg ]


{-| Generates a file from the given configuration.

generateFile: GenericDict.Config -> Elm.File
-}
generateFile : Elm.Expression -> Elm.Expression
generateFile generateFileArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GenericDict" ]
             , name = "generateFile"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GenericDict" ] "Config" [] ]
                          (Type.namedWith [ "Elm" ] "File" [])
                     )
             }
        )
        [ generateFileArg ]


{-| Generates declarations from the given configuration.

This can be useful if you want to add your own custom declarations to the file.

generateDeclarations: GenericDict.Config -> List Elm.Declaration
-}
generateDeclarations : Elm.Expression -> Elm.Expression
generateDeclarations generateDeclarationsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "GenericDict" ]
             , name = "generateDeclarations"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GenericDict" ] "Config" [] ]
                          (Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
                          )
                     )
             }
        )
        [ generateDeclarationsArg ]


annotation_ : { config : Type.Annotation }
annotation_ =
    { config = Type.namedWith [ "GenericDict" ] "Config" [] }


call_ :
    { init : Elm.Expression -> Elm.Expression
    , withTypeName : Elm.Expression -> Elm.Expression -> Elm.Expression
    , useElmFastDict : Elm.Expression -> Elm.Expression
    , generateFile : Elm.Expression -> Elm.Expression
    , generateDeclarations : Elm.Expression -> Elm.Expression
    }
call_ =
    { init =
        \initArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GenericDict" ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "keyType"
                                        , Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                      , ( "namespace", Type.list Type.string )
                                      , ( "toComparable"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "GenericDict" ] "Config" [])
                             )
                     }
                )
                [ initArg ]
    , withTypeName =
        \withTypeNameArg withTypeNameArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GenericDict" ]
                     , name = "withTypeName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith [ "GenericDict" ] "Config" []
                                  ]
                                  (Type.namedWith [ "GenericDict" ] "Config" [])
                             )
                     }
                )
                [ withTypeNameArg, withTypeNameArg0 ]
    , useElmFastDict =
        \useElmFastDictArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GenericDict" ]
                     , name = "useElmFastDict"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "GenericDict" ] "Config" []
                                  ]
                                  (Type.namedWith [ "GenericDict" ] "Config" [])
                             )
                     }
                )
                [ useElmFastDictArg ]
    , generateFile =
        \generateFileArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GenericDict" ]
                     , name = "generateFile"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "GenericDict" ] "Config" []
                                  ]
                                  (Type.namedWith [ "Elm" ] "File" [])
                             )
                     }
                )
                [ generateFileArg ]
    , generateDeclarations =
        \generateDeclarationsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GenericDict" ]
                     , name = "generateDeclarations"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "GenericDict" ] "Config" []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ generateDeclarationsArg ]
    }


values_ :
    { init : Elm.Expression
    , withTypeName : Elm.Expression
    , useElmFastDict : Elm.Expression
    , generateFile : Elm.Expression
    , generateDeclarations : Elm.Expression
    }
values_ =
    { init =
        Elm.value
            { importFrom = [ "GenericDict" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "keyType"
                               , Type.namedWith
                                   [ "Elm", "Annotation" ]
                                   "Annotation"
                                   []
                               )
                             , ( "namespace", Type.list Type.string )
                             , ( "toComparable"
                               , Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             ]
                         ]
                         (Type.namedWith [ "GenericDict" ] "Config" [])
                    )
            }
    , withTypeName =
        Elm.value
            { importFrom = [ "GenericDict" ]
            , name = "withTypeName"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "GenericDict" ] "Config" []
                         ]
                         (Type.namedWith [ "GenericDict" ] "Config" [])
                    )
            }
    , useElmFastDict =
        Elm.value
            { importFrom = [ "GenericDict" ]
            , name = "useElmFastDict"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GenericDict" ] "Config" [] ]
                         (Type.namedWith [ "GenericDict" ] "Config" [])
                    )
            }
    , generateFile =
        Elm.value
            { importFrom = [ "GenericDict" ]
            , name = "generateFile"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GenericDict" ] "Config" [] ]
                         (Type.namedWith [ "Elm" ] "File" [])
                    )
            }
    , generateDeclarations =
        Elm.value
            { importFrom = [ "GenericDict" ]
            , name = "generateDeclarations"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GenericDict" ] "Config" [] ]
                         (Type.list (Type.namedWith [ "Elm" ] "Declaration" []))
                    )
            }
    }