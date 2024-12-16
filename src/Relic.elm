module Relic exposing (..)

import GameObjectTypes exposing (..)
import Html
import Html.Attributes
import Html.Events
import List.Extra
import Markdown
import PersonDict
import RelicDict
import Types exposing (..)


relicName : RelicType -> String
relicName relicType =
    case relicType of
        CleanFast ->
            "Clean Fast!"

        MoreXP ->
            "More XP!"

        DropAndDouble _ ->
            "Generosity Trap"


relicTextColor : RelicRarity -> String
relicTextColor rarity =
    case rarity of
        Common ->
            ""

        Uncommon ->
            "text-green-500"

        Rare ->
            "text-blue-500"

        Epic ->
            "text-purple-500"

        Legendary ->
            "text-red-500"


relicBgColor : RelicRarity -> String
relicBgColor rarity =
    case rarity of
        Common ->
            "bg-gray-300"

        Uncommon ->
            "bg-green-300"

        Rare ->
            "bg-blue-300"

        Epic ->
            "bg-purple-300"

        Legendary ->
            "bg-red-300"


relicRarityName : RelicRarity -> String
relicRarityName rarity =
    case rarity of
        Common ->
            "Common"

        Uncommon ->
            "Uncommon"

        Rare ->
            "Rare"

        Epic ->
            "Epic"

        Legendary ->
            "Legendary"


simpleRelicBody : String -> List (Html.Html FrontendMsg)
simpleRelicBody text =
    [ Html.text text ]


relicBody : PersonId -> RelicData -> List (Html.Html FrontendMsg)
relicBody myId relic =
    case relic.relicType of
        CleanFast ->
            simpleRelicBody ("x" ++ String.fromFloat (cleanFastStrengthMultiplier relic.rarity relic.exp) ++ " to Cleaning Strength.")

        MoreXP ->
            simpleRelicBody ("x" ++ String.fromFloat (xpMultiplier relic.rarity relic.exp) ++ " to all XP earned.")

        DropAndDouble people ->
            let
                alreadyDropped =
                    List.member myId people
            in
            Markdown.toHtml Nothing
                ("Gain **"
                    ++ String.fromInt (dropDoubleCurrentExperience relic.rarity (List.length people))
                    ++ "xp** now, or drop this and double it for somebody else."
                    ++ (if alreadyDropped then
                            " <br><br> You've already dropped this. Give it to somebody else!"

                        else
                            ""
                       )
                )
                ++ [ dropAndDoubleActivationButton myId people relic.id
                   ]


dropAndDoubleActivationButton : PersonId -> List PersonId -> RelicId -> Html.Html FrontendMsg
dropAndDoubleActivationButton myId droppers relicId =
    if List.member myId droppers then
        Html.text ""

    else
        Html.button
            [ Html.Attributes.class "btn btn-sm btn-primary"
            , Html.Events.onClick (ActivatedRelic myId relicId)
            ]
            [ Html.text "Claim XP" ]


personDictToString : List PersonId -> String
personDictToString personDict =
    personDict
        |> List.map (\personId -> "Person " ++ GameObjectTypes.personIdToString personId)
        |> String.join ", "


cleanFastStrengthMultiplier : RelicRarity -> Int -> Float
cleanFastStrengthMultiplier rarity xp =
    case rarity of
        Common ->
            1.1

        Uncommon ->
            1.2

        Rare ->
            1.5

        Epic ->
            3

        Legendary ->
            5


xpMultiplier : RelicRarity -> Int -> Float
xpMultiplier rarity xp =
    case rarity of
        Common ->
            2

        Uncommon ->
            3

        Rare ->
            5

        Epic ->
            8

        Legendary ->
            15


dropDoubleBaseExperience : RelicRarity -> Int
dropDoubleBaseExperience rarity =
    case rarity of
        Common ->
            100

        Uncommon ->
            200

        Rare ->
            300

        Epic ->
            400

        Legendary ->
            500


dropDoubleCurrentExperience : RelicRarity -> Int -> Int
dropDoubleCurrentExperience rarity droppedPeople =
    dropDoubleBaseExperience rarity * 2 ^ droppedPeople


relicHolder : RelicData -> Maybe PersonId
relicHolder relic =
    case relic.position of
        HeldBy personId ->
            Just personId

        OnFloor _ _ ->
            Nothing


relicModifiesState : ActionOnGamestate -> RelicData -> GameState -> GameState
relicModifiesState action relic state =
    case relic.relicType of
        CleanFast ->
            state

        MoreXP ->
            -- Handled in earnExperienceFromClean
            state

        DropAndDouble people ->
            case action of
                DropRelic relicId personId ->
                    handleDroppingDoubler relicId relic personId people state

                _ ->
                    state


handleDroppingDoubler : RelicId -> RelicData -> PersonId -> List PersonId -> GameState -> GameState
handleDroppingDoubler relicId relic personId people state =
    if relicId == relic.id then
        let
            newPersonList =
                List.Extra.uniqueBy personIdToString (personId :: people)

            newRelic =
                { relic | relicType = DropAndDouble newPersonList }

            newRelicDict =
                RelicDict.insert relic.id newRelic state.relicDict
        in
        { state | relicDict = newRelicDict }

    else
        state


createActionOnGameStateFromRelicActivation : PersonId -> RelicId -> GameState -> ActionOnGamestate
createActionOnGameStateFromRelicActivation activatorId relicId state =
    let
        maybeRelic =
            RelicDict.get relicId state.relicDict

        maybePerson =
            PersonDict.get activatorId state.personDict
    in
    case ( maybeRelic, maybePerson ) of
        ( Just relic, Just person ) ->
            case relic.relicType of
                DropAndDouble people ->
                    ActivateGenerosityTrap activatorId relicId (List.length people)

                _ ->
                    GameStateNoOp

        _ ->
            GameStateNoOp


maybeActivateRelic : PersonId -> RelicId -> GameState -> ( GameState, Types.BackendTrigger )
maybeActivateRelic activatorId relicId state =
    let
        maybeRelic =
            RelicDict.get relicId state.relicDict

        maybePerson =
            PersonDict.get activatorId state.personDict
    in
    case ( maybeRelic, maybePerson ) of
        ( Just relic, Just person ) ->
            activateRelicWithPersonData state person relic

        _ ->
            ( state, NoOpBackendTrigger )


activateRelicWithPersonData : GameState -> PersonData -> RelicData -> ( GameState, Types.BackendTrigger )
activateRelicWithPersonData state person relic =
    case relic.relicType of
        DropAndDouble people ->
            let
                newPersonState =
                    { person | experience = person.experience + dropDoubleCurrentExperience relic.rarity (List.length people) }
            in
            ( { state | personDict = PersonDict.insert person.id newPersonState state.personDict }, NoOpBackendTrigger )

        _ ->
            ( state, NoOpBackendTrigger )
