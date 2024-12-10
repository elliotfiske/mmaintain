module Relic exposing (..)

import GameObjectTypes exposing (..)


relicName : RelicType -> String
relicName relicType =
    case relicType of
        CleanFast ->
            "Clean Fast!"

        MoreXP ->
            "More XP!"


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


relicDescription : RelicData -> String
relicDescription relic =
    case relic.relicType of
        CleanFast ->
            "x" ++ String.fromFloat (cleanFastStrengthMultiplier relic.rarity relic.exp) ++ " to Cleaning Strength."

        MoreXP ->
            "x" ++ String.fromFloat (xpMultiplier relic.rarity relic.exp) ++ " to all XP earned from cleaning."


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


relicHolder : RelicData -> Maybe PersonId
relicHolder relic =
    case relic.position of
        HeldBy personId ->
            Just personId

        OnFloor _ _ ->
            Nothing


relicModifiesAction : RelicData -> ActionOnGamestate -> ActionOnGamestate
relicModifiesAction relic action =
    case relic.relicType of
        CleanFast ->
            case action of
                Clean personId dirtId strength ->
                    if Just personId == relicHolder relic then
                        Clean personId dirtId (round (toFloat strength * cleanFastStrengthMultiplier relic.rarity relic.exp))

                    else
                        action

                _ ->
                    action

        MoreXP ->
            -- Handled in earnExperienceFromClean
            action
