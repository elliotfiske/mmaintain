module Gen.PointUtil exposing
    ( moduleName_, directionToMoveFrom, newPoint, annotation_, make_, caseOf_
    , call_, values_
    )

{-|
# Generated bindings for PointUtil

@docs moduleName_, directionToMoveFrom, newPoint, annotation_, make_, caseOf_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "PointUtil" ]


{-| directionToMoveFrom: 
    GameObjectTypes.Point
    -> GameObjectTypes.Point
    -> Maybe GameObjectTypes.Direction
-}
directionToMoveFrom : Elm.Expression -> Elm.Expression -> Elm.Expression
directionToMoveFrom directionToMoveFromArg_ directionToMoveFromArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PointUtil" ]
             , name = "directionToMoveFrom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith [ "GameObjectTypes" ] "Point" []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "GameObjectTypes" ]
                                    "Direction"
                                    []
                               )
                          )
                     )
             }
        )
        [ directionToMoveFromArg_, directionToMoveFromArg_0 ]


{-| newPoint: GameObjectTypes.Direction -> GameObjectTypes.Point -> GameObjectTypes.Point -}
newPoint : Elm.Expression -> Elm.Expression -> Elm.Expression
newPoint newPointArg_ newPointArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PointUtil" ]
             , name = "newPoint"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Direction" []
                          , Type.namedWith [ "GameObjectTypes" ] "Point" []
                          ]
                          (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                     )
             }
        )
        [ newPointArg_, newPointArg_0 ]


annotation_ :
    { directionDifferenceHorizontal : Type.Annotation
    , directionDifferenceVertical : Type.Annotation
    }
annotation_ =
    { directionDifferenceHorizontal =
        Type.namedWith [ "PointUtil" ] "DirectionDifferenceHorizontal" []
    , directionDifferenceVertical =
        Type.namedWith [ "PointUtil" ] "DirectionDifferenceVertical" []
    }


make_ :
    { leftOf : Elm.Expression
    , rightOf : Elm.Expression
    , sameX : Elm.Expression
    , above : Elm.Expression
    , below : Elm.Expression
    , sameY : Elm.Expression
    }
make_ =
    { leftOf =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "LeftOf"
            , annotation =
                Just (Type.namedWith [] "DirectionDifferenceHorizontal" [])
            }
    , rightOf =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "RightOf"
            , annotation =
                Just (Type.namedWith [] "DirectionDifferenceHorizontal" [])
            }
    , sameX =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "SameX"
            , annotation =
                Just (Type.namedWith [] "DirectionDifferenceHorizontal" [])
            }
    , above =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "Above"
            , annotation =
                Just (Type.namedWith [] "DirectionDifferenceVertical" [])
            }
    , below =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "Below"
            , annotation =
                Just (Type.namedWith [] "DirectionDifferenceVertical" [])
            }
    , sameY =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "SameY"
            , annotation =
                Just (Type.namedWith [] "DirectionDifferenceVertical" [])
            }
    }


caseOf_ :
    { directionDifferenceHorizontal :
        Elm.Expression
        -> { leftOf : Elm.Expression
        , rightOf : Elm.Expression
        , sameX : Elm.Expression
        }
        -> Elm.Expression
    , directionDifferenceVertical :
        Elm.Expression
        -> { above : Elm.Expression
        , below : Elm.Expression
        , sameY : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { directionDifferenceHorizontal =
        \directionDifferenceHorizontalExpression directionDifferenceHorizontalTags ->
            Elm.Case.custom
                directionDifferenceHorizontalExpression
                (Type.namedWith
                     [ "PointUtil" ]
                     "DirectionDifferenceHorizontal"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "LeftOf"
                       directionDifferenceHorizontalTags.leftOf
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "RightOf"
                       directionDifferenceHorizontalTags.rightOf
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "SameX"
                       directionDifferenceHorizontalTags.sameX
                    )
                    Basics.identity
                ]
    , directionDifferenceVertical =
        \directionDifferenceVerticalExpression directionDifferenceVerticalTags ->
            Elm.Case.custom
                directionDifferenceVerticalExpression
                (Type.namedWith [ "PointUtil" ] "DirectionDifferenceVertical" []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "Above"
                       directionDifferenceVerticalTags.above
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Below"
                       directionDifferenceVerticalTags.below
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "SameY"
                       directionDifferenceVerticalTags.sameY
                    )
                    Basics.identity
                ]
    }


call_ :
    { directionToMoveFrom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , newPoint : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { directionToMoveFrom =
        \directionToMoveFromArg_ directionToMoveFromArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PointUtil" ]
                     , name = "directionToMoveFrom"
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
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "GameObjectTypes" ]
                                            "Direction"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ directionToMoveFromArg_, directionToMoveFromArg_0 ]
    , newPoint =
        \newPointArg_ newPointArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PointUtil" ]
                     , name = "newPoint"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Direction"
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
                [ newPointArg_, newPointArg_0 ]
    }


values_ : { directionToMoveFrom : Elm.Expression, newPoint : Elm.Expression }
values_ =
    { directionToMoveFrom =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "directionToMoveFrom"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith [ "GameObjectTypes" ] "Point" []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "GameObjectTypes" ]
                                   "Direction"
                                   []
                              )
                         )
                    )
            }
    , newPoint =
        Elm.value
            { importFrom = [ "PointUtil" ]
            , name = "newPoint"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Direction" []
                         , Type.namedWith [ "GameObjectTypes" ] "Point" []
                         ]
                         (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                    )
            }
    }