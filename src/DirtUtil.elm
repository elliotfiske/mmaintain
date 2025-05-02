module DirtUtil exposing (pointToDirtLocation, reduceDirtAmount, setDirtAmount)

import GameObjectTypes exposing (DirtData, Point)
import Types


setDirtAmount : Int -> DirtData -> DirtData
setDirtAmount amount dirt =
    { dirt | amount = amount }


reduceDirtAmount : Int -> DirtData -> DirtData
reduceDirtAmount cleanStrength dirt =
    { dirt | amount = dirt.amount - cleanStrength }


pointToDirtLocation : Point -> Types.DirtLocation
pointToDirtLocation point =
    ( point.x, point.y )
