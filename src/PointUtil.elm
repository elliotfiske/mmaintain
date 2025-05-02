module PointUtil exposing (DirectionDifferenceHorizontal(..), DirectionDifferenceVertical(..), directionToMoveFrom, newPoint)

import GameObjectTypes exposing (Direction(..), Point)


newPoint : Direction -> Point -> Point
newPoint direction point =
    case direction of
        Up ->
            { point | y = point.y - 1 }

        Down ->
            { point | y = point.y + 1 }

        Left ->
            { point | x = point.x - 1 }

        Right ->
            { point | x = point.x + 1 }

        UpLeft ->
            { point | x = point.x - 1, y = point.y - 1 }

        UpRight ->
            { point | x = point.x + 1, y = point.y - 1 }

        DownLeft ->
            { point | x = point.x - 1, y = point.y + 1 }

        DownRight ->
            { point | x = point.x + 1, y = point.y + 1 }


type DirectionDifferenceVertical
    = Above
    | Below
    | SameY


type DirectionDifferenceHorizontal
    = LeftOf
    | RightOf
    | SameX


directionToMoveFrom : Point -> Point -> Maybe Direction
directionToMoveFrom from to =
    let
        yDiff =
            if from.y > to.y then
                Above

            else if from.y < to.y then
                Below

            else
                SameY

        xDiff =
            if from.x > to.x then
                LeftOf

            else if from.x < to.x then
                RightOf

            else
                SameX
    in
    case ( xDiff, yDiff ) of
        ( LeftOf, SameY ) ->
            Just Left

        ( RightOf, SameY ) ->
            Just Right

        ( SameX, Above ) ->
            Just Up

        ( SameX, Below ) ->
            Just Down

        ( LeftOf, Above ) ->
            Just UpLeft

        ( RightOf, Above ) ->
            Just UpRight

        ( LeftOf, Below ) ->
            Just DownLeft

        ( RightOf, Below ) ->
            Just DownRight

        ( SameX, SameY ) ->
            Nothing
