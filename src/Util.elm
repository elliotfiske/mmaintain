module Util exposing (..)


xOrigin : number
xOrigin =
    0


yOrigin : number
yOrigin =
    0


xMax : number
xMax =
    10


yMax : number
yMax =
    1


{-| Take 2 "input results" and a function that can fail, that takes 2 arguments.

If either of the "input results" failed, pass along the failure.

Otherwise, run the function, and return that result.

-}
andThen2 : (a -> b -> Result x c) -> Result x a -> Result x b -> Result x c
andThen2 callback resultA resultB =
    case ( resultA, resultB ) of
        ( Ok valueA, Ok valueB ) ->
            callback valueA valueB

        ( Err err, _ ) ->
            Err err

        ( Ok _, Err err ) ->
            Err err
