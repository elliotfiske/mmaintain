module Gen.ListBuilder exposing
    ( moduleName_, addIfMatches, addIf, addMaybe, add, concatMaybe
    , call_, values_
    )

{-|
# Generated bindings for ListBuilder

@docs moduleName_, addIfMatches, addIf, addMaybe, add, concatMaybe
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "ListBuilder" ]


{-| addIfMatches: (a -> Bool) -> a -> List a -> List a -}
addIfMatches :
    (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
addIfMatches addIfMatchesArg_ addIfMatchesArg_0 addIfMatchesArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "ListBuilder" ]
             , name = "addIfMatches"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] Type.bool
                          , Type.var "a"
                          , Type.list (Type.var "a")
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ Elm.functionReduced "addIfMatchesUnpack" addIfMatchesArg_
        , addIfMatchesArg_0
        , Elm.list addIfMatchesArg_1
        ]


{-| addIf: Bool -> a -> List a -> List a -}
addIf : Bool -> Elm.Expression -> List Elm.Expression -> Elm.Expression
addIf addIfArg_ addIfArg_0 addIfArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "ListBuilder" ]
             , name = "addIf"
             , annotation =
                 Just
                     (Type.function
                          [ Type.bool, Type.var "a", Type.list (Type.var "a") ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ Elm.bool addIfArg_, addIfArg_0, Elm.list addIfArg_1 ]


{-| addMaybe: Maybe a -> List a -> List a -}
addMaybe : Elm.Expression -> List Elm.Expression -> Elm.Expression
addMaybe addMaybeArg_ addMaybeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "ListBuilder" ]
             , name = "addMaybe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe (Type.var "a")
                          , Type.list (Type.var "a")
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ addMaybeArg_, Elm.list addMaybeArg_0 ]


{-| add: a -> List a -> List a -}
add : Elm.Expression -> List Elm.Expression -> Elm.Expression
add addArg_ addArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "ListBuilder" ]
             , name = "add"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a", Type.list (Type.var "a") ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ addArg_, Elm.list addArg_0 ]


{-| concatMaybe: Maybe (List a) -> List a -> List a -}
concatMaybe : Elm.Expression -> List Elm.Expression -> Elm.Expression
concatMaybe concatMaybeArg_ concatMaybeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "ListBuilder" ]
             , name = "concatMaybe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe (Type.list (Type.var "a"))
                          , Type.list (Type.var "a")
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ concatMaybeArg_, Elm.list concatMaybeArg_0 ]


call_ :
    { addIfMatches :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , addIf :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , addMaybe : Elm.Expression -> Elm.Expression -> Elm.Expression
    , add : Elm.Expression -> Elm.Expression -> Elm.Expression
    , concatMaybe : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { addIfMatches =
        \addIfMatchesArg_ addIfMatchesArg_0 addIfMatchesArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ListBuilder" ]
                     , name = "addIfMatches"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function [ Type.var "a" ] Type.bool
                                  , Type.var "a"
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ addIfMatchesArg_, addIfMatchesArg_0, addIfMatchesArg_1 ]
    , addIf =
        \addIfArg_ addIfArg_0 addIfArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ListBuilder" ]
                     , name = "addIf"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.bool
                                  , Type.var "a"
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ addIfArg_, addIfArg_0, addIfArg_1 ]
    , addMaybe =
        \addMaybeArg_ addMaybeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ListBuilder" ]
                     , name = "addMaybe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe (Type.var "a")
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ addMaybeArg_, addMaybeArg_0 ]
    , add =
        \addArg_ addArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ListBuilder" ]
                     , name = "add"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a", Type.list (Type.var "a") ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ addArg_, addArg_0 ]
    , concatMaybe =
        \concatMaybeArg_ concatMaybeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ListBuilder" ]
                     , name = "concatMaybe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe (Type.list (Type.var "a"))
                                  , Type.list (Type.var "a")
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ concatMaybeArg_, concatMaybeArg_0 ]
    }


values_ :
    { addIfMatches : Elm.Expression
    , addIf : Elm.Expression
    , addMaybe : Elm.Expression
    , add : Elm.Expression
    , concatMaybe : Elm.Expression
    }
values_ =
    { addIfMatches =
        Elm.value
            { importFrom = [ "ListBuilder" ]
            , name = "addIfMatches"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] Type.bool
                         , Type.var "a"
                         , Type.list (Type.var "a")
                         ]
                         (Type.list (Type.var "a"))
                    )
            }
    , addIf =
        Elm.value
            { importFrom = [ "ListBuilder" ]
            , name = "addIf"
            , annotation =
                Just
                    (Type.function
                         [ Type.bool, Type.var "a", Type.list (Type.var "a") ]
                         (Type.list (Type.var "a"))
                    )
            }
    , addMaybe =
        Elm.value
            { importFrom = [ "ListBuilder" ]
            , name = "addMaybe"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe (Type.var "a"), Type.list (Type.var "a") ]
                         (Type.list (Type.var "a"))
                    )
            }
    , add =
        Elm.value
            { importFrom = [ "ListBuilder" ]
            , name = "add"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a", Type.list (Type.var "a") ]
                         (Type.list (Type.var "a"))
                    )
            }
    , concatMaybe =
        Elm.value
            { importFrom = [ "ListBuilder" ]
            , name = "concatMaybe"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe (Type.list (Type.var "a"))
                         , Type.list (Type.var "a")
                         ]
                         (Type.list (Type.var "a"))
                    )
            }
    }