module Relic exposing (..)

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


relicName : RelicType -> String
relicName relicType =
    case relicType of
        CleanFast ->
            "Clean Fast!"

        MoreXP ->
            "More XP!"

        DropAndDouble _ ->
            "Generosity"


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


relicBody : FrontendPlayingState -> RelicData -> List (Html.Html FrontendMsg)
relicBody state relic =
    case relic.relicType of
        CleanFast ->
            simpleRelicBody ("x" ++ String.fromFloat (cleanFastStrengthMultiplier relic.rarity relic.exp) ++ " to Cleaning Strength.")

        MoreXP ->
            simpleRelicBody ("x" ++ String.fromFloat (xpMultiplier relic.rarity relic.exp) ++ " to all XP earned.")

        DropAndDouble people ->
            let
                alreadyDropped =
                    List.member state.myId people

                baseExp =
                    dropDoubleCurrentExperience relic.rarity (List.length people)

                me =
                    PersonDict.get state.myId state.gameState.personDict

                playerXpMultiplier =
                    Maybe.map (xpMultiplierForPlayer state.gameState) me
                        |> Maybe.withDefault 1
                        |> round

                finalExp =
                    baseExp * playerXpMultiplier
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
                ++ [ dropAndDoubleActivationButton state.myId people relic.id
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


cleanFastStrengthMultiplier : RelicRarity -> Int -> Float
cleanFastStrengthMultiplier rarity xp =
    case rarity of
        Common ->
            1.3

        Uncommon ->
            2

        Rare ->
            2.2

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
                        acc * xpMultiplier relic.rarity person.experience

                    _ ->
                        acc
            )
            1


{-| Some relics are interested in actions against the GameState. This function
lets relics modify the GameState in response to actions.
-}
relicMiddleware : ActionOnGamestate -> RelicData -> GameState -> GameState
relicMiddleware action relic state =
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
                    { person | experience = person.experience + dropDoubleCurrentExperience relic.rarity (List.length people) }
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
