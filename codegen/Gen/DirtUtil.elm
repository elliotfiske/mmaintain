module Gen.DirtUtil exposing
    ( moduleName_, pointToDirtLocation, reduceDirtAmount, setDirtAmount, call_, values_
    )

{-|
# Generated bindings for DirtUtil

@docs moduleName_, pointToDirtLocation, reduceDirtAmount, setDirtAmount, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "DirtUtil" ]


{-| pointToDirtLocation: GameObjectTypes.Point -> Types.DirtLocation -}
pointToDirtLocation : Elm.Expression -> Elm.Expression
pointToDirtLocation pointToDirtLocationArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "DirtUtil" ]
             , name = "pointToDirtLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" [] ]
                          (Type.namedWith [ "Types" ] "DirtLocation" [])
                     )
             }
        )
        [ pointToDirtLocationArg_ ]


{-| reduceDirtAmount: Int -> GameObjectTypes.DirtData -> GameObjectTypes.DirtData -}
reduceDirtAmount : Int -> Elm.Expression -> Elm.Expression
reduceDirtAmount reduceDirtAmountArg_ reduceDirtAmountArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "DirtUtil" ]
             , name = "reduceDirtAmount"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith [ "GameObjectTypes" ] "DirtData" []
                          ]
                          (Type.namedWith [ "GameObjectTypes" ] "DirtData" [])
                     )
             }
        )
        [ Elm.int reduceDirtAmountArg_, reduceDirtAmountArg_0 ]


{-| setDirtAmount: Int -> GameObjectTypes.DirtData -> GameObjectTypes.DirtData -}
setDirtAmount : Int -> Elm.Expression -> Elm.Expression
setDirtAmount setDirtAmountArg_ setDirtAmountArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "DirtUtil" ]
             , name = "setDirtAmount"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith [ "GameObjectTypes" ] "DirtData" []
                          ]
                          (Type.namedWith [ "GameObjectTypes" ] "DirtData" [])
                     )
             }
        )
        [ Elm.int setDirtAmountArg_, setDirtAmountArg_0 ]


call_ :
    { pointToDirtLocation : Elm.Expression -> Elm.Expression
    , reduceDirtAmount : Elm.Expression -> Elm.Expression -> Elm.Expression
    , setDirtAmount : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { pointToDirtLocation =
        \pointToDirtLocationArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "DirtUtil" ]
                     , name = "pointToDirtLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  ]
                                  (Type.namedWith [ "Types" ] "DirtLocation" [])
                             )
                     }
                )
                [ pointToDirtLocationArg_ ]
    , reduceDirtAmount =
        \reduceDirtAmountArg_ reduceDirtAmountArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "DirtUtil" ]
                     , name = "reduceDirtAmount"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "DirtData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "DirtData"
                                       []
                                  )
                             )
                     }
                )
                [ reduceDirtAmountArg_, reduceDirtAmountArg_0 ]
    , setDirtAmount =
        \setDirtAmountArg_ setDirtAmountArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "DirtUtil" ]
                     , name = "setDirtAmount"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "DirtData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "DirtData"
                                       []
                                  )
                             )
                     }
                )
                [ setDirtAmountArg_, setDirtAmountArg_0 ]
    }


values_ :
    { pointToDirtLocation : Elm.Expression
    , reduceDirtAmount : Elm.Expression
    , setDirtAmount : Elm.Expression
    }
values_ =
    { pointToDirtLocation =
        Elm.value
            { importFrom = [ "DirtUtil" ]
            , name = "pointToDirtLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" [] ]
                         (Type.namedWith [ "Types" ] "DirtLocation" [])
                    )
            }
    , reduceDirtAmount =
        Elm.value
            { importFrom = [ "DirtUtil" ]
            , name = "reduceDirtAmount"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "GameObjectTypes" ] "DirtData" []
                         ]
                         (Type.namedWith [ "GameObjectTypes" ] "DirtData" [])
                    )
            }
    , setDirtAmount =
        Elm.value
            { importFrom = [ "DirtUtil" ]
            , name = "setDirtAmount"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "GameObjectTypes" ] "DirtData" []
                         ]
                         (Type.namedWith [ "GameObjectTypes" ] "DirtData" [])
                    )
            }
    }