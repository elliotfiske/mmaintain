module Main exposing (preview, someUI, title)

import Html exposing (text)


someUI titleText =
    let
        myTitle =
            title titleText

        subtitle =
            text "This is a subtitle"
    in
    row
        |> spacing 10
        |> children [ myTitle, subtitle, grid ]
        |> constrainingChildren
            [ constant 300 (widthOf myTitle)
            , constant 300 (widthOf subtitle)
            , offset { constant = 100, smaller = widthOf grid, bigger = widthOf myTitle }
            , ratio 3 1 (widthOf myTitle) (widthOf subtitle)
            ]
        |> constrainingSelf (\me -> [ ratio 1 (widthOf me) (heightOf me) ])
        |> padding 10


ratio : Int -> Int -> Anchor -> Anchor -> Constraint
ratio constant anchor1 anchor2 =
    foo


title titleText =
    text titleText


preview =
    someUI "Hello there!"
