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
import Util


render : FrontendPlayingState -> PersonData -> Html FrontendMsg
render state me =
    if state.showingDebugStuff then
        renderDebugModal state

    else if SeqDict.size state.backendConfirmedGameState.dirtByLocation == 0 then
        renderVictoryModal me

    else
        case state.skillTreeModalState of
            SkillDetailOpen skill ->
                renderSkillModal me skill

            _ ->
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
        Html.div [ class "flex flex-col gap-4" ]
            [ Html.div [ class "flex flex-col gap-2" ]
                [ Html.label [ class "text-sm font-medium" ] [ text "Dirt Generation Parameters" ]
                , Html.div [ class "grid grid-cols-2 gap-2" ]
                    [ Html.div [ class "flex flex-col" ]
                        [ Html.label [ class "text-xs" ] [ text "Min X" ]
                        , Html.input
                            [ type_ "number"
                            , value (String.fromInt state.debugDirtParams.minX)
                            , class "input input-bordered input-sm"
                            , Html.Events.onInput
                                (\v ->
                                    case String.toInt v of
                                        Just x ->
                                            UpdateDebugDirtParamsMsg { minX = x, maxX = state.debugDirtParams.maxX, minY = state.debugDirtParams.minY, maxY = state.debugDirtParams.maxY }

                                        Nothing ->
                                            NoOpFrontendMsg
                                )
                            ]
                            []
                        ]
                    , Html.div [ class "flex flex-col" ]
                        [ Html.label [ class "text-xs" ] [ text "Max X" ]
                        , Html.input
                            [ type_ "number"
                            , value (String.fromInt state.debugDirtParams.maxX)
                            , class "input input-bordered input-sm"
                            , Html.Events.onInput
                                (\v ->
                                    case String.toInt v of
                                        Just x ->
                                            UpdateDebugDirtParamsMsg { minX = state.debugDirtParams.minX, maxX = x, minY = state.debugDirtParams.minY, maxY = state.debugDirtParams.maxY }

                                        Nothing ->
                                            NoOpFrontendMsg
                                )
                            ]
                            []
                        ]
                    , Html.div [ class "flex flex-col" ]
                        [ Html.label [ class "text-xs" ] [ text "Min Y" ]
                        , Html.input
                            [ type_ "number"
                            , value (String.fromInt state.debugDirtParams.minY)
                            , class "input input-bordered input-sm"
                            , Html.Events.onInput
                                (\v ->
                                    case String.toInt v of
                                        Just y ->
                                            UpdateDebugDirtParamsMsg { minX = state.debugDirtParams.minX, maxX = state.debugDirtParams.maxX, minY = y, maxY = state.debugDirtParams.maxY }

                                        Nothing ->
                                            NoOpFrontendMsg
                                )
                            ]
                            []
                        ]
                    , Html.div [ class "flex flex-col" ]
                        [ Html.label [ class "text-xs" ] [ text "Max Y" ]
                        , Html.input
                            [ type_ "number"
                            , value (String.fromInt state.debugDirtParams.maxY)
                            , class "input input-bordered input-sm"
                            , Html.Events.onInput
                                (\v ->
                                    case String.toInt v of
                                        Just y ->
                                            UpdateDebugDirtParamsMsg { minX = state.debugDirtParams.minX, maxX = state.debugDirtParams.maxX, minY = state.debugDirtParams.minY, maxY = y }

                                        Nothing ->
                                            NoOpFrontendMsg
                                )
                            ]
                            []
                        ]
                    ]
                ]
            , Html.button [ Html.Events.onClick ClickedPleaseMakeMeDirty, class "btn btn-primary", id "debug-add-dirt-button" ] [ text "Add Dirt" ]
            , Html.button [ Html.Events.onClick NukeBackend, class "btn btn-error" ] [ text "Nuke Backend" ]
            , Html.div [] (debugDictsView state)
            ]

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


renderSkillModal : PersonData -> GameObjectTypes.Skill -> Html FrontendMsg
renderSkillModal me skill =
    Html.div []
        [ UI.dialog
            { title = UI.simpleTitle (getSkillName skill)
            , body = renderSkillModalBody me skill
            , actions = renderSkillModalActions me skill
            }
        ]


renderSkillModalBody : PersonData -> GameObjectTypes.Skill -> Html FrontendMsg
renderSkillModalBody me skill =
    let
        skillPoints =
            calculateSkillPoints me

        isUnlocked =
            isSkillUnlocked me.skillTree skill

        canUnlock =
            canUnlockSkill me skill

        description =
            getSkillDescription skill
    in
    Html.div [ class "space-y-4" ]
        [ Html.div [ class "prose" ]
            [ Html.p [] [ text description ] ]
        , Html.div [ class "text-sm text-gray-600" ]
            [ Html.p [] [ text ("Skill Points Available: " ++ String.fromInt skillPoints) ]
            , if isUnlocked then
                Html.p [ class "text-green-600 font-semibold" ] [ text "✓ Skill Unlocked" ]

              else if not canUnlock then
                Html.p [ class "text-red-600" ] [ text "Cannot unlock: insufficient skill points or missing prerequisites" ]

              else
                Html.p [ class "text-blue-600" ] [ text "Ready to unlock!" ]
            ]
        ]


renderSkillModalActions : PersonData -> GameObjectTypes.Skill -> Html FrontendMsg
renderSkillModalActions me skill =
    let
        isUnlocked =
            isSkillUnlocked me.skillTree skill

        canUnlock =
            canUnlockSkill me skill
    in
    Html.div [ class "flex justify-end space-x-2" ]
        [ button [ class "btn btn-ghost", Html.Events.onClick CloseSkillTreeModal ] [ text "Back" ]
        , if isUnlocked then
            text ""

          else if canUnlock then
            button [ class "btn btn-primary", Html.Events.onClick (UnlockSkill skill) ] [ text "Unlock Skill" ]

          else
            button [ class "btn btn-disabled" ] [ text "Cannot Unlock" ]
        ]



-- Helper functions


getSkillName : Skill -> String
getSkillName skill =
    case skill of
        GameObjectTypes.Root ->
            "Root"

        GameObjectTypes.Learned ->
            "Learned"

        GameObjectTypes.SwiftCleaning ->
            "Swift Cleaning"

        GameObjectTypes.CleaningFundamentals ->
            "Cleaning Fundamentals"

        GameObjectTypes.RelicHunter ->
            "Relic Hunter"

        GameObjectTypes.PowerCleaning ->
            "Power Cleaning"


getSkillDescription : Skill -> String
getSkillDescription skill =
    case skill of
        GameObjectTypes.Root ->
            "Introduces you to the skill tree. Grants +5 cleaning power."

        GameObjectTypes.Learned ->
            "Increases the base EXP from a clean by 5xp."

        GameObjectTypes.SwiftCleaning ->
            "Increases cleaning by 1.1x."

        GameObjectTypes.CleaningFundamentals ->
            "Grants +10 cleaning power."

        GameObjectTypes.RelicHunter ->
            "Improves your chances of finding better relics when clearing dirt. Provides +10 boost to relic rarity rolls."

        GameObjectTypes.PowerCleaning ->
            "Increases cleaning by 1.2x. Stacks multiplicatively with Swift Cleaning."


calculateSkillPoints : PersonData -> Int
calculateSkillPoints person =
    let
        playerLevel =
            Util.levelForExp person.experience

        unlockedSkillsCount =
            GameObjectTypes.allSkills
                |> List.map (isSkillUnlocked person.skillTree)
                |> List.filter identity
                |> List.length

        totalSkills =
            List.length GameObjectTypes.allSkills

        unlockableSkillsRemaining =
            totalSkills - unlockedSkillsCount

        uncappedSkillPoints =
            playerLevel - unlockedSkillsCount
    in
    Basics.min uncappedSkillPoints unlockableSkillsRemaining


isSkillUnlocked : SkillTree -> GameObjectTypes.Skill -> Bool
isSkillUnlocked skillTree skill =
    case skill of
        GameObjectTypes.Root ->
            skillTree.root

        GameObjectTypes.Learned ->
            skillTree.learned

        GameObjectTypes.SwiftCleaning ->
            skillTree.swiftCleaning

        GameObjectTypes.CleaningFundamentals ->
            skillTree.cleaningFundamentals

        GameObjectTypes.RelicHunter ->
            skillTree.relicHunter

        GameObjectTypes.PowerCleaning ->
            skillTree.powerCleaning


canUnlockSkill : PersonData -> Skill -> Bool
canUnlockSkill person skill =
    let
        hasSkillPoints =
            calculateSkillPoints person > 0

        skillUnlocked =
            isSkillUnlocked person.skillTree skill

        hasPrerequisites =
            case skill of
                GameObjectTypes.Root ->
                    -- Always can unlock root
                    True

                GameObjectTypes.Learned ->
                    person.skillTree.root

                GameObjectTypes.SwiftCleaning ->
                    person.skillTree.root

                GameObjectTypes.CleaningFundamentals ->
                    person.skillTree.root

                GameObjectTypes.RelicHunter ->
                    person.skillTree.learned

                GameObjectTypes.PowerCleaning ->
                    person.skillTree.swiftCleaning
    in
    hasSkillPoints && not skillUnlocked && hasPrerequisites
