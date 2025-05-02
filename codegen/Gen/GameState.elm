module Gen.GameState exposing
    ( moduleName_, empty, updateGameStateDirtDict, updateGameStateRelicDict, updateGameStatePersonDict, call_
    , values_
    )

{-|
# Generated bindings for GameState

@docs moduleName_, empty, updateGameStateDirtDict, updateGameStateRelicDict, updateGameStatePersonDict, call_
@docs values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "GameState" ]


{-| empty: Types.GameState -}
empty : Elm.Expression
empty =
    Elm.value
        { importFrom = [ "GameState" ]
        , name = "empty"
        , annotation = Just (Type.namedWith [ "Types" ] "GameState" [])
        }


{-| updateGameStateDirtDict: 
    Dict.Dict Types.DirtLocation GameObjectTypes.DirtData
    -> Types.GameState
    -> Types.GameState
-}
updateGameStateDirtDict : Elm.Expression -> Elm.Expression -> Elm.Expression
updateGameStateDirtDict updateGameStateDirtDictArg_ updateGameStateDirtDictArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameState" ]
             , name = "updateGameStateDirtDict"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.namedWith [ "Types" ] "DirtLocation" []
                              , Type.namedWith
                                    [ "GameObjectTypes" ]
                                    "DirtData"
                                    []
                              ]
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ updateGameStateDirtDictArg_, updateGameStateDirtDictArg_0 ]


{-| updateGameStateRelicDict: 
    Dict.Dict Types.RelicLocation Types.RealRelicDict
    -> Types.GameState
    -> Types.GameState
-}
updateGameStateRelicDict : Elm.Expression -> Elm.Expression -> Elm.Expression
updateGameStateRelicDict updateGameStateRelicDictArg_ updateGameStateRelicDictArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameState" ]
             , name = "updateGameStateRelicDict"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.namedWith [ "Types" ] "RelicLocation" []
                              , Type.namedWith [ "Types" ] "RealRelicDict" []
                              ]
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ updateGameStateRelicDictArg_, updateGameStateRelicDictArg_0 ]


{-| updateGameStatePersonDict: 
    PersonDict.PersonDict GameObjectTypes.PersonData
    -> Types.GameState
    -> Types.GameState
-}
updateGameStatePersonDict : Elm.Expression -> Elm.Expression -> Elm.Expression
updateGameStatePersonDict updateGameStatePersonDictArg_ updateGameStatePersonDictArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameState" ]
             , name = "updateGameStatePersonDict"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith
                                    [ "GameObjectTypes" ]
                                    "PersonData"
                                    []
                              ]
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ updateGameStatePersonDictArg_, updateGameStatePersonDictArg_0 ]


call_ :
    { updateGameStateDirtDict :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateGameStateRelicDict :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateGameStatePersonDict :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { updateGameStateDirtDict =
        \updateGameStateDirtDictArg_ updateGameStateDirtDictArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameState" ]
                     , name = "updateGameStateDirtDict"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.namedWith
                                            [ "Types" ]
                                            "DirtLocation"
                                            []
                                      , Type.namedWith
                                            [ "GameObjectTypes" ]
                                            "DirtData"
                                            []
                                      ]
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ updateGameStateDirtDictArg_, updateGameStateDirtDictArg_0 ]
    , updateGameStateRelicDict =
        \updateGameStateRelicDictArg_ updateGameStateRelicDictArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameState" ]
                     , name = "updateGameStateRelicDict"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.namedWith
                                            [ "Types" ]
                                            "RelicLocation"
                                            []
                                      , Type.namedWith
                                            [ "Types" ]
                                            "RealRelicDict"
                                            []
                                      ]
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ updateGameStateRelicDictArg_, updateGameStateRelicDictArg_0 ]
    , updateGameStatePersonDict =
        \updateGameStatePersonDictArg_ updateGameStatePersonDictArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameState" ]
                     , name = "updateGameStatePersonDict"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "PersonDict" ]
                                      "PersonDict"
                                      [ Type.namedWith
                                            [ "GameObjectTypes" ]
                                            "PersonData"
                                            []
                                      ]
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ updateGameStatePersonDictArg_
                , updateGameStatePersonDictArg_0
                ]
    }


values_ :
    { empty : Elm.Expression
    , updateGameStateDirtDict : Elm.Expression
    , updateGameStateRelicDict : Elm.Expression
    , updateGameStatePersonDict : Elm.Expression
    }
values_ =
    { empty =
        Elm.value
            { importFrom = [ "GameState" ]
            , name = "empty"
            , annotation = Just (Type.namedWith [ "Types" ] "GameState" [])
            }
    , updateGameStateDirtDict =
        Elm.value
            { importFrom = [ "GameState" ]
            , name = "updateGameStateDirtDict"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.namedWith [ "Types" ] "DirtLocation" []
                             , Type.namedWith
                                   [ "GameObjectTypes" ]
                                   "DirtData"
                                   []
                             ]
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , updateGameStateRelicDict =
        Elm.value
            { importFrom = [ "GameState" ]
            , name = "updateGameStateRelicDict"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.namedWith [ "Types" ] "RelicLocation" []
                             , Type.namedWith [ "Types" ] "RealRelicDict" []
                             ]
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , updateGameStatePersonDict =
        Elm.value
            { importFrom = [ "GameState" ]
            , name = "updateGameStatePersonDict"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "PersonDict" ]
                             "PersonDict"
                             [ Type.namedWith
                                   [ "GameObjectTypes" ]
                                   "PersonData"
                                   []
                             ]
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    }