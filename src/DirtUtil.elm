module DirtUtil exposing (reduceDirtAmount, setDirtAmount)

import GameObjectTypes exposing (DirtData)


setDirtAmount : Int -> DirtData -> DirtData
setDirtAmount amount dirt =
    { dirt | amount = amount }


reduceDirtAmount : Int -> DirtData -> DirtData
reduceDirtAmount cleanStrength dirt =
    { dirt | amount = dirt.amount - cleanStrength }
