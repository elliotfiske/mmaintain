module Relic exposing (..)

import BackendTriggerUtil
import Dict
import GameObjectTypes exposing (..)
import Html
import Html.Attributes
import Html.Events
import List.Extra
import Markdown
import PersonDict
import RelicDict
import Types exposing (..)
import Util


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


isRelicHeldByPerson : GameState -> RelicId -> PersonId -> Bool
isRelicHeldByPerson state relicId personId =
    RelicDict.member relicId (getRelicsHeldByPlayer personId state)


relicBody : FrontendPlayingState -> RelicData -> PersonData -> List (Html.Html FrontendMsg)
relicBody state relic me =
    let
        heldByMe =
            isRelicHeldByPerson state.gameState relic.id state.myId
    in
    case relic.relicType of
        CleanFast ->
            simpleRelicBody ("x" ++ Util.readableStringFromFloat (cleanFastStrengthMultiplier relic.rarity relic.exp) ++ " to Cleaning Strength.")

        MoreXP ->
            simpleRelicBody ("x" ++ Util.readableStringFromFloat (xpMultiplier relic.rarity relic.exp) ++ " to all XP earned.")

        DropAndDouble people ->
            dropAndDoubleRelicBody state relic me people heldByMe

        SplashBucket ->
            simpleRelicBody ("Also clean the dirt on adjacent squares at " ++ String.fromInt (splashBucketStrength relic.rarity relic.exp) ++ " strength.")


dropAndDoubleRelicBody : FrontendPlayingState -> RelicData -> PersonData -> List PersonId -> Bool -> List (Html.Html FrontendMsg)
dropAndDoubleRelicBody state relic me people heldByMe =
    let
        alreadyDropped =
            List.member state.myId people

        baseExp =
            dropDoubleCurrentExperience relic.rarity relic.exp (List.length people)

        playerXpMultiplier =
            xpMultiplierForPlayer state.gameState me

        finalExp =
            toFloat baseExp
                * playerXpMultiplier
                |> round
    in
    Markdown.toHtml Nothing
        ("Gain **"
            ++ String.fromInt finalExp
            ++ "xp** now, or drop this and double it for somebody else."
            ++ (if alreadyDropped then
                    " <br><br> You've already dropped this. Give it to somebody else!"

                else
                    ""
               )
        )
        ++ (if heldByMe then
                [ dropAndDoubleActivationButton state.myId people relic.id
                ]

            else
                []
           )


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


xpMultiplierForPlayer : GameState -> PersonData -> Float
xpMultiplierForPlayer state person =
    let
        heldRelics =
            Dict.get (playerHolderToLocation person.id) state.relicsByPosition
                |> Maybe.withDefault RelicDict.empty
                |> RelicDict.values
    in
    heldRelics
        |> List.foldl
            (\relic acc ->
                case relic.relicType of
                    MoreXP ->
                        acc * xpMultiplier relic.rarity relic.exp

                    _ ->
                        acc
            )
            1


{-| Some relics are interested in actions against the GameState. This function
lets relics modify the GameState in response to actions.
-}
relicMiddleware : ActionOnGamestate -> RelicData -> GameState -> ( GameState, BackendTrigger )
relicMiddleware action relic state =
    case relic.relicType of
        CleanFast ->
            BackendTriggerUtil.withNoOp state

        MoreXP ->
            -- Handled in earnExperienceFromClean
            BackendTriggerUtil.withNoOp state

        DropAndDouble people ->
            case action of
                DropRelic relicId personId ->
                    handleDroppingDoubler relicId relic personId people state
                        |> BackendTriggerUtil.withNoOp

                _ ->
                    BackendTriggerUtil.withNoOp state

        SplashBucket ->
            case action of
                Clean personId location ->
                    handleSplashBucket location relic personId state

                _ ->
                    BackendTriggerUtil.withNoOp state


handleSplashBucket : Point -> RelicData -> PersonId -> GameState -> ( GameState, BackendTrigger )
handleSplashBucket location relic personId state =
    let
        adjacentPoints =
            [ { x = location.x + 1, y = location.y }
            , { x = location.x - 1, y = location.y }
            , { x = location.x, y = location.y + 1 }
            , { x = location.x, y = location.y - 1 }
            ]

        splashStrength =
            splashBucketStrength relic.rarity relic.exp
    in
    List.foldl
        (applyClean personId splashStrength)
        ( state, NoOpBackendTrigger )
        adjacentPoints


applyClean : PersonId -> Int -> Point -> ( GameState, BackendTrigger ) -> ( GameState, BackendTrigger )
applyClean personId splashStrength point ( accState, accTrigger ) =
    let
        ( newState, backendTrigger ) =
            CleanOperations.doClean personId point splashStrength accState
    in
    ( newState, BatchTrigger [ accTrigger, backendTrigger ] )


handleDroppingDoubler : RelicId -> RelicData -> PersonId -> List PersonId -> GameState -> GameState
handleDroppingDoubler relicId relic personId people state =
    if relicId == relic.id then
        let
            newPersonList =
                List.Extra.uniqueBy personIdToString (personId :: people)

            newRelic =
                { relic | relicType = DropAndDouble newPersonList }
        in
        updateRelicAtLocation (playerHolderToLocation personId) newRelic state

    else
        state


playerHolderToLocation : PersonId -> RelicLocation
playerHolderToLocation (PersonId rawId) =
    ( -1, rawId, 0 )


floorPointToLocation : Point -> RelicLocation
floorPointToLocation { x, y } =
    ( 0, x, y )


getRelicsAtFloorPoint : Point -> GameState -> RealRelicDict
getRelicsAtFloorPoint point state =
    Dict.get (floorPointToLocation point) state.relicsByPosition
        |> Maybe.withDefault RelicDict.empty


getRelicsHeldByPlayer : PersonId -> GameState -> RealRelicDict
getRelicsHeldByPlayer personId state =
    Dict.get (playerHolderToLocation personId) state.relicsByPosition
        |> Maybe.withDefault RelicDict.empty


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


createActionOnGameStateFromRelicActivation : PersonId -> RelicId -> GameState -> ActionOnGamestate
createActionOnGameStateFromRelicActivation activatorId relicId state =
    let
        maybeRelic =
            getRelicAtLocation (playerHolderToLocation activatorId) relicId state

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
            getRelicAtLocation (playerHolderToLocation activatorId) relicId state

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
                    { person | experience = person.experience + dropDoubleCurrentExperience relic.rarity relic.exp (List.length people) }
            in
            ( { state | personDict = PersonDict.insert person.id newPersonState state.personDict }, NoOpBackendTrigger )

        _ ->
            ( state, NoOpBackendTrigger )


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
