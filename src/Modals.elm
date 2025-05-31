module Modals exposing (render)

import BaseUI as UI
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Markdown
import SeqDict
import Types exposing (..)


render : FrontendPlayingState -> PersonData -> Html FrontendMsg
render state me =
    if state.showingDebugStuff then
        renderDebugModal state

    else if SeqDict.size state.backendConfirmedGameState.dirtByLocation == 0 then
        renderVictoryModal me

    else
        text ""


renderDebugModal : FrontendPlayingState -> Html FrontendMsg
renderDebugModal state =
    Html.div []
        [ UI.dialog
            { title = UI.simpleTitle "Debug Stuff! :)"
            , body = debugStuff state
            , actions = renderDebugModalActions
            }
        ]


renderDebugModalActions : Html FrontendMsg
renderDebugModalActions =
    button
        [ class "btn btn-primary"
        , Html.Events.onClick ToggleDebugStuff
        ]
        [ text "Close" ]


renderVictoryModal : PersonData -> Html FrontendMsg
renderVictoryModal me =
    UI.dialog
        { title = renderVictoryTitle
        , body = renderVictoryBody me
        , actions = renderVictoryActions
        }


renderVictoryTitle : Html FrontendMsg
renderVictoryTitle =
    h3
        [ class "text-lg font-bold" ]
        [ text "THE PARK IS CLEAN!!!!" ]


renderVictoryBody : PersonData -> Html FrontendMsg
renderVictoryBody me =
    Html.div []
        [ img [ src "yeah.gif", class "w-full" ] []
        , p
            [ class "py-4" ]
            [ text (makeVictoryMessage me) ]
        ]


makeVictoryMessage : PersonData -> String
makeVictoryMessage me =
    "Congratulations, the park is clean! You did this many clean actions: "
        ++ String.fromInt me.stats.cleanCount
        ++ " and you finished off this many pollution patches: "
        ++ String.fromInt me.stats.clearCount


renderVictoryActions : Html FrontendMsg
renderVictoryActions =
    button
        [ class "btn btn-primary"
        , id "add-dirt-button"
        , Html.Events.onClick ClickedPleaseMakeMeDirty
        ]
        [ text "I'M NOT DONE, ADD MORE DIRT!" ]


debugStuff : FrontendPlayingState -> Html FrontendMsg
debugStuff state =
    if state.showingDebugStuff then
        Html.div [ class "flex flex-col" ]
            (Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary" ] [ text "Add Dirt" ]
                :: debugDictsView state
            )

    else
        Html.text ""


debugDictsView : FrontendPlayingState -> List (Html FrontendMsg)
debugDictsView { backendConfirmedGameState, myId } =
    Markdown.toHtml
        Nothing
        ("PersonDict: "
            ++ String.fromInt (SeqDict.size backendConfirmedGameState.personDict)
            ++ "<br>Relics By Position Dict: "
            ++ String.fromInt (SeqDict.size backendConfirmedGameState.relicsByLocation)
            ++ "<br>DirtDict: "
            ++ String.fromInt (SeqDict.size backendConfirmedGameState.dirtByLocation)
            ++ "<br>MyId: "
            ++ personIdToString myId
        )
