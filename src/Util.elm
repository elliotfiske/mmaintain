module Util exposing (..)

import Types


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


levelForExp : Int -> Int
levelForExp xp =
    xp // 5


{-| Take 2 "input results", and a function that can fail that takes 2 arguments.

If either of the "input results" failed, pass along the failure (note: if both failed, only the first failure will be returned).

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


type alias GenerateGridOfPointsArgs =
    { minX : Int
    , maxX : Int
    , minY : Int
    , maxY : Int
    }


generateGridOfPoints : GenerateGridOfPointsArgs -> List Types.Point
generateGridOfPoints { minX, maxX, minY, maxY } =
    List.concatMap (\x -> List.map (\y -> { x = x, y = y }) (List.range minY maxY)) (List.range minX maxX)
