module Gen.Util exposing (moduleName_, values_, xMax, xOrigin, yMax, yOrigin)

{-| 
@docs moduleName_, yMax, xMax, yOrigin, xOrigin, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Util" ]


{-| yMax: number -}
yMax : Elm.Expression
yMax =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "yMax"
        , annotation = Just (Type.var "number")
        }


{-| xMax: number -}
xMax : Elm.Expression
xMax =
    Elm.value
        { importFrom = [ "Util" ]
        , name = "xMax"
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


values_ :
    { yMax : Elm.Expression
    , xMax : Elm.Expression
    , yOrigin : Elm.Expression
    , xOrigin : Elm.Expression
    }
values_ =
    { yMax =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "yMax"
            , annotation = Just (Type.var "number")
            }
    , xMax =
        Elm.value
            { importFrom = [ "Util" ]
            , name = "xMax"
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