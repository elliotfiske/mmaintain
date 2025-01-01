module BaseUI exposing (card, dialog, simpleTitle)

import Html exposing (Html, div, h1, node, text)
import Html.Attributes exposing (attribute, class)


card : String -> List (Html msg) -> List (Html msg) -> Html msg
card extraClasses title content =
    Html.div [ class ("card card-compact bg-base-300 shadow-xl" ++ extraClasses) ]
        [ Html.div
            [ class "card-body" ]
            (Html.h2 [ class "card-title" ] title
                :: content
            )
        ]


type alias DialogArgs msg =
    { title : Html msg
    , body : Html msg
    , actions : Html msg
    }


dialog : DialogArgs msg -> Html msg
dialog content =
    let
        actionContent =
            div
                [ class "modal-action" ]
                [ content.actions ]
    in
    node "modal-dialog"
        [ class "modal", attribute "open" "true" ]
        [ div
            [ class "modal-box prose" ]
            [ content.title, content.body, actionContent ]
        ]


simpleTitle : String -> Html msg
simpleTitle title =
    h1 [] [ text title ]
