module Gen.Util exposing
    ( moduleName_, calculateCameraPosition, pixelsToTiles, addPoints, groupWhile, nthItem
    , generateGridOfPoints, andThen2, levelProgress, levelTable, levelList, levelForExp, expForLevel
    , renderOffsetMultiplier, readableStringFromFloat, mapYMax, mapXMax, yOrigin, xOrigin, annotation_
    , make_, call_, values_
    )

{-|
# Generated bindings for Util

@docs moduleName_, calculateCameraPosition, pixelsToTiles, addPoints, groupWhile, nthItem
@docs generateGridOfPoints, andThen2, levelProgress, levelTable, levelList, levelForExp
@docs expForLevel, renderOffsetMultiplier, readableStringFromFloat, mapYMax, mapXMax, yOrigin
@docs xOrigin, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Util" ]


{-| {-| Rules for camera movement:

Must not go lower than 0,0
Must not go higher than the map size - window size

Should be as close as possible to the previous camera position

Player should remain at least 3 tiles away from the edge of the screen, unless they are at the edge of the map

-}

calculateCameraPosition: 
    GameObjectTypes.Point
    -> GameObjectTypes.Point
    -> GameObjectTypes.Point
    -> GameObjectTypes.Point
-}
calculateCameraPosition :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
calculateCameraPosition calculateCameraPositionArg_ calculateCameraPositionArg_0 calculateCameraPositionArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "calculateCameraPosition"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith [ "GameObjectTypes" ] "Point" []
                          ]
                          (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                     )
             }
        )
        [ calculateCameraPositionArg_
        , calculateCameraPositionArg_0
        , calculateCameraPositionArg_1
        ]


{-| pixelsToTiles: { width : Float, height : Float } -> GameObjectTypes.Point -}
pixelsToTiles : { width : Float, height : Float } -> Elm.Expression
pixelsToTiles pixelsToTilesArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "pixelsToTiles"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "width", Type.float )
                              , ( "height", Type.float )
                              ]
                          ]
                          (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "width" (Elm.float pixelsToTilesArg_.width)
            , Tuple.pair "height" (Elm.float pixelsToTilesArg_.height)
            ]
        ]


{-| addPoints: GameObjectTypes.Point -> GameObjectTypes.Point -> GameObjectTypes.Point -}
addPoints : Elm.Expression -> Elm.Expression -> Elm.Expression
addPoints addPointsArg_ addPointsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "addPoints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith [ "GameObjectTypes" ] "Point" []
                          ]
                          (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                     )
             }
        )
        [ addPointsArg_, addPointsArg_0 ]


{-| groupWhile: (a -> a -> Bool) -> List a -> List (List a) -}
groupWhile :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> List Elm.Expression
    -> Elm.Expression
groupWhile groupWhileArg_ groupWhileArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "groupWhile"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "a" ]
                              Type.bool
                          , Type.list (Type.var "a")
                          ]
                          (Type.list (Type.list (Type.var "a")))
                     )
             }
        )
        [ Elm.functionReduced
            "groupWhileUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (groupWhileArg_ functionReducedUnpack)
            )
        , Elm.list groupWhileArg_0
        ]


{-| nthItem: Int -> List a -> Maybe a -}
nthItem : Int -> List Elm.Expression -> Elm.Expression
nthItem nthItemArg_ nthItemArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "nthItem"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int, Type.list (Type.var "a") ]
                          (Type.maybe (Type.var "a"))
                     )
             }
        )
        [ Elm.int nthItemArg_, Elm.list nthItemArg_0 ]


{-| generateGridOfPoints: Util.GenerateGridOfPointsArgs -> List GameObjectTypes.Point -}
generateGridOfPoints : Elm.Expression -> Elm.Expression
generateGridOfPoints generateGridOfPointsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "generateGridOfPoints"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Util" ]
                              "GenerateGridOfPointsArgs"
                              []
                          ]
                          (Type.list
                               (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                          )
                     )
             }
        )
        [ generateGridOfPointsArg_ ]


{-| {-| Take 2 "input results", and a function that can fail that takes 2 arguments.

If either of the "input results" failed, pass along the failure (note: if both failed, only the first failure will be returned).

Otherwise, run the function, and return that result.

-}

andThen2: 
    (a -> b -> Result.Result x c)
    -> Result.Result x a
    -> Result.Result x b
    -> Result.Result x c
-}
andThen2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
andThen2 andThen2Arg_ andThen2Arg_0 andThen2Arg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "andThen2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b" ]
                              (Type.namedWith
                                 [ "Result" ]
                                 "Result"
                                 [ Type.var "x", Type.var "c" ]
                              )
                          , Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.var "x", Type.var "a" ]
                          , Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.var "x", Type.var "b" ]
                          ]
                          (Type.namedWith
                               [ "Result" ]
                               "Result"
                               [ Type.var "x", Type.var "c" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "andThen2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (andThen2Arg_ functionReducedUnpack)
            )
        , andThen2Arg_0
        , andThen2Arg_1
        ]


{-| levelProgress: Int -> Float -}
levelProgress : Int -> Elm.Expression
levelProgress levelProgressArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "levelProgress"
             , annotation = Just (Type.function [ Type.int ] Type.float)
             }
        )
        [ Elm.int levelProgressArg_ ]


{-| levelTable: Dict.Dict Int Int -}
levelTable : Elm.Expression
levelTable =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "levelTable"
        , annotation =
            Just (Type.namedWith [ "Dict" ] "Dict" [ Type.int, Type.int ])
        }


{-| levelList: List ( Int, Int ) -}
levelList : Elm.Expression
levelList =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "levelList"
        , annotation = Just (Type.list (Type.tuple Type.int Type.int))
        }


{-| levelForExp: Int -> Int -}
levelForExp : Int -> Elm.Expression
levelForExp levelForExpArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "levelForExp"
             , annotation = Just (Type.function [ Type.int ] Type.int)
             }
        )
        [ Elm.int levelForExpArg_ ]


{-| expForLevel: Int -> Int -}
expForLevel : Int -> Elm.Expression
expForLevel expForLevelArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "expForLevel"
             , annotation = Just (Type.function [ Type.int ] Type.int)
             }
        )
        [ Elm.int expForLevelArg_ ]


{-| {-| The width in pixels of a game tile
-}

renderOffsetMultiplier: number
-}
renderOffsetMultiplier : Elm.Expression
renderOffsetMultiplier =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "renderOffsetMultiplier"
        , annotation = Just (Type.var "number")
        }


{-| readableStringFromFloat: Float -> String -}
readableStringFromFloat : Float -> Elm.Expression
readableStringFromFloat readableStringFromFloatArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Util" ]
             , name = "readableStringFromFloat"
             , annotation = Just (Type.function [ Type.float ] Type.string)
             }
        )
        [ Elm.float readableStringFromFloatArg_ ]


{-| mapYMax: number -}
mapYMax : Elm.Expression
mapYMax =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "mapYMax"
        , annotation = Just (Type.var "number")
        }


{-| mapXMax: number -}
mapXMax : Elm.Expression
mapXMax =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "mapXMax"
        , annotation = Just (Type.var "number")
        }


{-| yOrigin: number -}
yOrigin : Elm.Expression
yOrigin =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "yOrigin"
        , annotation = Just (Type.var "number")
        }


{-| xOrigin: number -}
xOrigin : Elm.Expression
xOrigin =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "xOrigin"
        , annotation = Just (Type.var "number")
        }


annotation_ : { generateGridOfPointsArgs : Type.Annotation }
annotation_ =
    { generateGridOfPointsArgs =
        Type.alias
            moduleName_
            "GenerateGridOfPointsArgs"
            []
            (Type.record
                 [ ( "minX", Type.int )
                 , ( "maxX", Type.int )
                 , ( "minY", Type.int )
                 , ( "maxY", Type.int )
                 ]
            )
    }


make_ :
    { generateGridOfPointsArgs :
        { minX : Elm.Expression
        , maxX : Elm.Expression
        , minY : Elm.Expression
        , maxY : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { generateGridOfPointsArgs =
        \generateGridOfPointsArgs_args ->
            Elm.withType
                (Type.alias
                     [ "Util" ]
                     "GenerateGridOfPointsArgs"
                     []
                     (Type.record
                          [ ( "minX", Type.int )
                          , ( "maxX", Type.int )
                          , ( "minY", Type.int )
                          , ( "maxY", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "minX" generateGridOfPointsArgs_args.minX
                     , Tuple.pair "maxX" generateGridOfPointsArgs_args.maxX
                     , Tuple.pair "minY" generateGridOfPointsArgs_args.minY
                     , Tuple.pair "maxY" generateGridOfPointsArgs_args.maxY
                     ]
                )
    }


call_ :
    { calculateCameraPosition :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , pixelsToTiles : Elm.Expression -> Elm.Expression
    , addPoints : Elm.Expression -> Elm.Expression -> Elm.Expression
    , groupWhile : Elm.Expression -> Elm.Expression -> Elm.Expression
    , nthItem : Elm.Expression -> Elm.Expression -> Elm.Expression
    , generateGridOfPoints : Elm.Expression -> Elm.Expression
    , andThen2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , levelProgress : Elm.Expression -> Elm.Expression
    , levelForExp : Elm.Expression -> Elm.Expression
    , expForLevel : Elm.Expression -> Elm.Expression
    , readableStringFromFloat : Elm.Expression -> Elm.Expression
    }
call_ =
    { calculateCameraPosition =
        \calculateCameraPositionArg_ calculateCameraPositionArg_0 calculateCameraPositionArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "calculateCameraPosition"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "Point"
                                       []
                                  )
                             )
                     }
                )
                [ calculateCameraPositionArg_
                , calculateCameraPositionArg_0
                , calculateCameraPositionArg_1
                ]
    , pixelsToTiles =
        \pixelsToTilesArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "pixelsToTiles"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "width", Type.float )
                                      , ( "height", Type.float )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "Point"
                                       []
                                  )
                             )
                     }
                )
                [ pixelsToTilesArg_ ]
    , addPoints =
        \addPointsArg_ addPointsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "addPoints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "Point"
                                       []
                                  )
                             )
                     }
                )
                [ addPointsArg_, addPointsArg_0 ]
    , groupWhile =
        \groupWhileArg_ groupWhileArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "groupWhile"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "a" ]
                                      Type.bool
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.list (Type.var "a")))
                             )
                     }
                )
                [ groupWhileArg_, groupWhileArg_0 ]
    , nthItem =
        \nthItemArg_ nthItemArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "nthItem"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int, Type.list (Type.var "a") ]
                                  (Type.maybe (Type.var "a"))
                             )
                     }
                )
                [ nthItemArg_, nthItemArg_0 ]
    , generateGridOfPoints =
        \generateGridOfPointsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "generateGridOfPoints"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Util" ]
                                      "GenerateGridOfPointsArgs"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "GameObjectTypes" ]
                                            "Point"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ generateGridOfPointsArg_ ]
    , andThen2 =
        \andThen2Arg_ andThen2Arg_0 andThen2Arg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "andThen2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "b" ]
                                      (Type.namedWith
                                         [ "Result" ]
                                         "Result"
                                         [ Type.var "x", Type.var "c" ]
                                      )
                                  , Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.var "x", Type.var "a" ]
                                  , Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.var "x", Type.var "b" ]
                                  ]
                                  (Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.var "x", Type.var "c" ]
                                  )
                             )
                     }
                )
                [ andThen2Arg_, andThen2Arg_0, andThen2Arg_1 ]
    , levelProgress =
        \levelProgressArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "levelProgress"
                     , annotation = Just (Type.function [ Type.int ] Type.float)
                     }
                )
                [ levelProgressArg_ ]
    , levelForExp =
        \levelForExpArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "levelForExp"
                     , annotation = Just (Type.function [ Type.int ] Type.int)
                     }
                )
                [ levelForExpArg_ ]
    , expForLevel =
        \expForLevelArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "expForLevel"
                     , annotation = Just (Type.function [ Type.int ] Type.int)
                     }
                )
                [ expForLevelArg_ ]
    , readableStringFromFloat =
        \readableStringFromFloatArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Util" ]
                     , name = "readableStringFromFloat"
                     , annotation =
                         Just (Type.function [ Type.float ] Type.string)
                     }
                )
                [ readableStringFromFloatArg_ ]
    }


values_ :
    { calculateCameraPosition : Elm.Expression
    , pixelsToTiles : Elm.Expression
    , addPoints : Elm.Expression
    , groupWhile : Elm.Expression
    , nthItem : Elm.Expression
    , generateGridOfPoints : Elm.Expression
    , andThen2 : Elm.Expression
    , levelProgress : Elm.Expression
    , levelTable : Elm.Expression
    , levelList : Elm.Expression
    , levelForExp : Elm.Expression
    , expForLevel : Elm.Expression
    , renderOffsetMultiplier : Elm.Expression
    , readableStringFromFloat : Elm.Expression
    , mapYMax : Elm.Expression
    , mapXMax : Elm.Expression
    , yOrigin : Elm.Expression
    , xOrigin : Elm.Expression
    }
values_ =
    { calculateCameraPosition =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "calculateCameraPosition"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith [ "GameObjectTypes" ] "Point" []
                         ]
                         (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                    )
            }
    , pixelsToTiles =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "pixelsToTiles"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "width", Type.float )
                             , ( "height", Type.float )
                             ]
                         ]
                         (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                    )
            }
    , addPoints =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "addPoints"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith [ "GameObjectTypes" ] "Point" []
                         ]
                         (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                    )
            }
    , groupWhile =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "groupWhile"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "a" ]
                             Type.bool
                         , Type.list (Type.var "a")
                         ]
                         (Type.list (Type.list (Type.var "a")))
                    )
            }
    , nthItem =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "nthItem"
            , annotation =
                Just
                    (Type.function
                         [ Type.int, Type.list (Type.var "a") ]
                         (Type.maybe (Type.var "a"))
                    )
            }
    , generateGridOfPoints =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "generateGridOfPoints"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Util" ]
                             "GenerateGridOfPointsArgs"
                             []
                         ]
                         (Type.list
                              (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                         )
                    )
            }
    , andThen2 =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "andThen2"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b" ]
                             (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "c" ]
                             )
                         , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.var "x", Type.var "a" ]
                         , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.var "x", Type.var "b" ]
                         ]
                         (Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.var "x", Type.var "c" ]
                         )
                    )
            }
    , levelProgress =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "levelProgress"
            , annotation = Just (Type.function [ Type.int ] Type.float)
            }
    , levelTable =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "levelTable"
            , annotation =
                Just (Type.namedWith [ "Dict" ] "Dict" [ Type.int, Type.int ])
            }
    , levelList =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "levelList"
            , annotation = Just (Type.list (Type.tuple Type.int Type.int))
            }
    , levelForExp =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "levelForExp"
            , annotation = Just (Type.function [ Type.int ] Type.int)
            }
    , expForLevel =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "expForLevel"
            , annotation = Just (Type.function [ Type.int ] Type.int)
            }
    , renderOffsetMultiplier =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "renderOffsetMultiplier"
            , annotation = Just (Type.var "number")
            }
    , readableStringFromFloat =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "readableStringFromFloat"
            , annotation = Just (Type.function [ Type.float ] Type.string)
            }
    , mapYMax =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "mapYMax"
            , annotation = Just (Type.var "number")
            }
    , mapXMax =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "mapXMax"
            , annotation = Just (Type.var "number")
            }
    , yOrigin =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "yOrigin"
            , annotation = Just (Type.var "number")
            }
    , xOrigin =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "xOrigin"
            , annotation = Just (Type.var "number")
            }
    }