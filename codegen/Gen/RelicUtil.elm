module Gen.RelicUtil exposing
    ( moduleName_, lockedRelicSlots, relicSlotsForLevel, relicSlotThreshholds, byRelicRarity, playerHolderToLocation
    , guestBookStrength, splashBucketStrength, relicLevelProgress, expForRelicLevel, relicLevelForExp, relicLevelThresholds, relicTypeRoll
    , relicWeights, rarityRoll, floorRelicLocationToFloorPoint, relicLocationIsOnFloor, updateRelicAtLocation, getRelicAtLocation, floorPointToLocation
    , dropDoubleCurrentExperience, dropDoubleBaseExperience, xpMultiplier, cleanFastStrengthMultiplier, dropAndDoubleActivationButton, simpleRelicBody, relicRarityName
    , relicBgColor, relicRarityToCssClass, relicTextColor, relicName, call_, values_
    )

{-|
# Generated bindings for RelicUtil

@docs moduleName_, lockedRelicSlots, relicSlotsForLevel, relicSlotThreshholds, byRelicRarity, playerHolderToLocation
@docs guestBookStrength, splashBucketStrength, relicLevelProgress, expForRelicLevel, relicLevelForExp, relicLevelThresholds
@docs relicTypeRoll, relicWeights, rarityRoll, floorRelicLocationToFloorPoint, relicLocationIsOnFloor, updateRelicAtLocation
@docs getRelicAtLocation, floorPointToLocation, dropDoubleCurrentExperience, dropDoubleBaseExperience, xpMultiplier, cleanFastStrengthMultiplier
@docs dropAndDoubleActivationButton, simpleRelicBody, relicRarityName, relicBgColor, relicRarityToCssClass, relicTextColor
@docs relicName, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "RelicUtil" ]


{-| {-| Given a level, return a list where each member is a level at which you'll unlock a new relic slot
-}

lockedRelicSlots: Int -> List Int
-}
lockedRelicSlots : Int -> Elm.Expression
lockedRelicSlots lockedRelicSlotsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "lockedRelicSlots"
             , annotation =
                 Just (Type.function [ Type.int ] (Type.list Type.int))
             }
        )
        [ Elm.int lockedRelicSlotsArg_ ]


{-| relicSlotsForLevel: Int -> Int -}
relicSlotsForLevel : Int -> Elm.Expression
relicSlotsForLevel relicSlotsForLevelArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicSlotsForLevel"
             , annotation = Just (Type.function [ Type.int ] Type.int)
             }
        )
        [ Elm.int relicSlotsForLevelArg_ ]


{-| relicSlotThreshholds: List Int -}
relicSlotThreshholds : Elm.Expression
relicSlotThreshholds =
    Elm.value
        { importFrom = [ "RelicUtil" ]
        , name = "relicSlotThreshholds"
        , annotation = Just (Type.list Type.int)
        }


{-| byRelicRarity: RelicUtil.RelicData -> Int -}
byRelicRarity : Elm.Expression -> Elm.Expression
byRelicRarity byRelicRarityArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "byRelicRarity"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicData" [] ]
                          Type.int
                     )
             }
        )
        [ byRelicRarityArg_ ]


{-| playerHolderToLocation: RelicUtil.PersonId -> Types.RelicLocation -}
playerHolderToLocation : Elm.Expression -> Elm.Expression
playerHolderToLocation playerHolderToLocationArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "playerHolderToLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "PersonId" [] ]
                          (Type.namedWith [ "Types" ] "RelicLocation" [])
                     )
             }
        )
        [ playerHolderToLocationArg_ ]


{-| guestBookStrength: RelicUtil.RelicRarity -> Int -> Int -> Int -}
guestBookStrength : Elm.Expression -> Int -> Int -> Elm.Expression
guestBookStrength guestBookStrengthArg_ guestBookStrengthArg_0 guestBookStrengthArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "guestBookStrength"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          , Type.int
                          ]
                          Type.int
                     )
             }
        )
        [ guestBookStrengthArg_
        , Elm.int guestBookStrengthArg_0
        , Elm.int guestBookStrengthArg_1
        ]


{-| splashBucketStrength: RelicUtil.RelicRarity -> Int -> Int -}
splashBucketStrength : Elm.Expression -> Int -> Elm.Expression
splashBucketStrength splashBucketStrengthArg_ splashBucketStrengthArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "splashBucketStrength"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          ]
                          Type.int
                     )
             }
        )
        [ splashBucketStrengthArg_, Elm.int splashBucketStrengthArg_0 ]


{-| {-| Calculate the relic's XP progress towards the next level as a percentage (0-100).
-}

relicLevelProgress: RelicUtil.RelicRarity -> Int -> Float
-}
relicLevelProgress : Elm.Expression -> Int -> Elm.Expression
relicLevelProgress relicLevelProgressArg_ relicLevelProgressArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicLevelProgress"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          ]
                          Type.float
                     )
             }
        )
        [ relicLevelProgressArg_, Elm.int relicLevelProgressArg_0 ]


{-| {-| Get the XP required to reach a specific level (2-5). Returns Nothing for level 1 or levels > 5.
-}

expForRelicLevel: RelicUtil.RelicRarity -> Int -> Maybe Int
-}
expForRelicLevel : Elm.Expression -> Int -> Elm.Expression
expForRelicLevel expForRelicLevelArg_ expForRelicLevelArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "expForRelicLevel"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          ]
                          (Type.maybe Type.int)
                     )
             }
        )
        [ expForRelicLevelArg_, Elm.int expForRelicLevelArg_0 ]


{-| {-| Calculate the relic's level based on its rarity and experience.
Level ranges from 1 to 5.
-}

relicLevelForExp: RelicUtil.RelicRarity -> Int -> Int
-}
relicLevelForExp : Elm.Expression -> Int -> Elm.Expression
relicLevelForExp relicLevelForExpArg_ relicLevelForExpArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicLevelForExp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          ]
                          Type.int
                     )
             }
        )
        [ relicLevelForExpArg_, Elm.int relicLevelForExpArg_0 ]


{-| {-| XP thresholds required to reach levels 2, 3, 4, and 5 respectively.
-}

relicLevelThresholds: RelicUtil.RelicRarity -> List Int
-}
relicLevelThresholds : Elm.Expression -> Elm.Expression
relicLevelThresholds relicLevelThresholdsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicLevelThresholds"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                          (Type.list Type.int)
                     )
             }
        )
        [ relicLevelThresholdsArg_ ]


{-| relicTypeRoll: Int -> GameObjectTypes.RelicType -}
relicTypeRoll : Int -> Elm.Expression
relicTypeRoll relicTypeRollArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicTypeRoll"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "GameObjectTypes" ] "RelicType" [])
                     )
             }
        )
        [ Elm.int relicTypeRollArg_ ]


{-| relicWeights: List ( Int, GameObjectTypes.RelicType ) -}
relicWeights : Elm.Expression
relicWeights =
    Elm.value
        { importFrom = [ "RelicUtil" ]
        , name = "relicWeights"
        , annotation =
            Just
                (Type.list
                     (Type.tuple
                          Type.int
                          (Type.namedWith [ "GameObjectTypes" ] "RelicType" [])
                     )
                )
        }


{-| {-| Roll for the rarity of a relic.
NOTE: this is also where we check if the player gets a relic at all. `Nothing` means no relic dropped.
-}

rarityRoll: Int -> Maybe GameObjectTypes.RelicRarity
-}
rarityRoll : Int -> Elm.Expression
rarityRoll rarityRollArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "rarityRoll"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "GameObjectTypes" ]
                                    "RelicRarity"
                                    []
                               )
                          )
                     )
             }
        )
        [ Elm.int rarityRollArg_ ]


{-| floorRelicLocationToFloorPoint: RelicUtil.RelicLocation -> RelicUtil.Point -}
floorRelicLocationToFloorPoint : Elm.Expression -> Elm.Expression
floorRelicLocationToFloorPoint floorRelicLocationToFloorPointArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "floorRelicLocationToFloorPoint"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicLocation" [] ]
                          (Type.namedWith [ "RelicUtil" ] "Point" [])
                     )
             }
        )
        [ floorRelicLocationToFloorPointArg_ ]


{-| relicLocationIsOnFloor: RelicUtil.RelicLocation -> Bool -}
relicLocationIsOnFloor : Elm.Expression -> Elm.Expression
relicLocationIsOnFloor relicLocationIsOnFloorArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicLocationIsOnFloor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicLocation" [] ]
                          Type.bool
                     )
             }
        )
        [ relicLocationIsOnFloorArg_ ]


{-| updateRelicAtLocation: 
    RelicUtil.RelicLocation
    -> RelicUtil.RelicData
    -> RelicUtil.GameState
    -> RelicUtil.GameState
-}
updateRelicAtLocation :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
updateRelicAtLocation updateRelicAtLocationArg_ updateRelicAtLocationArg_0 updateRelicAtLocationArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "updateRelicAtLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicLocation" []
                          , Type.namedWith [ "RelicUtil" ] "RelicData" []
                          , Type.namedWith [ "RelicUtil" ] "GameState" []
                          ]
                          (Type.namedWith [ "RelicUtil" ] "GameState" [])
                     )
             }
        )
        [ updateRelicAtLocationArg_
        , updateRelicAtLocationArg_0
        , updateRelicAtLocationArg_1
        ]


{-| getRelicAtLocation: 
    RelicUtil.RelicLocation
    -> RelicUtil.RelicId
    -> RelicUtil.GameState
    -> Maybe RelicUtil.RelicData
-}
getRelicAtLocation :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
getRelicAtLocation getRelicAtLocationArg_ getRelicAtLocationArg_0 getRelicAtLocationArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "getRelicAtLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicLocation" []
                          , Type.namedWith [ "RelicUtil" ] "RelicId" []
                          , Type.namedWith [ "RelicUtil" ] "GameState" []
                          ]
                          (Type.maybe
                               (Type.namedWith [ "RelicUtil" ] "RelicData" [])
                          )
                     )
             }
        )
        [ getRelicAtLocationArg_
        , getRelicAtLocationArg_0
        , getRelicAtLocationArg_1
        ]


{-| floorPointToLocation: RelicUtil.Point -> RelicUtil.RelicLocation -}
floorPointToLocation : Elm.Expression -> Elm.Expression
floorPointToLocation floorPointToLocationArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "floorPointToLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "Point" [] ]
                          (Type.namedWith [ "RelicUtil" ] "RelicLocation" [])
                     )
             }
        )
        [ floorPointToLocationArg_ ]


{-| dropDoubleCurrentExperience: RelicUtil.RelicRarity -> Int -> Int -> Int -}
dropDoubleCurrentExperience : Elm.Expression -> Int -> Int -> Elm.Expression
dropDoubleCurrentExperience dropDoubleCurrentExperienceArg_ dropDoubleCurrentExperienceArg_0 dropDoubleCurrentExperienceArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "dropDoubleCurrentExperience"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          , Type.int
                          ]
                          Type.int
                     )
             }
        )
        [ dropDoubleCurrentExperienceArg_
        , Elm.int dropDoubleCurrentExperienceArg_0
        , Elm.int dropDoubleCurrentExperienceArg_1
        ]


{-| {-| Calculates the base XP gain for DropAndDouble relics based on rarity and level.
-}

dropDoubleBaseExperience: RelicUtil.RelicRarity -> Int -> Int
-}
dropDoubleBaseExperience : Elm.Expression -> Int -> Elm.Expression
dropDoubleBaseExperience dropDoubleBaseExperienceArg_ dropDoubleBaseExperienceArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "dropDoubleBaseExperience"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          ]
                          Type.int
                     )
             }
        )
        [ dropDoubleBaseExperienceArg_, Elm.int dropDoubleBaseExperienceArg_0 ]


{-| {-| Calculates the XP multiplier for MoreXP relics based on rarity and level.
-}

xpMultiplier: RelicUtil.RelicRarity -> Int -> Float
-}
xpMultiplier : Elm.Expression -> Int -> Elm.Expression
xpMultiplier xpMultiplierArg_ xpMultiplierArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "xpMultiplier"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          ]
                          Type.float
                     )
             }
        )
        [ xpMultiplierArg_, Elm.int xpMultiplierArg_0 ]


{-| {-| Calculates the strength multiplier for CleanFast relics based on rarity and level.
-}

cleanFastStrengthMultiplier: RelicUtil.RelicRarity -> Int -> Float
-}
cleanFastStrengthMultiplier : Elm.Expression -> Int -> Elm.Expression
cleanFastStrengthMultiplier cleanFastStrengthMultiplierArg_ cleanFastStrengthMultiplierArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "cleanFastStrengthMultiplier"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                          , Type.int
                          ]
                          Type.float
                     )
             }
        )
        [ cleanFastStrengthMultiplierArg_
        , Elm.int cleanFastStrengthMultiplierArg_0
        ]


{-| dropAndDoubleActivationButton: 
    RelicUtil.PersonId
    -> List RelicUtil.PersonId
    -> RelicUtil.RelicId
    -> Html.Html RelicUtil.FrontendMsg
-}
dropAndDoubleActivationButton :
    Elm.Expression -> List Elm.Expression -> Elm.Expression -> Elm.Expression
dropAndDoubleActivationButton dropAndDoubleActivationButtonArg_ dropAndDoubleActivationButtonArg_0 dropAndDoubleActivationButtonArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "dropAndDoubleActivationButton"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "PersonId" []
                          , Type.list
                              (Type.namedWith [ "RelicUtil" ] "PersonId" [])
                          , Type.namedWith [ "RelicUtil" ] "RelicId" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "RelicUtil" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ dropAndDoubleActivationButtonArg_
        , Elm.list dropAndDoubleActivationButtonArg_0
        , dropAndDoubleActivationButtonArg_1
        ]


{-| simpleRelicBody: String -> List (Html.Html RelicUtil.FrontendMsg) -}
simpleRelicBody : String -> Elm.Expression
simpleRelicBody simpleRelicBodyArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "simpleRelicBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.list
                               (Type.namedWith
                                    [ "Html" ]
                                    "Html"
                                    [ Type.namedWith
                                        [ "RelicUtil" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ Elm.string simpleRelicBodyArg_ ]


{-| relicRarityName: RelicUtil.RelicRarity -> String -}
relicRarityName : Elm.Expression -> Elm.Expression
relicRarityName relicRarityNameArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicRarityName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                          Type.string
                     )
             }
        )
        [ relicRarityNameArg_ ]


{-| relicBgColor: RelicUtil.RelicRarity -> String -}
relicBgColor : Elm.Expression -> Elm.Expression
relicBgColor relicBgColorArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicBgColor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                          Type.string
                     )
             }
        )
        [ relicBgColorArg_ ]


{-| relicRarityToCssClass: RelicUtil.RelicRarity -> String -}
relicRarityToCssClass : Elm.Expression -> Elm.Expression
relicRarityToCssClass relicRarityToCssClassArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicRarityToCssClass"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                          Type.string
                     )
             }
        )
        [ relicRarityToCssClassArg_ ]


{-| relicTextColor: RelicUtil.RelicRarity -> String -}
relicTextColor : Elm.Expression -> Elm.Expression
relicTextColor relicTextColorArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicTextColor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                          Type.string
                     )
             }
        )
        [ relicTextColorArg_ ]


{-| relicName: RelicUtil.RelicType -> String -}
relicName : Elm.Expression -> Elm.Expression
relicName relicNameArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "RelicUtil" ]
             , name = "relicName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "RelicUtil" ] "RelicType" [] ]
                          Type.string
                     )
             }
        )
        [ relicNameArg_ ]


call_ :
    { lockedRelicSlots : Elm.Expression -> Elm.Expression
    , relicSlotsForLevel : Elm.Expression -> Elm.Expression
    , byRelicRarity : Elm.Expression -> Elm.Expression
    , playerHolderToLocation : Elm.Expression -> Elm.Expression
    , guestBookStrength :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , splashBucketStrength : Elm.Expression -> Elm.Expression -> Elm.Expression
    , relicLevelProgress : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expForRelicLevel : Elm.Expression -> Elm.Expression -> Elm.Expression
    , relicLevelForExp : Elm.Expression -> Elm.Expression -> Elm.Expression
    , relicLevelThresholds : Elm.Expression -> Elm.Expression
    , relicTypeRoll : Elm.Expression -> Elm.Expression
    , rarityRoll : Elm.Expression -> Elm.Expression
    , floorRelicLocationToFloorPoint : Elm.Expression -> Elm.Expression
    , relicLocationIsOnFloor : Elm.Expression -> Elm.Expression
    , updateRelicAtLocation :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getRelicAtLocation :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , floorPointToLocation : Elm.Expression -> Elm.Expression
    , dropDoubleCurrentExperience :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropDoubleBaseExperience :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , xpMultiplier : Elm.Expression -> Elm.Expression -> Elm.Expression
    , cleanFastStrengthMultiplier :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropAndDoubleActivationButton :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , simpleRelicBody : Elm.Expression -> Elm.Expression
    , relicRarityName : Elm.Expression -> Elm.Expression
    , relicBgColor : Elm.Expression -> Elm.Expression
    , relicRarityToCssClass : Elm.Expression -> Elm.Expression
    , relicTextColor : Elm.Expression -> Elm.Expression
    , relicName : Elm.Expression -> Elm.Expression
    }
call_ =
    { lockedRelicSlots =
        \lockedRelicSlotsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "lockedRelicSlots"
                     , annotation =
                         Just (Type.function [ Type.int ] (Type.list Type.int))
                     }
                )
                [ lockedRelicSlotsArg_ ]
    , relicSlotsForLevel =
        \relicSlotsForLevelArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicSlotsForLevel"
                     , annotation = Just (Type.function [ Type.int ] Type.int)
                     }
                )
                [ relicSlotsForLevelArg_ ]
    , byRelicRarity =
        \byRelicRarityArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "byRelicRarity"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicData"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ byRelicRarityArg_ ]
    , playerHolderToLocation =
        \playerHolderToLocationArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "playerHolderToLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "RelicUtil" ] "PersonId" []
                                  ]
                                  (Type.namedWith [ "Types" ] "RelicLocation" []
                                  )
                             )
                     }
                )
                [ playerHolderToLocationArg_ ]
    , guestBookStrength =
        \guestBookStrengthArg_ guestBookStrengthArg_0 guestBookStrengthArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "guestBookStrength"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  , Type.int
                                  ]
                                  Type.int
                             )
                     }
                )
                [ guestBookStrengthArg_
                , guestBookStrengthArg_0
                , guestBookStrengthArg_1
                ]
    , splashBucketStrength =
        \splashBucketStrengthArg_ splashBucketStrengthArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "splashBucketStrength"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  ]
                                  Type.int
                             )
                     }
                )
                [ splashBucketStrengthArg_, splashBucketStrengthArg_0 ]
    , relicLevelProgress =
        \relicLevelProgressArg_ relicLevelProgressArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicLevelProgress"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  ]
                                  Type.float
                             )
                     }
                )
                [ relicLevelProgressArg_, relicLevelProgressArg_0 ]
    , expForRelicLevel =
        \expForRelicLevelArg_ expForRelicLevelArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "expForRelicLevel"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  ]
                                  (Type.maybe Type.int)
                             )
                     }
                )
                [ expForRelicLevelArg_, expForRelicLevelArg_0 ]
    , relicLevelForExp =
        \relicLevelForExpArg_ relicLevelForExpArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicLevelForExp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  ]
                                  Type.int
                             )
                     }
                )
                [ relicLevelForExpArg_, relicLevelForExpArg_0 ]
    , relicLevelThresholds =
        \relicLevelThresholdsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicLevelThresholds"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  ]
                                  (Type.list Type.int)
                             )
                     }
                )
                [ relicLevelThresholdsArg_ ]
    , relicTypeRoll =
        \relicTypeRollArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicTypeRoll"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "RelicType"
                                       []
                                  )
                             )
                     }
                )
                [ relicTypeRollArg_ ]
    , rarityRoll =
        \rarityRollArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "rarityRoll"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "GameObjectTypes" ]
                                            "RelicRarity"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ rarityRollArg_ ]
    , floorRelicLocationToFloorPoint =
        \floorRelicLocationToFloorPointArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "floorRelicLocationToFloorPoint"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicLocation"
                                      []
                                  ]
                                  (Type.namedWith [ "RelicUtil" ] "Point" [])
                             )
                     }
                )
                [ floorRelicLocationToFloorPointArg_ ]
    , relicLocationIsOnFloor =
        \relicLocationIsOnFloorArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicLocationIsOnFloor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicLocation"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ relicLocationIsOnFloorArg_ ]
    , updateRelicAtLocation =
        \updateRelicAtLocationArg_ updateRelicAtLocationArg_0 updateRelicAtLocationArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "updateRelicAtLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicLocation"
                                      []
                                  , Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "RelicUtil" ]
                                      "GameState"
                                      []
                                  ]
                                  (Type.namedWith [ "RelicUtil" ] "GameState" []
                                  )
                             )
                     }
                )
                [ updateRelicAtLocationArg_
                , updateRelicAtLocationArg_0
                , updateRelicAtLocationArg_1
                ]
    , getRelicAtLocation =
        \getRelicAtLocationArg_ getRelicAtLocationArg_0 getRelicAtLocationArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "getRelicAtLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicLocation"
                                      []
                                  , Type.namedWith [ "RelicUtil" ] "RelicId" []
                                  , Type.namedWith
                                      [ "RelicUtil" ]
                                      "GameState"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "RelicUtil" ]
                                            "RelicData"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getRelicAtLocationArg_
                , getRelicAtLocationArg_0
                , getRelicAtLocationArg_1
                ]
    , floorPointToLocation =
        \floorPointToLocationArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "floorPointToLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "RelicUtil" ] "Point" [] ]
                                  (Type.namedWith
                                       [ "RelicUtil" ]
                                       "RelicLocation"
                                       []
                                  )
                             )
                     }
                )
                [ floorPointToLocationArg_ ]
    , dropDoubleCurrentExperience =
        \dropDoubleCurrentExperienceArg_ dropDoubleCurrentExperienceArg_0 dropDoubleCurrentExperienceArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "dropDoubleCurrentExperience"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  , Type.int
                                  ]
                                  Type.int
                             )
                     }
                )
                [ dropDoubleCurrentExperienceArg_
                , dropDoubleCurrentExperienceArg_0
                , dropDoubleCurrentExperienceArg_1
                ]
    , dropDoubleBaseExperience =
        \dropDoubleBaseExperienceArg_ dropDoubleBaseExperienceArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "dropDoubleBaseExperience"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  ]
                                  Type.int
                             )
                     }
                )
                [ dropDoubleBaseExperienceArg_, dropDoubleBaseExperienceArg_0 ]
    , xpMultiplier =
        \xpMultiplierArg_ xpMultiplierArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "xpMultiplier"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  ]
                                  Type.float
                             )
                     }
                )
                [ xpMultiplierArg_, xpMultiplierArg_0 ]
    , cleanFastStrengthMultiplier =
        \cleanFastStrengthMultiplierArg_ cleanFastStrengthMultiplierArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "cleanFastStrengthMultiplier"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  , Type.int
                                  ]
                                  Type.float
                             )
                     }
                )
                [ cleanFastStrengthMultiplierArg_
                , cleanFastStrengthMultiplierArg_0
                ]
    , dropAndDoubleActivationButton =
        \dropAndDoubleActivationButtonArg_ dropAndDoubleActivationButtonArg_0 dropAndDoubleActivationButtonArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "dropAndDoubleActivationButton"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "RelicUtil" ] "PersonId" []
                                  , Type.list
                                      (Type.namedWith
                                         [ "RelicUtil" ]
                                         "PersonId"
                                         []
                                      )
                                  , Type.namedWith [ "RelicUtil" ] "RelicId" []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "RelicUtil" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ dropAndDoubleActivationButtonArg_
                , dropAndDoubleActivationButtonArg_0
                , dropAndDoubleActivationButtonArg_1
                ]
    , simpleRelicBody =
        \simpleRelicBodyArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "simpleRelicBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Html" ]
                                            "Html"
                                            [ Type.namedWith
                                                [ "RelicUtil" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ simpleRelicBodyArg_ ]
    , relicRarityName =
        \relicRarityNameArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicRarityName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ relicRarityNameArg_ ]
    , relicBgColor =
        \relicBgColorArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicBgColor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ relicBgColorArg_ ]
    , relicRarityToCssClass =
        \relicRarityToCssClassArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicRarityToCssClass"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ relicRarityToCssClassArg_ ]
    , relicTextColor =
        \relicTextColorArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicTextColor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicRarity"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ relicTextColorArg_ ]
    , relicName =
        \relicNameArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "RelicUtil" ]
                     , name = "relicName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "RelicUtil" ]
                                      "RelicType"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ relicNameArg_ ]
    }


values_ :
    { lockedRelicSlots : Elm.Expression
    , relicSlotsForLevel : Elm.Expression
    , relicSlotThreshholds : Elm.Expression
    , byRelicRarity : Elm.Expression
    , playerHolderToLocation : Elm.Expression
    , guestBookStrength : Elm.Expression
    , splashBucketStrength : Elm.Expression
    , relicLevelProgress : Elm.Expression
    , expForRelicLevel : Elm.Expression
    , relicLevelForExp : Elm.Expression
    , relicLevelThresholds : Elm.Expression
    , relicTypeRoll : Elm.Expression
    , relicWeights : Elm.Expression
    , rarityRoll : Elm.Expression
    , floorRelicLocationToFloorPoint : Elm.Expression
    , relicLocationIsOnFloor : Elm.Expression
    , updateRelicAtLocation : Elm.Expression
    , getRelicAtLocation : Elm.Expression
    , floorPointToLocation : Elm.Expression
    , dropDoubleCurrentExperience : Elm.Expression
    , dropDoubleBaseExperience : Elm.Expression
    , xpMultiplier : Elm.Expression
    , cleanFastStrengthMultiplier : Elm.Expression
    , dropAndDoubleActivationButton : Elm.Expression
    , simpleRelicBody : Elm.Expression
    , relicRarityName : Elm.Expression
    , relicBgColor : Elm.Expression
    , relicRarityToCssClass : Elm.Expression
    , relicTextColor : Elm.Expression
    , relicName : Elm.Expression
    }
values_ =
    { lockedRelicSlots =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "lockedRelicSlots"
            , annotation =
                Just (Type.function [ Type.int ] (Type.list Type.int))
            }
    , relicSlotsForLevel =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicSlotsForLevel"
            , annotation = Just (Type.function [ Type.int ] Type.int)
            }
    , relicSlotThreshholds =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicSlotThreshholds"
            , annotation = Just (Type.list Type.int)
            }
    , byRelicRarity =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "byRelicRarity"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicData" [] ]
                         Type.int
                    )
            }
    , playerHolderToLocation =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "playerHolderToLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "PersonId" [] ]
                         (Type.namedWith [ "Types" ] "RelicLocation" [])
                    )
            }
    , guestBookStrength =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "guestBookStrength"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         , Type.int
                         ]
                         Type.int
                    )
            }
    , splashBucketStrength =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "splashBucketStrength"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         ]
                         Type.int
                    )
            }
    , relicLevelProgress =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicLevelProgress"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         ]
                         Type.float
                    )
            }
    , expForRelicLevel =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "expForRelicLevel"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         ]
                         (Type.maybe Type.int)
                    )
            }
    , relicLevelForExp =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicLevelForExp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         ]
                         Type.int
                    )
            }
    , relicLevelThresholds =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicLevelThresholds"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                         (Type.list Type.int)
                    )
            }
    , relicTypeRoll =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicTypeRoll"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "GameObjectTypes" ] "RelicType" [])
                    )
            }
    , relicWeights =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicWeights"
            , annotation =
                Just
                    (Type.list
                         (Type.tuple
                              Type.int
                              (Type.namedWith
                                   [ "GameObjectTypes" ]
                                   "RelicType"
                                   []
                              )
                         )
                    )
            }
    , rarityRoll =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "rarityRoll"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "GameObjectTypes" ]
                                   "RelicRarity"
                                   []
                              )
                         )
                    )
            }
    , floorRelicLocationToFloorPoint =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "floorRelicLocationToFloorPoint"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicLocation" [] ]
                         (Type.namedWith [ "RelicUtil" ] "Point" [])
                    )
            }
    , relicLocationIsOnFloor =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicLocationIsOnFloor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicLocation" [] ]
                         Type.bool
                    )
            }
    , updateRelicAtLocation =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "updateRelicAtLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicLocation" []
                         , Type.namedWith [ "RelicUtil" ] "RelicData" []
                         , Type.namedWith [ "RelicUtil" ] "GameState" []
                         ]
                         (Type.namedWith [ "RelicUtil" ] "GameState" [])
                    )
            }
    , getRelicAtLocation =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "getRelicAtLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicLocation" []
                         , Type.namedWith [ "RelicUtil" ] "RelicId" []
                         , Type.namedWith [ "RelicUtil" ] "GameState" []
                         ]
                         (Type.maybe
                              (Type.namedWith [ "RelicUtil" ] "RelicData" [])
                         )
                    )
            }
    , floorPointToLocation =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "floorPointToLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "Point" [] ]
                         (Type.namedWith [ "RelicUtil" ] "RelicLocation" [])
                    )
            }
    , dropDoubleCurrentExperience =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "dropDoubleCurrentExperience"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         , Type.int
                         ]
                         Type.int
                    )
            }
    , dropDoubleBaseExperience =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "dropDoubleBaseExperience"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         ]
                         Type.int
                    )
            }
    , xpMultiplier =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "xpMultiplier"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         ]
                         Type.float
                    )
            }
    , cleanFastStrengthMultiplier =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "cleanFastStrengthMultiplier"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" []
                         , Type.int
                         ]
                         Type.float
                    )
            }
    , dropAndDoubleActivationButton =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "dropAndDoubleActivationButton"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "PersonId" []
                         , Type.list
                             (Type.namedWith [ "RelicUtil" ] "PersonId" [])
                         , Type.namedWith [ "RelicUtil" ] "RelicId" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "RelicUtil" ] "FrontendMsg" []
                              ]
                         )
                    )
            }
    , simpleRelicBody =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "simpleRelicBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.list
                              (Type.namedWith
                                   [ "Html" ]
                                   "Html"
                                   [ Type.namedWith
                                       [ "RelicUtil" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , relicRarityName =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicRarityName"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                         Type.string
                    )
            }
    , relicBgColor =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicBgColor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                         Type.string
                    )
            }
    , relicRarityToCssClass =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicRarityToCssClass"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                         Type.string
                    )
            }
    , relicTextColor =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicTextColor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicRarity" [] ]
                         Type.string
                    )
            }
    , relicName =
        Elm.value
            { importFrom = [ "RelicUtil" ]
            , name = "relicName"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "RelicUtil" ] "RelicType" [] ]
                         Type.string
                    )
            }
    }