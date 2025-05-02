module RelicUtil exposing (..)

import Dict
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import Html
import Html.Attributes
import Html.Events
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
            "Generosity"

        SplashBucket ->
            "Splash Bucket"

        GuestBook _ ->
            "Guest Book"


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


relicRarityToCssClass : RelicRarity -> String
relicRarityToCssClass rarity =
    case rarity of
        Common ->
            "common"

        Uncommon ->
            "uncommon"

        Rare ->
            "rare"

        Epic ->
            "epic"

        Legendary ->
            "legendary"


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


{-| Calculates the strength multiplier for CleanFast relics based on rarity and level.
-}
cleanFastStrengthMultiplier : RelicRarity -> Int -> Float
cleanFastStrengthMultiplier rarity xp =
    let
        level =
            toFloat (relicLevelForExp rarity xp)

        baseMultiplier =
            case rarity of
                Common ->
                    1.3

                Uncommon ->
                    1.8

                Rare ->
                    2.2

                Epic ->
                    3.0

                Legendary ->
                    5.0

        -- Scale linearly such that level 5 is 3x base
        level5Multiplier =
            baseMultiplier * 3.0

        increasePerLevel =
            (level5Multiplier - baseMultiplier) / 4.0
    in
    baseMultiplier + (level - 1.0) * increasePerLevel


{-| Calculates the XP multiplier for MoreXP relics based on rarity and level.
-}
xpMultiplier : RelicRarity -> Int -> Float
xpMultiplier rarity xp =
    let
        level =
            toFloat (relicLevelForExp rarity xp)

        baseMultiplier =
            case rarity of
                Common ->
                    1.5

                Uncommon ->
                    2.0

                Rare ->
                    2.5

                Epic ->
                    4.0

                Legendary ->
                    10.0

        -- Scale linearly such that level 5 is 2x base
        level5Multiplier =
            baseMultiplier * 2.0

        increasePerLevel =
            (level5Multiplier - baseMultiplier) / 4.0
    in
    baseMultiplier + (level - 1.0) * increasePerLevel


{-| Calculates the base XP gain for DropAndDouble relics based on rarity and level.
-}
dropDoubleBaseExperience : RelicRarity -> Int -> Int
dropDoubleBaseExperience rarity xp =
    let
        level =
            toFloat (relicLevelForExp rarity xp)

        baseExperience =
            case rarity of
                Common ->
                    100.0

                Uncommon ->
                    200.0

                Rare ->
                    300.0

                Epic ->
                    400.0

                Legendary ->
                    500.0

        -- Scale linearly such that level 5 is 3x base
        level5Experience =
            baseExperience * 3.0

        increasePerLevel =
            (level5Experience - baseExperience) / 4.0
    in
    round (baseExperience + (level - 1.0) * increasePerLevel)


dropDoubleCurrentExperience : RelicRarity -> Int -> Int -> Int
dropDoubleCurrentExperience rarity xp droppedPeople =
    dropDoubleBaseExperience rarity xp * 2 ^ droppedPeople


floorPointToLocation : Point -> RelicLocation
floorPointToLocation { x, y } =
    ( 0, x, y )


getRelicAtLocation : RelicLocation -> RelicId -> GameState -> Maybe RelicData
getRelicAtLocation location relicId state =
    Dict.get location state.relicsByPosition
        |> Maybe.andThen (RelicDict.get relicId)


updateRelicAtLocation : RelicLocation -> RelicData -> GameState -> GameState
updateRelicAtLocation location relic state =
    let
        maybeRelicDict =
            Dict.get location state.relicsByPosition

        newRelicDict =
            case maybeRelicDict of
                Just relicDict ->
                    RelicDict.insert relic.id relic relicDict

                Nothing ->
                    RelicDict.insert relic.id relic RelicDict.empty
    in
    { state | relicsByPosition = Dict.insert location newRelicDict state.relicsByPosition }


relicLocationIsOnFloor : RelicLocation -> Bool
relicLocationIsOnFloor ( floor, _, _ ) =
    floor == 0


floorRelicLocationToFloorPoint : RelicLocation -> Point
floorRelicLocationToFloorPoint ( _, x, y ) =
    { x = x, y = y }


{-| Roll for the rarity of a relic.
NOTE: this is also where we check if the player gets a relic at all. `Nothing` means no relic dropped.
-}
rarityRoll : Int -> Maybe GameObjectTypes.RelicRarity
rarityRoll rawRandomValue =
    let
        randomValue =
            modBy 100 rawRandomValue
    in
    if randomValue < 2 then
        Just GameObjectTypes.Legendary

    else if randomValue < 10 then
        Just GameObjectTypes.Epic

    else if randomValue < 20 then
        Just GameObjectTypes.Rare

    else if randomValue < 50 then
        Just GameObjectTypes.Uncommon

    else if randomValue < 70 then
        Just GameObjectTypes.Common

    else
        Nothing


relicWeights : List ( Int, GameObjectTypes.RelicType )
relicWeights =
    [ ( 60, GameObjectTypes.CleanFast )
    , ( 5, GameObjectTypes.DropAndDouble [] )
    , ( 30, GameObjectTypes.MoreXP )
    , ( 5, GameObjectTypes.SplashBucket )
    ]


relicTypeRoll : Int -> GameObjectTypes.RelicType
relicTypeRoll rawRandomValue =
    let
        totalWeights =
            List.sum (List.map Tuple.first relicWeights)

        randomValue =
            modBy totalWeights rawRandomValue
    in
    List.foldl
        (\( weight, relicType ) ( acc, chosenRelicType ) ->
            if acc < randomValue then
                ( acc + weight, relicType )

            else
                ( acc, chosenRelicType )
        )
        ( 0, GameObjectTypes.CleanFast )
        relicWeights
        |> Tuple.second


{-| XP thresholds required to reach levels 2, 3, 4, and 5 respectively.
-}
relicLevelThresholds : RelicRarity -> List Int
relicLevelThresholds rarity =
    case rarity of
        Common ->
            [ 50, 100, 200, 400 ]

        Uncommon ->
            [ 100, 300, 600, 1200 ]

        Rare ->
            [ 250, 550, 1100, 2200 ]

        Epic ->
            [ 375, 775, 1550, 3100 ]

        Legendary ->
            [ 500, 1000, 2000, 4000 ]


{-| Calculate the relic's level based on its rarity and experience.
Level ranges from 1 to 5.
-}
relicLevelForExp : RelicRarity -> Int -> Int
relicLevelForExp rarity xp =
    let
        thresholds =
            relicLevelThresholds rarity

        levelsGained =
            thresholds
                |> List.filter (\threshold -> xp >= threshold)
                |> List.length
    in
    1 + levelsGained


{-| Get the XP required to reach a specific level (2-5). Returns Nothing for level 1 or levels > 5.
-}
expForRelicLevel : RelicRarity -> Int -> Maybe Int
expForRelicLevel rarity level =
    if level < 2 || level > 5 then
        Nothing

    else
        relicLevelThresholds rarity
            |> List.drop (level - 2)
            |> List.head


{-| Calculate the relic's XP progress towards the next level as a percentage (0-100).
-}
relicLevelProgress : RelicRarity -> Int -> Float
relicLevelProgress rarity xp =
    let
        currentLevel =
            relicLevelForExp rarity xp

        xpForCurrentLevel =
            if currentLevel == 1 then
                Just 0

            else
                expForRelicLevel rarity currentLevel

        xpForNextLevel =
            expForRelicLevel rarity (currentLevel + 1)
    in
    case ( xpForCurrentLevel, xpForNextLevel ) of
        ( Just currentThreshold, Just nextThreshold ) ->
            let
                xpInLevel =
                    toFloat (xp - currentThreshold)

                xpNeededForLevel =
                    toFloat (nextThreshold - currentThreshold)
            in
            if xpNeededForLevel <= 0 then
                100
                -- Avoid division by zero if thresholds are weird

            else
                min 100 (xpInLevel / xpNeededForLevel * 100)

        _ ->
            -- If current or next level XP threshold is not found (e.g., max level)
            100



-- Calculate the splash bucket cleaning strength based on rarity and experience


splashBucketStrength : RelicRarity -> Int -> Int
splashBucketStrength rarity exp =
    let
        baseStrength =
            case rarity of
                Common ->
                    5

                Uncommon ->
                    10

                Rare ->
                    20

                Epic ->
                    40

                Legendary ->
                    80

        level =
            toFloat (relicLevelForExp rarity exp)

        -- Scale linearly such that level 5 is 2x base
        level5Strength =
            toFloat baseStrength * 2.0

        increasePerLevel =
            (level5Strength - toFloat baseStrength) / 4.0
    in
    round (toFloat baseStrength + (level - 1.0) * increasePerLevel)


guestBookStrength : RelicRarity -> Int -> Int -> Int
guestBookStrength rarity exp peopleWhoHaveHeldIt =
    let
        level =
            relicLevelForExp rarity exp
    in
    level * peopleWhoHaveHeldIt


playerHolderToLocation : PersonId -> Types.RelicLocation
playerHolderToLocation (PersonId rawId) =
    ( -1, rawId, 0 )


byRelicRarity : RelicData -> Int
byRelicRarity relic =
    case relic.rarity of
        Common ->
            0

        Uncommon ->
            -1

        Rare ->
            -2

        Epic ->
            -3

        Legendary ->
            -4


relicSlotThreshholds : List Int
relicSlotThreshholds =
    [ 3, 5, 10 ]


relicSlotsForLevel : Int -> Int
relicSlotsForLevel level =
    3
        + (relicSlotThreshholds
            |> List.filter (\x -> level >= x)
            |> List.length
          )


{-| Given a level, return a list where each member is a level at which you'll unlock a new relic slot
-}
lockedRelicSlots : Int -> List Int
lockedRelicSlots level =
    relicSlotThreshholds
        |> List.filter (\x -> level < x)
