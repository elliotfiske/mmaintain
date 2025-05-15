module Util exposing (..)

import Dict
import GameObjectTypes
import List.Extra


xOrigin : number
xOrigin =
    0


yOrigin : number
yOrigin =
    0


mapXMax : number
mapXMax =
    50


mapYMax : number
mapYMax =
    50


readableStringFromFloat : Float -> String
readableStringFromFloat floatValue =
    let
        truncated =
            Basics.round (floatValue * 10) |> toFloat

        result =
            truncated / 10.0
    in
    String.fromFloat result


{-| The width in pixels of a game tile
-}
renderOffsetMultiplier : number
renderOffsetMultiplier =
    50


expForLevel : Int -> Int
expForLevel level =
    case Dict.get level levelTable of
        Nothing ->
            4000

        Just exp ->
            exp


levelForExp : Int -> Int
levelForExp xp =
    List.foldl
        (\( level, exp ) acc ->
            if xp >= exp then
                level

            else
                acc
        )
        0
        levelList


levelList : List ( Int, Int )
levelList =
    [ ( 0, 0 )
    , ( 1, 20 )
    , ( 2, 50 )
    , ( 3, 100 )
    , ( 4, 180 )
    , ( 5, 300 )
    , ( 6, 450 )
    , ( 7, 650 )
    , ( 8, 900 )
    , ( 9, 1200 )
    , ( 10, 1550 )
    , ( 11, 2000 )
    , ( 12, 2500 )
    , ( 13, 3000 )
    , ( 14, 3500 )
    , ( 15, 4000 )
    , ( 16, 4500 )
    , ( 17, 5000 )
    , ( 18, 5500 )
    , ( 19, 6000 )
    , ( 20, 6500 )
    ]


levelTable : Dict.Dict Int Int
levelTable =
    Dict.fromList levelList


levelProgress : Int -> Float
levelProgress xp =
    let
        lowerBound =
            expForLevel (levelForExp xp)

        upperBound =
            expForLevel (1 + levelForExp xp)
    in
    toFloat (xp - lowerBound) / toFloat (upperBound - lowerBound) * 100


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


generateGridOfPoints : GenerateGridOfPointsArgs -> List GameObjectTypes.Point
generateGridOfPoints { minX, maxX, minY, maxY } =
    List.concatMap (\x -> List.map (\y -> { x = x, y = y }) (List.range minY maxY)) (List.range minX maxX)


nthItem : Int -> List a -> Maybe a
nthItem n list =
    List.drop n list
        |> List.head


groupWhile : (a -> a -> Bool) -> List a -> List (List a)
groupWhile predicate list =
    List.Extra.groupWhile predicate list
        |> List.map (\( a, rest ) -> a :: rest)


addPoints : GameObjectTypes.Point -> GameObjectTypes.Point -> GameObjectTypes.Point
addPoints point1 point2 =
    { x = point1.x + point2.x, y = point1.y + point2.y }


pixelsToTiles : { width : Float, height : Float } -> GameObjectTypes.Point
pixelsToTiles { width, height } =
    { x = truncate (width / renderOffsetMultiplier)
    , y = truncate (height / renderOffsetMultiplier)
    }


{-| Return the highest and lowest elements of a List
-}
listOutliers : (a -> comparable) -> List a -> Maybe ( a, a )
listOutliers sortBy list =
    case list of
        [] ->
            Nothing

        x :: xs ->
            Just (List.foldl (listOutliersHelper sortBy) ( x, x ) xs)


listOutliersHelper : (a -> comparable) -> a -> ( a, a ) -> ( a, a )
listOutliersHelper sortBy current ( smallest, biggest ) =
    let
        currentComparable =
            sortBy current
    in
    if currentComparable < sortBy smallest then
        ( current, biggest )

    else if currentComparable > sortBy biggest then
        ( smallest, current )

    else
        ( smallest, biggest )


{-| Rules for camera movement:

Must not go lower than 0,0
Must not go higher than the map size - window size

Should be as close as possible to the previous camera position

Player should remain at least 3 tiles away from the edge of the screen, unless they are at the edge of the map

-}
calculateCameraPosition : GameObjectTypes.Point -> GameObjectTypes.Point -> GameObjectTypes.Point -> GameObjectTypes.Point
calculateCameraPosition windowSize prevCamera playerPosition =
    let
        xMin =
            0

        yMin =
            0

        xCamera =
            prevCamera.x

        yCamera =
            prevCamera.y

        cameraBuffer =
            3

        xNewCamera =
            if playerPosition.x - xCamera < cameraBuffer then
                Basics.max xMin (playerPosition.x - cameraBuffer)

            else if playerPosition.x - xCamera > windowSize.x - cameraBuffer then
                Basics.min (mapXMax - windowSize.x) (playerPosition.x - (windowSize.x - cameraBuffer))

            else
                xCamera

        yNewCamera =
            if playerPosition.y - yCamera < cameraBuffer then
                Basics.max yMin (playerPosition.y - cameraBuffer)

            else if playerPosition.y - yCamera > windowSize.y - cameraBuffer then
                Basics.min (mapYMax - windowSize.y) (playerPosition.y - (windowSize.y - cameraBuffer))

            else
                yCamera
    in
    { x = xNewCamera, y = yNewCamera }
