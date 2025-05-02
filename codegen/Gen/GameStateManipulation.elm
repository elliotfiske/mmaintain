module Gen.GameStateManipulation exposing
    ( moduleName_, cleanStrengthForPlayer, addCleanStats, incrementCleanCount, updatePersonDictWithExperience, activateRelicWithPersonData
    , maybeActivateRelic, createActionOnGameStateFromRelicActivation, dropAndDoubleRelicBody, relicBody, isRelicHeldByPerson, getRelicsHeldByPlayer, getRelicsAtFloorPoint
    , xpMultiplierForPlayer, handleDroppingDoubler, applyClean, handleSplashBucket, incrementClearCount, destroyDirt, makeDirtSmaller
    , cleanDirt, doClean, activateGenerosityTrap, executeActionOnGameState, combineBatchActionResult, handleBatchAction, internalExecuteActionOnGameState
    , handleActivateGenerosityTrap, playerEarnsExperience, updateRelicsByPositionWithExperience, relicMiddleware, applyRelicMiddleware, updateWithRelics, relicsAtLocation
    , getRarestRelicAtLocation, addOrModifyDirt, updateDirtAtLocation, getDirtAtLocation, changeDirtAmount, moveRelicFromPlayerToFloor, dropRelic
    , moveRelicFromFloorToPlayer, pickUpRelic, call_, values_
    )

{-|
# Generated bindings for GameStateManipulation

@docs moduleName_, cleanStrengthForPlayer, addCleanStats, incrementCleanCount, updatePersonDictWithExperience, activateRelicWithPersonData
@docs maybeActivateRelic, createActionOnGameStateFromRelicActivation, dropAndDoubleRelicBody, relicBody, isRelicHeldByPerson, getRelicsHeldByPlayer
@docs getRelicsAtFloorPoint, xpMultiplierForPlayer, handleDroppingDoubler, applyClean, handleSplashBucket, incrementClearCount
@docs destroyDirt, makeDirtSmaller, cleanDirt, doClean, activateGenerosityTrap, executeActionOnGameState
@docs combineBatchActionResult, handleBatchAction, internalExecuteActionOnGameState, handleActivateGenerosityTrap, playerEarnsExperience, updateRelicsByPositionWithExperience
@docs relicMiddleware, applyRelicMiddleware, updateWithRelics, relicsAtLocation, getRarestRelicAtLocation, addOrModifyDirt
@docs updateDirtAtLocation, getDirtAtLocation, changeDirtAmount, moveRelicFromPlayerToFloor, dropRelic, moveRelicFromFloorToPlayer
@docs pickUpRelic, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "GameStateManipulation" ]


{-| cleanStrengthForPlayer: Types.GameState -> GameStateManipulation.PersonData -> Int -}
cleanStrengthForPlayer : Elm.Expression -> Elm.Expression -> Elm.Expression
cleanStrengthForPlayer cleanStrengthForPlayerArg_ cleanStrengthForPlayerArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "cleanStrengthForPlayer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "GameState" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          ]
                          Type.int
                     )
             }
        )
        [ cleanStrengthForPlayerArg_, cleanStrengthForPlayerArg_0 ]


{-| addCleanStats: GameStateManipulation.PersonId -> Types.GameState -> Types.GameState -}
addCleanStats : Elm.Expression -> Elm.Expression -> Elm.Expression
addCleanStats addCleanStatsArg_ addCleanStatsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "addCleanStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ addCleanStatsArg_, addCleanStatsArg_0 ]


{-| incrementCleanCount: 
    GameStateManipulation.PersonId
    -> PersonDict.PersonDict GameStateManipulation.PersonData
    -> PersonDict.PersonDict GameStateManipulation.PersonData
-}
incrementCleanCount : Elm.Expression -> Elm.Expression -> Elm.Expression
incrementCleanCount incrementCleanCountArg_ incrementCleanCountArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "incrementCleanCount"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith
                                    [ "GameStateManipulation" ]
                                    "PersonData"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "PersonDict" ]
                               "PersonDict"
                               [ Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "PersonData"
                                   []
                               ]
                          )
                     )
             }
        )
        [ incrementCleanCountArg_, incrementCleanCountArg_0 ]


{-| updatePersonDictWithExperience: 
    GameStateManipulation.PersonId
    -> Int
    -> PersonDict.PersonDict GameStateManipulation.PersonData
    -> PersonDict.PersonDict GameStateManipulation.PersonData
-}
updatePersonDictWithExperience :
    Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
updatePersonDictWithExperience updatePersonDictWithExperienceArg_ updatePersonDictWithExperienceArg_0 updatePersonDictWithExperienceArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "updatePersonDictWithExperience"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.int
                          , Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith
                                    [ "GameStateManipulation" ]
                                    "PersonData"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "PersonDict" ]
                               "PersonDict"
                               [ Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "PersonData"
                                   []
                               ]
                          )
                     )
             }
        )
        [ updatePersonDictWithExperienceArg_
        , Elm.int updatePersonDictWithExperienceArg_0
        , updatePersonDictWithExperienceArg_1
        ]


{-| activateRelicWithPersonData: 
    Types.GameState
    -> GameStateManipulation.PersonData
    -> GameStateManipulation.RelicData
    -> ( Types.GameState, Types.BackendTrigger )
-}
activateRelicWithPersonData :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
activateRelicWithPersonData activateRelicWithPersonDataArg_ activateRelicWithPersonDataArg_0 activateRelicWithPersonDataArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "activateRelicWithPersonData"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "GameState" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ activateRelicWithPersonDataArg_
        , activateRelicWithPersonDataArg_0
        , activateRelicWithPersonDataArg_1
        ]


{-| maybeActivateRelic: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.RelicId
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
maybeActivateRelic :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
maybeActivateRelic maybeActivateRelicArg_ maybeActivateRelicArg_0 maybeActivateRelicArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "maybeActivateRelic"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicId"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ maybeActivateRelicArg_
        , maybeActivateRelicArg_0
        , maybeActivateRelicArg_1
        ]


{-| createActionOnGameStateFromRelicActivation: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.RelicId
    -> Types.GameState
    -> GameStateManipulation.ActionOnGamestate
-}
createActionOnGameStateFromRelicActivation :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
createActionOnGameStateFromRelicActivation createActionOnGameStateFromRelicActivationArg_ createActionOnGameStateFromRelicActivationArg_0 createActionOnGameStateFromRelicActivationArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "createActionOnGameStateFromRelicActivation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicId"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith
                               [ "GameStateManipulation" ]
                               "ActionOnGamestate"
                               []
                          )
                     )
             }
        )
        [ createActionOnGameStateFromRelicActivationArg_
        , createActionOnGameStateFromRelicActivationArg_0
        , createActionOnGameStateFromRelicActivationArg_1
        ]


{-| dropAndDoubleRelicBody: 
    Types.FrontendPlayingState
    -> GameStateManipulation.RelicData
    -> GameStateManipulation.PersonData
    -> List GameStateManipulation.PersonId
    -> Bool
    -> List (Html.Html Types.FrontendMsg)
-}
dropAndDoubleRelicBody :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> List Elm.Expression
    -> Bool
    -> Elm.Expression
dropAndDoubleRelicBody dropAndDoubleRelicBodyArg_ dropAndDoubleRelicBodyArg_0 dropAndDoubleRelicBodyArg_1 dropAndDoubleRelicBodyArg_2 dropAndDoubleRelicBodyArg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "dropAndDoubleRelicBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "FrontendPlayingState" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          , Type.list
                              (Type.namedWith
                                 [ "GameStateManipulation" ]
                                 "PersonId"
                                 []
                              )
                          , Type.bool
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Html" ]
                                    "Html"
                                    [ Type.namedWith
                                        [ "Types" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ dropAndDoubleRelicBodyArg_
        , dropAndDoubleRelicBodyArg_0
        , dropAndDoubleRelicBodyArg_1
        , Elm.list dropAndDoubleRelicBodyArg_2
        , Elm.bool dropAndDoubleRelicBodyArg_3
        ]


{-| relicBody: 
    Types.FrontendPlayingState
    -> GameStateManipulation.RelicData
    -> GameStateManipulation.PersonData
    -> List (Html.Html Types.FrontendMsg)
-}
relicBody : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
relicBody relicBodyArg_ relicBodyArg_0 relicBodyArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "relicBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "FrontendPlayingState" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Html" ]
                                    "Html"
                                    [ Type.namedWith
                                        [ "Types" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ relicBodyArg_, relicBodyArg_0, relicBodyArg_1 ]


{-| isRelicHeldByPerson: 
    Types.GameState
    -> GameStateManipulation.RelicId
    -> GameStateManipulation.PersonId
    -> Bool
-}
isRelicHeldByPerson :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
isRelicHeldByPerson isRelicHeldByPersonArg_ isRelicHeldByPersonArg_0 isRelicHeldByPersonArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "isRelicHeldByPerson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "GameState" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          ]
                          Type.bool
                     )
             }
        )
        [ isRelicHeldByPersonArg_
        , isRelicHeldByPersonArg_0
        , isRelicHeldByPersonArg_1
        ]


{-| getRelicsHeldByPlayer: GameStateManipulation.PersonId -> Types.GameState -> Types.RealRelicDict -}
getRelicsHeldByPlayer : Elm.Expression -> Elm.Expression -> Elm.Expression
getRelicsHeldByPlayer getRelicsHeldByPlayerArg_ getRelicsHeldByPlayerArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "getRelicsHeldByPlayer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "RealRelicDict" [])
                     )
             }
        )
        [ getRelicsHeldByPlayerArg_, getRelicsHeldByPlayerArg_0 ]


{-| getRelicsAtFloorPoint: GameStateManipulation.Point -> Types.GameState -> Types.RealRelicDict -}
getRelicsAtFloorPoint : Elm.Expression -> Elm.Expression -> Elm.Expression
getRelicsAtFloorPoint getRelicsAtFloorPointArg_ getRelicsAtFloorPointArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "getRelicsAtFloorPoint"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "Point"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "RealRelicDict" [])
                     )
             }
        )
        [ getRelicsAtFloorPointArg_, getRelicsAtFloorPointArg_0 ]


{-| xpMultiplierForPlayer: Types.GameState -> GameStateManipulation.PersonData -> Float -}
xpMultiplierForPlayer : Elm.Expression -> Elm.Expression -> Elm.Expression
xpMultiplierForPlayer xpMultiplierForPlayerArg_ xpMultiplierForPlayerArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "xpMultiplierForPlayer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "GameState" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          ]
                          Type.float
                     )
             }
        )
        [ xpMultiplierForPlayerArg_, xpMultiplierForPlayerArg_0 ]


{-| handleDroppingDoubler: 
    GameStateManipulation.RelicId
    -> GameStateManipulation.RelicData
    -> GameStateManipulation.PersonId
    -> List GameStateManipulation.PersonId
    -> Types.GameState
    -> Types.GameState
-}
handleDroppingDoubler :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
handleDroppingDoubler handleDroppingDoublerArg_ handleDroppingDoublerArg_0 handleDroppingDoublerArg_1 handleDroppingDoublerArg_2 handleDroppingDoublerArg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "handleDroppingDoubler"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.list
                              (Type.namedWith
                                 [ "GameStateManipulation" ]
                                 "PersonId"
                                 []
                              )
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ handleDroppingDoublerArg_
        , handleDroppingDoublerArg_0
        , handleDroppingDoublerArg_1
        , Elm.list handleDroppingDoublerArg_2
        , handleDroppingDoublerArg_3
        ]


{-| applyClean: 
    GameStateManipulation.PersonId
    -> Int
    -> GameStateManipulation.Point
    -> ( Types.GameState, Types.BackendTrigger )
    -> ( Types.GameState, Types.BackendTrigger )
-}
applyClean :
    Elm.Expression -> Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
applyClean applyCleanArg_ applyCleanArg_0 applyCleanArg_1 applyCleanArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "applyClean"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.int
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "Point"
                              []
                          , Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ applyCleanArg_
        , Elm.int applyCleanArg_0
        , applyCleanArg_1
        , applyCleanArg_2
        ]


{-| handleSplashBucket: 
    GameStateManipulation.Point
    -> GameStateManipulation.RelicData
    -> GameStateManipulation.PersonId
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
handleSplashBucket :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
handleSplashBucket handleSplashBucketArg_ handleSplashBucketArg_0 handleSplashBucketArg_1 handleSplashBucketArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "handleSplashBucket"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "Point"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ handleSplashBucketArg_
        , handleSplashBucketArg_0
        , handleSplashBucketArg_1
        , handleSplashBucketArg_2
        ]


{-| incrementClearCount: 
    GameStateManipulation.PersonId
    -> PersonDict.PersonDict GameStateManipulation.PersonData
    -> PersonDict.PersonDict GameStateManipulation.PersonData
-}
incrementClearCount : Elm.Expression -> Elm.Expression -> Elm.Expression
incrementClearCount incrementClearCountArg_ incrementClearCountArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "incrementClearCount"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith
                                    [ "GameStateManipulation" ]
                                    "PersonData"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "PersonDict" ]
                               "PersonDict"
                               [ Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "PersonData"
                                   []
                               ]
                          )
                     )
             }
        )
        [ incrementClearCountArg_, incrementClearCountArg_0 ]


{-| destroyDirt: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.DirtData
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
destroyDirt :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
destroyDirt destroyDirtArg_ destroyDirtArg_0 destroyDirtArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "destroyDirt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "DirtData"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ destroyDirtArg_, destroyDirtArg_0, destroyDirtArg_1 ]


{-| makeDirtSmaller: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.DirtData
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
makeDirtSmaller :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
makeDirtSmaller makeDirtSmallerArg_ makeDirtSmallerArg_0 makeDirtSmallerArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "makeDirtSmaller"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "DirtData"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ makeDirtSmallerArg_, makeDirtSmallerArg_0, makeDirtSmallerArg_1 ]


{-| cleanDirt: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.DirtData
    -> Int
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
cleanDirt :
    Elm.Expression -> Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
cleanDirt cleanDirtArg_ cleanDirtArg_0 cleanDirtArg_1 cleanDirtArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "cleanDirt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "DirtData"
                              []
                          , Type.int
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ cleanDirtArg_
        , cleanDirtArg_0
        , Elm.int cleanDirtArg_1
        , cleanDirtArg_2
        ]


{-| doClean: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.Point
    -> Int
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
doClean :
    Elm.Expression -> Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
doClean doCleanArg_ doCleanArg_0 doCleanArg_1 doCleanArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "doClean"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "Point"
                              []
                          , Type.int
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ doCleanArg_, doCleanArg_0, Elm.int doCleanArg_1, doCleanArg_2 ]


{-| activateGenerosityTrap: 
    GameStateManipulation.RelicData
    -> GameStateManipulation.PersonData
    -> Int
    -> Types.GameState
    -> Types.GameState
-}
activateGenerosityTrap :
    Elm.Expression -> Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
activateGenerosityTrap activateGenerosityTrapArg_ activateGenerosityTrapArg_0 activateGenerosityTrapArg_1 activateGenerosityTrapArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "activateGenerosityTrap"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          , Type.int
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ activateGenerosityTrapArg_
        , activateGenerosityTrapArg_0
        , Elm.int activateGenerosityTrapArg_1
        , activateGenerosityTrapArg_2
        ]


{-| executeActionOnGameState: 
    Types.ActionPerformer
    -> GameStateManipulation.ActionOnGamestate
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
executeActionOnGameState :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
executeActionOnGameState executeActionOnGameStateArg_ executeActionOnGameStateArg_0 executeActionOnGameStateArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "executeActionOnGameState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "ActionPerformer" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ executeActionOnGameStateArg_
        , executeActionOnGameStateArg_0
        , executeActionOnGameStateArg_1
        ]


{-| combineBatchActionResult: 
    GameStateManipulation.ActionOnGamestate
    -> ( Types.GameState, Types.BackendTrigger )
    -> ( Types.GameState, Types.BackendTrigger )
-}
combineBatchActionResult : Elm.Expression -> Elm.Expression -> Elm.Expression
combineBatchActionResult combineBatchActionResultArg_ combineBatchActionResultArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "combineBatchActionResult"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "ActionOnGamestate"
                              []
                          , Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ combineBatchActionResultArg_, combineBatchActionResultArg_0 ]


{-| handleBatchAction: 
    List GameStateManipulation.ActionOnGamestate
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
handleBatchAction : List Elm.Expression -> Elm.Expression -> Elm.Expression
handleBatchAction handleBatchActionArg_ handleBatchActionArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "handleBatchAction"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "GameStateManipulation" ]
                                 "ActionOnGamestate"
                                 []
                              )
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ Elm.list handleBatchActionArg_, handleBatchActionArg_0 ]


{-| internalExecuteActionOnGameState: 
    GameStateManipulation.ActionOnGamestate
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
internalExecuteActionOnGameState :
    Elm.Expression -> Elm.Expression -> Elm.Expression
internalExecuteActionOnGameState internalExecuteActionOnGameStateArg_ internalExecuteActionOnGameStateArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "internalExecuteActionOnGameState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ internalExecuteActionOnGameStateArg_
        , internalExecuteActionOnGameStateArg_0
        ]


{-| handleActivateGenerosityTrap: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.RelicId
    -> Int
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
handleActivateGenerosityTrap :
    Elm.Expression -> Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
handleActivateGenerosityTrap handleActivateGenerosityTrapArg_ handleActivateGenerosityTrapArg_0 handleActivateGenerosityTrapArg_1 handleActivateGenerosityTrapArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "handleActivateGenerosityTrap"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicId"
                              []
                          , Type.int
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ handleActivateGenerosityTrapArg_
        , handleActivateGenerosityTrapArg_0
        , Elm.int handleActivateGenerosityTrapArg_1
        , handleActivateGenerosityTrapArg_2
        ]


{-| playerEarnsExperience: GameStateManipulation.PersonId -> Int -> Types.GameState -> Types.GameState -}
playerEarnsExperience :
    Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
playerEarnsExperience playerEarnsExperienceArg_ playerEarnsExperienceArg_0 playerEarnsExperienceArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "playerEarnsExperience"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.int
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ playerEarnsExperienceArg_
        , Elm.int playerEarnsExperienceArg_0
        , playerEarnsExperienceArg_1
        ]


{-| updateRelicsByPositionWithExperience: 
    GameStateManipulation.PersonId
    -> Int
    -> Dict.Dict Types.RelicLocation Types.RealRelicDict
    -> Dict.Dict Types.RelicLocation Types.RealRelicDict
-}
updateRelicsByPositionWithExperience :
    Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
updateRelicsByPositionWithExperience updateRelicsByPositionWithExperienceArg_ updateRelicsByPositionWithExperienceArg_0 updateRelicsByPositionWithExperienceArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "updateRelicsByPositionWithExperience"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.int
                          , Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.namedWith [ "Types" ] "RelicLocation" []
                              , Type.namedWith [ "Types" ] "RealRelicDict" []
                              ]
                          ]
                          (Type.namedWith
                               [ "Dict" ]
                               "Dict"
                               [ Type.namedWith [ "Types" ] "RelicLocation" []
                               , Type.namedWith [ "Types" ] "RealRelicDict" []
                               ]
                          )
                     )
             }
        )
        [ updateRelicsByPositionWithExperienceArg_
        , Elm.int updateRelicsByPositionWithExperienceArg_0
        , updateRelicsByPositionWithExperienceArg_1
        ]


{-| {-| Some relics are interested in actions against the GameState. This function
lets relics modify the GameState in response to actions.
-}

relicMiddleware: 
    GameStateManipulation.ActionOnGamestate
    -> GameStateManipulation.RelicData
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
relicMiddleware :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
relicMiddleware relicMiddlewareArg_ relicMiddlewareArg_0 relicMiddlewareArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "relicMiddleware"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ relicMiddlewareArg_, relicMiddlewareArg_0, relicMiddlewareArg_1 ]


{-| applyRelicMiddleware: 
    GameStateManipulation.ActionOnGamestate
    -> GameStateManipulation.RelicData
    -> ( Types.GameState, List Types.BackendTrigger )
    -> ( Types.GameState, List Types.BackendTrigger )
-}
applyRelicMiddleware :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
applyRelicMiddleware applyRelicMiddlewareArg_ applyRelicMiddlewareArg_0 applyRelicMiddlewareArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "applyRelicMiddleware"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.list
                                 (Type.namedWith [ "Types" ] "BackendTrigger" []
                                 )
                              )
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.list
                                    (Type.namedWith
                                         [ "Types" ]
                                         "BackendTrigger"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ applyRelicMiddlewareArg_
        , applyRelicMiddlewareArg_0
        , applyRelicMiddlewareArg_1
        ]


{-| updateWithRelics: 
    Types.ActionPerformer
    -> GameStateManipulation.ActionOnGamestate
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
updateWithRelics :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
updateWithRelics updateWithRelicsArg_ updateWithRelicsArg_0 updateWithRelicsArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "updateWithRelics"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "ActionPerformer" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ updateWithRelicsArg_, updateWithRelicsArg_0, updateWithRelicsArg_1 ]


{-| relicsAtLocation: GameObjectTypes.Point -> Types.GameState -> List GameStateManipulation.RelicData -}
relicsAtLocation : Elm.Expression -> Elm.Expression -> Elm.Expression
relicsAtLocation relicsAtLocationArg_ relicsAtLocationArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "relicsAtLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "GameStateManipulation" ]
                                    "RelicData"
                                    []
                               )
                          )
                     )
             }
        )
        [ relicsAtLocationArg_, relicsAtLocationArg_0 ]


{-| getRarestRelicAtLocation: 
    GameObjectTypes.Point
    -> Types.GameState
    -> Maybe GameStateManipulation.RelicData
-}
getRarestRelicAtLocation : Elm.Expression -> Elm.Expression -> Elm.Expression
getRarestRelicAtLocation getRarestRelicAtLocationArg_ getRarestRelicAtLocationArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "getRarestRelicAtLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "GameStateManipulation" ]
                                    "RelicData"
                                    []
                               )
                          )
                     )
             }
        )
        [ getRarestRelicAtLocationArg_, getRarestRelicAtLocationArg_0 ]


{-| {-| Add a new dirt or modify an existing dirt's "amount".

Currently used to spawn dirt as a "debug action", not for normal gameplay.

-}

addOrModifyDirt: 
    GameStateManipulation.DirtData
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
addOrModifyDirt : Elm.Expression -> Elm.Expression -> Elm.Expression
addOrModifyDirt addOrModifyDirtArg_ addOrModifyDirtArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "addOrModifyDirt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "DirtData"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ addOrModifyDirtArg_, addOrModifyDirtArg_0 ]


{-| updateDirtAtLocation: 
    GameObjectTypes.Point
    -> GameStateManipulation.DirtData
    -> Types.DirtByLocation
    -> Types.DirtByLocation
-}
updateDirtAtLocation :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
updateDirtAtLocation updateDirtAtLocationArg_ updateDirtAtLocationArg_0 updateDirtAtLocationArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "updateDirtAtLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "DirtData"
                              []
                          , Type.namedWith [ "Types" ] "DirtByLocation" []
                          ]
                          (Type.namedWith [ "Types" ] "DirtByLocation" [])
                     )
             }
        )
        [ updateDirtAtLocationArg_
        , updateDirtAtLocationArg_0
        , updateDirtAtLocationArg_1
        ]


{-| getDirtAtLocation: 
    GameObjectTypes.Point
    -> Types.DirtByLocation
    -> Maybe GameStateManipulation.DirtData
-}
getDirtAtLocation : Elm.Expression -> Elm.Expression -> Elm.Expression
getDirtAtLocation getDirtAtLocationArg_ getDirtAtLocationArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "getDirtAtLocation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                          , Type.namedWith [ "Types" ] "DirtByLocation" []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "GameStateManipulation" ]
                                    "DirtData"
                                    []
                               )
                          )
                     )
             }
        )
        [ getDirtAtLocationArg_, getDirtAtLocationArg_0 ]


{-| changeDirtAmount: Types.DirtLocation -> Int -> Types.DirtByLocation -> Types.DirtByLocation -}
changeDirtAmount : Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
changeDirtAmount changeDirtAmountArg_ changeDirtAmountArg_0 changeDirtAmountArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "changeDirtAmount"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Types" ] "DirtLocation" []
                          , Type.int
                          , Type.namedWith [ "Types" ] "DirtByLocation" []
                          ]
                          (Type.namedWith [ "Types" ] "DirtByLocation" [])
                     )
             }
        )
        [ changeDirtAmountArg_
        , Elm.int changeDirtAmountArg_0
        , changeDirtAmountArg_1
        ]


{-| moveRelicFromPlayerToFloor: 
    GameStateManipulation.PersonData
    -> GameStateManipulation.RelicData
    -> Types.RealRelicDict
    -> Types.GameState
    -> Types.GameState
-}
moveRelicFromPlayerToFloor :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
moveRelicFromPlayerToFloor moveRelicFromPlayerToFloorArg_ moveRelicFromPlayerToFloorArg_0 moveRelicFromPlayerToFloorArg_1 moveRelicFromPlayerToFloorArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "moveRelicFromPlayerToFloor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith [ "Types" ] "RealRelicDict" []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ moveRelicFromPlayerToFloorArg_
        , moveRelicFromPlayerToFloorArg_0
        , moveRelicFromPlayerToFloorArg_1
        , moveRelicFromPlayerToFloorArg_2
        ]


{-| dropRelic: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.RelicId
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
dropRelic : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
dropRelic dropRelicArg_ dropRelicArg_0 dropRelicArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "dropRelic"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicId"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ dropRelicArg_, dropRelicArg_0, dropRelicArg_1 ]


{-| moveRelicFromFloorToPlayer: 
    GameStateManipulation.PersonData
    -> GameStateManipulation.RelicData
    -> Types.RealRelicDict
    -> Types.GameState
    -> Types.GameState
-}
moveRelicFromFloorToPlayer :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
moveRelicFromFloorToPlayer moveRelicFromFloorToPlayerArg_ moveRelicFromFloorToPlayerArg_0 moveRelicFromFloorToPlayerArg_1 moveRelicFromFloorToPlayerArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "moveRelicFromFloorToPlayer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonData"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicData"
                              []
                          , Type.namedWith [ "Types" ] "RealRelicDict" []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.namedWith [ "Types" ] "GameState" [])
                     )
             }
        )
        [ moveRelicFromFloorToPlayerArg_
        , moveRelicFromFloorToPlayerArg_0
        , moveRelicFromFloorToPlayerArg_1
        , moveRelicFromFloorToPlayerArg_2
        ]


{-| pickUpRelic: 
    GameStateManipulation.PersonId
    -> GameStateManipulation.RelicId
    -> Types.GameState
    -> ( Types.GameState, Types.BackendTrigger )
-}
pickUpRelic :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
pickUpRelic pickUpRelicArg_ pickUpRelicArg_0 pickUpRelicArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "GameStateManipulation" ]
             , name = "pickUpRelic"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameStateManipulation" ]
                              "PersonId"
                              []
                          , Type.namedWith
                              [ "GameStateManipulation" ]
                              "RelicId"
                              []
                          , Type.namedWith [ "Types" ] "GameState" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Types" ] "GameState" [])
                               (Type.namedWith [ "Types" ] "BackendTrigger" [])
                          )
                     )
             }
        )
        [ pickUpRelicArg_, pickUpRelicArg_0, pickUpRelicArg_1 ]


call_ :
    { cleanStrengthForPlayer :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , addCleanStats : Elm.Expression -> Elm.Expression -> Elm.Expression
    , incrementCleanCount : Elm.Expression -> Elm.Expression -> Elm.Expression
    , updatePersonDictWithExperience :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , activateRelicWithPersonData :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , maybeActivateRelic :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , createActionOnGameStateFromRelicActivation :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropAndDoubleRelicBody :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , relicBody :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , isRelicHeldByPerson :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getRelicsHeldByPlayer : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getRelicsAtFloorPoint : Elm.Expression -> Elm.Expression -> Elm.Expression
    , xpMultiplierForPlayer : Elm.Expression -> Elm.Expression -> Elm.Expression
    , handleDroppingDoubler :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , applyClean :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , handleSplashBucket :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , incrementClearCount : Elm.Expression -> Elm.Expression -> Elm.Expression
    , destroyDirt :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , makeDirtSmaller :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , cleanDirt :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , doClean :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , activateGenerosityTrap :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , executeActionOnGameState :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , combineBatchActionResult :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , handleBatchAction : Elm.Expression -> Elm.Expression -> Elm.Expression
    , internalExecuteActionOnGameState :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , handleActivateGenerosityTrap :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , playerEarnsExperience :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateRelicsByPositionWithExperience :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , relicMiddleware :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , applyRelicMiddleware :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateWithRelics :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , relicsAtLocation : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getRarestRelicAtLocation :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , addOrModifyDirt : Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateDirtAtLocation :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getDirtAtLocation : Elm.Expression -> Elm.Expression -> Elm.Expression
    , changeDirtAmount :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , moveRelicFromPlayerToFloor :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , dropRelic :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , moveRelicFromFloorToPlayer :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , pickUpRelic :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { cleanStrengthForPlayer =
        \cleanStrengthForPlayerArg_ cleanStrengthForPlayerArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "cleanStrengthForPlayer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Types" ] "GameState" []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ cleanStrengthForPlayerArg_, cleanStrengthForPlayerArg_0 ]
    , addCleanStats =
        \addCleanStatsArg_ addCleanStatsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "addCleanStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ addCleanStatsArg_, addCleanStatsArg_0 ]
    , incrementCleanCount =
        \incrementCleanCountArg_ incrementCleanCountArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "incrementCleanCount"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "PersonDict" ]
                                      "PersonDict"
                                      [ Type.namedWith
                                            [ "GameStateManipulation" ]
                                            "PersonData"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "PersonDict" ]
                                       "PersonDict"
                                       [ Type.namedWith
                                           [ "GameStateManipulation" ]
                                           "PersonData"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ incrementCleanCountArg_, incrementCleanCountArg_0 ]
    , updatePersonDictWithExperience =
        \updatePersonDictWithExperienceArg_ updatePersonDictWithExperienceArg_0 updatePersonDictWithExperienceArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "updatePersonDictWithExperience"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.int
                                  , Type.namedWith
                                      [ "PersonDict" ]
                                      "PersonDict"
                                      [ Type.namedWith
                                            [ "GameStateManipulation" ]
                                            "PersonData"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "PersonDict" ]
                                       "PersonDict"
                                       [ Type.namedWith
                                           [ "GameStateManipulation" ]
                                           "PersonData"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ updatePersonDictWithExperienceArg_
                , updatePersonDictWithExperienceArg_0
                , updatePersonDictWithExperienceArg_1
                ]
    , activateRelicWithPersonData =
        \activateRelicWithPersonDataArg_ activateRelicWithPersonDataArg_0 activateRelicWithPersonDataArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "activateRelicWithPersonData"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Types" ] "GameState" []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ activateRelicWithPersonDataArg_
                , activateRelicWithPersonDataArg_0
                , activateRelicWithPersonDataArg_1
                ]
    , maybeActivateRelic =
        \maybeActivateRelicArg_ maybeActivateRelicArg_0 maybeActivateRelicArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "maybeActivateRelic"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ maybeActivateRelicArg_
                , maybeActivateRelicArg_0
                , maybeActivateRelicArg_1
                ]
    , createActionOnGameStateFromRelicActivation =
        \createActionOnGameStateFromRelicActivationArg_ createActionOnGameStateFromRelicActivationArg_0 createActionOnGameStateFromRelicActivationArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "createActionOnGameStateFromRelicActivation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith
                                       [ "GameStateManipulation" ]
                                       "ActionOnGamestate"
                                       []
                                  )
                             )
                     }
                )
                [ createActionOnGameStateFromRelicActivationArg_
                , createActionOnGameStateFromRelicActivationArg_0
                , createActionOnGameStateFromRelicActivationArg_1
                ]
    , dropAndDoubleRelicBody =
        \dropAndDoubleRelicBodyArg_ dropAndDoubleRelicBodyArg_0 dropAndDoubleRelicBodyArg_1 dropAndDoubleRelicBodyArg_2 dropAndDoubleRelicBodyArg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "dropAndDoubleRelicBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Types" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  , Type.list
                                      (Type.namedWith
                                         [ "GameStateManipulation" ]
                                         "PersonId"
                                         []
                                      )
                                  , Type.bool
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Html" ]
                                            "Html"
                                            [ Type.namedWith
                                                [ "Types" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ dropAndDoubleRelicBodyArg_
                , dropAndDoubleRelicBodyArg_0
                , dropAndDoubleRelicBodyArg_1
                , dropAndDoubleRelicBodyArg_2
                , dropAndDoubleRelicBodyArg_3
                ]
    , relicBody =
        \relicBodyArg_ relicBodyArg_0 relicBodyArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "relicBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Types" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Html" ]
                                            "Html"
                                            [ Type.namedWith
                                                [ "Types" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ relicBodyArg_, relicBodyArg_0, relicBodyArg_1 ]
    , isRelicHeldByPerson =
        \isRelicHeldByPersonArg_ isRelicHeldByPersonArg_0 isRelicHeldByPersonArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "isRelicHeldByPerson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Types" ] "GameState" []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ isRelicHeldByPersonArg_
                , isRelicHeldByPersonArg_0
                , isRelicHeldByPersonArg_1
                ]
    , getRelicsHeldByPlayer =
        \getRelicsHeldByPlayerArg_ getRelicsHeldByPlayerArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "getRelicsHeldByPlayer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "RealRelicDict" []
                                  )
                             )
                     }
                )
                [ getRelicsHeldByPlayerArg_, getRelicsHeldByPlayerArg_0 ]
    , getRelicsAtFloorPoint =
        \getRelicsAtFloorPointArg_ getRelicsAtFloorPointArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "getRelicsAtFloorPoint"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "Point"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "RealRelicDict" []
                                  )
                             )
                     }
                )
                [ getRelicsAtFloorPointArg_, getRelicsAtFloorPointArg_0 ]
    , xpMultiplierForPlayer =
        \xpMultiplierForPlayerArg_ xpMultiplierForPlayerArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "xpMultiplierForPlayer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Types" ] "GameState" []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  ]
                                  Type.float
                             )
                     }
                )
                [ xpMultiplierForPlayerArg_, xpMultiplierForPlayerArg_0 ]
    , handleDroppingDoubler =
        \handleDroppingDoublerArg_ handleDroppingDoublerArg_0 handleDroppingDoublerArg_1 handleDroppingDoublerArg_2 handleDroppingDoublerArg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "handleDroppingDoubler"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.list
                                      (Type.namedWith
                                         [ "GameStateManipulation" ]
                                         "PersonId"
                                         []
                                      )
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ handleDroppingDoublerArg_
                , handleDroppingDoublerArg_0
                , handleDroppingDoublerArg_1
                , handleDroppingDoublerArg_2
                , handleDroppingDoublerArg_3
                ]
    , applyClean =
        \applyCleanArg_ applyCleanArg_0 applyCleanArg_1 applyCleanArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "applyClean"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.int
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "Point"
                                      []
                                  , Type.tuple
                                      (Type.namedWith [ "Types" ] "GameState" []
                                      )
                                      (Type.namedWith
                                         [ "Types" ]
                                         "BackendTrigger"
                                         []
                                      )
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ applyCleanArg_
                , applyCleanArg_0
                , applyCleanArg_1
                , applyCleanArg_2
                ]
    , handleSplashBucket =
        \handleSplashBucketArg_ handleSplashBucketArg_0 handleSplashBucketArg_1 handleSplashBucketArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "handleSplashBucket"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "Point"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ handleSplashBucketArg_
                , handleSplashBucketArg_0
                , handleSplashBucketArg_1
                , handleSplashBucketArg_2
                ]
    , incrementClearCount =
        \incrementClearCountArg_ incrementClearCountArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "incrementClearCount"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "PersonDict" ]
                                      "PersonDict"
                                      [ Type.namedWith
                                            [ "GameStateManipulation" ]
                                            "PersonData"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "PersonDict" ]
                                       "PersonDict"
                                       [ Type.namedWith
                                           [ "GameStateManipulation" ]
                                           "PersonData"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ incrementClearCountArg_, incrementClearCountArg_0 ]
    , destroyDirt =
        \destroyDirtArg_ destroyDirtArg_0 destroyDirtArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "destroyDirt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "DirtData"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ destroyDirtArg_, destroyDirtArg_0, destroyDirtArg_1 ]
    , makeDirtSmaller =
        \makeDirtSmallerArg_ makeDirtSmallerArg_0 makeDirtSmallerArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "makeDirtSmaller"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "DirtData"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ makeDirtSmallerArg_
                , makeDirtSmallerArg_0
                , makeDirtSmallerArg_1
                ]
    , cleanDirt =
        \cleanDirtArg_ cleanDirtArg_0 cleanDirtArg_1 cleanDirtArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "cleanDirt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "DirtData"
                                      []
                                  , Type.int
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ cleanDirtArg_
                , cleanDirtArg_0
                , cleanDirtArg_1
                , cleanDirtArg_2
                ]
    , doClean =
        \doCleanArg_ doCleanArg_0 doCleanArg_1 doCleanArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "doClean"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "Point"
                                      []
                                  , Type.int
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ doCleanArg_, doCleanArg_0, doCleanArg_1, doCleanArg_2 ]
    , activateGenerosityTrap =
        \activateGenerosityTrapArg_ activateGenerosityTrapArg_0 activateGenerosityTrapArg_1 activateGenerosityTrapArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "activateGenerosityTrap"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  , Type.int
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ activateGenerosityTrapArg_
                , activateGenerosityTrapArg_0
                , activateGenerosityTrapArg_1
                , activateGenerosityTrapArg_2
                ]
    , executeActionOnGameState =
        \executeActionOnGameStateArg_ executeActionOnGameStateArg_0 executeActionOnGameStateArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "executeActionOnGameState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Types" ]
                                      "ActionPerformer"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ executeActionOnGameStateArg_
                , executeActionOnGameStateArg_0
                , executeActionOnGameStateArg_1
                ]
    , combineBatchActionResult =
        \combineBatchActionResultArg_ combineBatchActionResultArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "combineBatchActionResult"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.tuple
                                      (Type.namedWith [ "Types" ] "GameState" []
                                      )
                                      (Type.namedWith
                                         [ "Types" ]
                                         "BackendTrigger"
                                         []
                                      )
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ combineBatchActionResultArg_, combineBatchActionResultArg_0 ]
    , handleBatchAction =
        \handleBatchActionArg_ handleBatchActionArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "handleBatchAction"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "GameStateManipulation" ]
                                         "ActionOnGamestate"
                                         []
                                      )
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ handleBatchActionArg_, handleBatchActionArg_0 ]
    , internalExecuteActionOnGameState =
        \internalExecuteActionOnGameStateArg_ internalExecuteActionOnGameStateArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "internalExecuteActionOnGameState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ internalExecuteActionOnGameStateArg_
                , internalExecuteActionOnGameStateArg_0
                ]
    , handleActivateGenerosityTrap =
        \handleActivateGenerosityTrapArg_ handleActivateGenerosityTrapArg_0 handleActivateGenerosityTrapArg_1 handleActivateGenerosityTrapArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "handleActivateGenerosityTrap"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicId"
                                      []
                                  , Type.int
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ handleActivateGenerosityTrapArg_
                , handleActivateGenerosityTrapArg_0
                , handleActivateGenerosityTrapArg_1
                , handleActivateGenerosityTrapArg_2
                ]
    , playerEarnsExperience =
        \playerEarnsExperienceArg_ playerEarnsExperienceArg_0 playerEarnsExperienceArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "playerEarnsExperience"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.int
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ playerEarnsExperienceArg_
                , playerEarnsExperienceArg_0
                , playerEarnsExperienceArg_1
                ]
    , updateRelicsByPositionWithExperience =
        \updateRelicsByPositionWithExperienceArg_ updateRelicsByPositionWithExperienceArg_0 updateRelicsByPositionWithExperienceArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "updateRelicsByPositionWithExperience"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.int
                                  , Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.namedWith
                                            [ "Types" ]
                                            "RelicLocation"
                                            []
                                      , Type.namedWith
                                            [ "Types" ]
                                            "RealRelicDict"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Dict" ]
                                       "Dict"
                                       [ Type.namedWith
                                           [ "Types" ]
                                           "RelicLocation"
                                           []
                                       , Type.namedWith
                                           [ "Types" ]
                                           "RealRelicDict"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ updateRelicsByPositionWithExperienceArg_
                , updateRelicsByPositionWithExperienceArg_0
                , updateRelicsByPositionWithExperienceArg_1
                ]
    , relicMiddleware =
        \relicMiddlewareArg_ relicMiddlewareArg_0 relicMiddlewareArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "relicMiddleware"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ relicMiddlewareArg_
                , relicMiddlewareArg_0
                , relicMiddlewareArg_1
                ]
    , applyRelicMiddleware =
        \applyRelicMiddlewareArg_ applyRelicMiddlewareArg_0 applyRelicMiddlewareArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "applyRelicMiddleware"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.tuple
                                      (Type.namedWith [ "Types" ] "GameState" []
                                      )
                                      (Type.list
                                         (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                         )
                                      )
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.list
                                            (Type.namedWith
                                                 [ "Types" ]
                                                 "BackendTrigger"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ applyRelicMiddlewareArg_
                , applyRelicMiddlewareArg_0
                , applyRelicMiddlewareArg_1
                ]
    , updateWithRelics =
        \updateWithRelicsArg_ updateWithRelicsArg_0 updateWithRelicsArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "updateWithRelics"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Types" ]
                                      "ActionPerformer"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ updateWithRelicsArg_
                , updateWithRelicsArg_0
                , updateWithRelicsArg_1
                ]
    , relicsAtLocation =
        \relicsAtLocationArg_ relicsAtLocationArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "relicsAtLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "GameStateManipulation" ]
                                            "RelicData"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ relicsAtLocationArg_, relicsAtLocationArg_0 ]
    , getRarestRelicAtLocation =
        \getRarestRelicAtLocationArg_ getRarestRelicAtLocationArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "getRarestRelicAtLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "GameStateManipulation" ]
                                            "RelicData"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getRarestRelicAtLocationArg_, getRarestRelicAtLocationArg_0 ]
    , addOrModifyDirt =
        \addOrModifyDirtArg_ addOrModifyDirtArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "addOrModifyDirt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "DirtData"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ addOrModifyDirtArg_, addOrModifyDirtArg_0 ]
    , updateDirtAtLocation =
        \updateDirtAtLocationArg_ updateDirtAtLocationArg_0 updateDirtAtLocationArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "updateDirtAtLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "DirtData"
                                      []
                                  , Type.namedWith
                                      [ "Types" ]
                                      "DirtByLocation"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Types" ]
                                       "DirtByLocation"
                                       []
                                  )
                             )
                     }
                )
                [ updateDirtAtLocationArg_
                , updateDirtAtLocationArg_0
                , updateDirtAtLocationArg_1
                ]
    , getDirtAtLocation =
        \getDirtAtLocationArg_ getDirtAtLocationArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "getDirtAtLocation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "Point"
                                      []
                                  , Type.namedWith
                                      [ "Types" ]
                                      "DirtByLocation"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "GameStateManipulation" ]
                                            "DirtData"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ getDirtAtLocationArg_, getDirtAtLocationArg_0 ]
    , changeDirtAmount =
        \changeDirtAmountArg_ changeDirtAmountArg_0 changeDirtAmountArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "changeDirtAmount"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Types" ] "DirtLocation" []
                                  , Type.int
                                  , Type.namedWith
                                      [ "Types" ]
                                      "DirtByLocation"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Types" ]
                                       "DirtByLocation"
                                       []
                                  )
                             )
                     }
                )
                [ changeDirtAmountArg_
                , changeDirtAmountArg_0
                , changeDirtAmountArg_1
                ]
    , moveRelicFromPlayerToFloor =
        \moveRelicFromPlayerToFloorArg_ moveRelicFromPlayerToFloorArg_0 moveRelicFromPlayerToFloorArg_1 moveRelicFromPlayerToFloorArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "moveRelicFromPlayerToFloor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "Types" ]
                                      "RealRelicDict"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ moveRelicFromPlayerToFloorArg_
                , moveRelicFromPlayerToFloorArg_0
                , moveRelicFromPlayerToFloorArg_1
                , moveRelicFromPlayerToFloorArg_2
                ]
    , dropRelic =
        \dropRelicArg_ dropRelicArg_0 dropRelicArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "dropRelic"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ dropRelicArg_, dropRelicArg_0, dropRelicArg_1 ]
    , moveRelicFromFloorToPlayer =
        \moveRelicFromFloorToPlayerArg_ moveRelicFromFloorToPlayerArg_0 moveRelicFromFloorToPlayerArg_1 moveRelicFromFloorToPlayerArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "moveRelicFromFloorToPlayer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonData"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicData"
                                      []
                                  , Type.namedWith
                                      [ "Types" ]
                                      "RealRelicDict"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.namedWith [ "Types" ] "GameState" [])
                             )
                     }
                )
                [ moveRelicFromFloorToPlayerArg_
                , moveRelicFromFloorToPlayerArg_0
                , moveRelicFromFloorToPlayerArg_1
                , moveRelicFromFloorToPlayerArg_2
                ]
    , pickUpRelic =
        \pickUpRelicArg_ pickUpRelicArg_0 pickUpRelicArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "GameStateManipulation" ]
                     , name = "pickUpRelic"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "PersonId"
                                      []
                                  , Type.namedWith
                                      [ "GameStateManipulation" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith [ "Types" ] "GameState" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Types" ]
                                            "GameState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Types" ]
                                            "BackendTrigger"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ pickUpRelicArg_, pickUpRelicArg_0, pickUpRelicArg_1 ]
    }


values_ :
    { cleanStrengthForPlayer : Elm.Expression
    , addCleanStats : Elm.Expression
    , incrementCleanCount : Elm.Expression
    , updatePersonDictWithExperience : Elm.Expression
    , activateRelicWithPersonData : Elm.Expression
    , maybeActivateRelic : Elm.Expression
    , createActionOnGameStateFromRelicActivation : Elm.Expression
    , dropAndDoubleRelicBody : Elm.Expression
    , relicBody : Elm.Expression
    , isRelicHeldByPerson : Elm.Expression
    , getRelicsHeldByPlayer : Elm.Expression
    , getRelicsAtFloorPoint : Elm.Expression
    , xpMultiplierForPlayer : Elm.Expression
    , handleDroppingDoubler : Elm.Expression
    , applyClean : Elm.Expression
    , handleSplashBucket : Elm.Expression
    , incrementClearCount : Elm.Expression
    , destroyDirt : Elm.Expression
    , makeDirtSmaller : Elm.Expression
    , cleanDirt : Elm.Expression
    , doClean : Elm.Expression
    , activateGenerosityTrap : Elm.Expression
    , executeActionOnGameState : Elm.Expression
    , combineBatchActionResult : Elm.Expression
    , handleBatchAction : Elm.Expression
    , internalExecuteActionOnGameState : Elm.Expression
    , handleActivateGenerosityTrap : Elm.Expression
    , playerEarnsExperience : Elm.Expression
    , updateRelicsByPositionWithExperience : Elm.Expression
    , relicMiddleware : Elm.Expression
    , applyRelicMiddleware : Elm.Expression
    , updateWithRelics : Elm.Expression
    , relicsAtLocation : Elm.Expression
    , getRarestRelicAtLocation : Elm.Expression
    , addOrModifyDirt : Elm.Expression
    , updateDirtAtLocation : Elm.Expression
    , getDirtAtLocation : Elm.Expression
    , changeDirtAmount : Elm.Expression
    , moveRelicFromPlayerToFloor : Elm.Expression
    , dropRelic : Elm.Expression
    , moveRelicFromFloorToPlayer : Elm.Expression
    , pickUpRelic : Elm.Expression
    }
values_ =
    { cleanStrengthForPlayer =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "cleanStrengthForPlayer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "GameState" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         ]
                         Type.int
                    )
            }
    , addCleanStats =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "addCleanStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , incrementCleanCount =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "incrementCleanCount"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "PersonDict" ]
                             "PersonDict"
                             [ Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "PersonData"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith
                                  [ "GameStateManipulation" ]
                                  "PersonData"
                                  []
                              ]
                         )
                    )
            }
    , updatePersonDictWithExperience =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "updatePersonDictWithExperience"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.int
                         , Type.namedWith
                             [ "PersonDict" ]
                             "PersonDict"
                             [ Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "PersonData"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith
                                  [ "GameStateManipulation" ]
                                  "PersonData"
                                  []
                              ]
                         )
                    )
            }
    , activateRelicWithPersonData =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "activateRelicWithPersonData"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "GameState" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , maybeActivateRelic =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "maybeActivateRelic"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicId"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , createActionOnGameStateFromRelicActivation =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "createActionOnGameStateFromRelicActivation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicId"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith
                              [ "GameStateManipulation" ]
                              "ActionOnGamestate"
                              []
                         )
                    )
            }
    , dropAndDoubleRelicBody =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "dropAndDoubleRelicBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "FrontendPlayingState" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         , Type.list
                             (Type.namedWith
                                [ "GameStateManipulation" ]
                                "PersonId"
                                []
                             )
                         , Type.bool
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "Html" ]
                                   "Html"
                                   [ Type.namedWith [ "Types" ] "FrontendMsg" []
                                   ]
                              )
                         )
                    )
            }
    , relicBody =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "relicBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "FrontendPlayingState" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "Html" ]
                                   "Html"
                                   [ Type.namedWith [ "Types" ] "FrontendMsg" []
                                   ]
                              )
                         )
                    )
            }
    , isRelicHeldByPerson =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "isRelicHeldByPerson"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "GameState" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         ]
                         Type.bool
                    )
            }
    , getRelicsHeldByPlayer =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "getRelicsHeldByPlayer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "RealRelicDict" [])
                    )
            }
    , getRelicsAtFloorPoint =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "getRelicsAtFloorPoint"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameStateManipulation" ] "Point" []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "RealRelicDict" [])
                    )
            }
    , xpMultiplierForPlayer =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "xpMultiplierForPlayer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "GameState" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         ]
                         Type.float
                    )
            }
    , handleDroppingDoubler =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "handleDroppingDoubler"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.list
                             (Type.namedWith
                                [ "GameStateManipulation" ]
                                "PersonId"
                                []
                             )
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , applyClean =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "applyClean"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.int
                         , Type.namedWith [ "GameStateManipulation" ] "Point" []
                         , Type.tuple
                             (Type.namedWith [ "Types" ] "GameState" [])
                             (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , handleSplashBucket =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "handleSplashBucket"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameStateManipulation" ] "Point" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , incrementClearCount =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "incrementClearCount"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "PersonDict" ]
                             "PersonDict"
                             [ Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "PersonData"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "PersonDict" ]
                              "PersonDict"
                              [ Type.namedWith
                                  [ "GameStateManipulation" ]
                                  "PersonData"
                                  []
                              ]
                         )
                    )
            }
    , destroyDirt =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "destroyDirt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "DirtData"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , makeDirtSmaller =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "makeDirtSmaller"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "DirtData"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , cleanDirt =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "cleanDirt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "DirtData"
                             []
                         , Type.int
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , doClean =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "doClean"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith [ "GameStateManipulation" ] "Point" []
                         , Type.int
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , activateGenerosityTrap =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "activateGenerosityTrap"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         , Type.int
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , executeActionOnGameState =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "executeActionOnGameState"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "ActionPerformer" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , combineBatchActionResult =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "combineBatchActionResult"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "ActionOnGamestate"
                             []
                         , Type.tuple
                             (Type.namedWith [ "Types" ] "GameState" [])
                             (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , handleBatchAction =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "handleBatchAction"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "GameStateManipulation" ]
                                "ActionOnGamestate"
                                []
                             )
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , internalExecuteActionOnGameState =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "internalExecuteActionOnGameState"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , handleActivateGenerosityTrap =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "handleActivateGenerosityTrap"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicId"
                             []
                         , Type.int
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , playerEarnsExperience =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "playerEarnsExperience"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.int
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , updateRelicsByPositionWithExperience =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "updateRelicsByPositionWithExperience"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.int
                         , Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.namedWith [ "Types" ] "RelicLocation" []
                             , Type.namedWith [ "Types" ] "RealRelicDict" []
                             ]
                         ]
                         (Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.namedWith [ "Types" ] "RelicLocation" []
                              , Type.namedWith [ "Types" ] "RealRelicDict" []
                              ]
                         )
                    )
            }
    , relicMiddleware =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "relicMiddleware"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , applyRelicMiddleware =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "applyRelicMiddleware"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.tuple
                             (Type.namedWith [ "Types" ] "GameState" [])
                             (Type.list
                                (Type.namedWith [ "Types" ] "BackendTrigger" [])
                             )
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.list
                                   (Type.namedWith
                                        [ "Types" ]
                                        "BackendTrigger"
                                        []
                                   )
                              )
                         )
                    )
            }
    , updateWithRelics =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "updateWithRelics"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "ActionPerformer" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , relicsAtLocation =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "relicsAtLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "RelicData"
                                   []
                              )
                         )
                    )
            }
    , getRarestRelicAtLocation =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "getRarestRelicAtLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "RelicData"
                                   []
                              )
                         )
                    )
            }
    , addOrModifyDirt =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "addOrModifyDirt"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "DirtData"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , updateDirtAtLocation =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "updateDirtAtLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "DirtData"
                             []
                         , Type.namedWith [ "Types" ] "DirtByLocation" []
                         ]
                         (Type.namedWith [ "Types" ] "DirtByLocation" [])
                    )
            }
    , getDirtAtLocation =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "getDirtAtLocation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "Point" []
                         , Type.namedWith [ "Types" ] "DirtByLocation" []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "GameStateManipulation" ]
                                   "DirtData"
                                   []
                              )
                         )
                    )
            }
    , changeDirtAmount =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "changeDirtAmount"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Types" ] "DirtLocation" []
                         , Type.int
                         , Type.namedWith [ "Types" ] "DirtByLocation" []
                         ]
                         (Type.namedWith [ "Types" ] "DirtByLocation" [])
                    )
            }
    , moveRelicFromPlayerToFloor =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "moveRelicFromPlayerToFloor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith [ "Types" ] "RealRelicDict" []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , dropRelic =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "dropRelic"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicId"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    , moveRelicFromFloorToPlayer =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "moveRelicFromFloorToPlayer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonData"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicData"
                             []
                         , Type.namedWith [ "Types" ] "RealRelicDict" []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.namedWith [ "Types" ] "GameState" [])
                    )
            }
    , pickUpRelic =
        Elm.value
            { importFrom = [ "GameStateManipulation" ]
            , name = "pickUpRelic"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameStateManipulation" ]
                             "PersonId"
                             []
                         , Type.namedWith
                             [ "GameStateManipulation" ]
                             "RelicId"
                             []
                         , Type.namedWith [ "Types" ] "GameState" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Types" ] "GameState" [])
                              (Type.namedWith [ "Types" ] "BackendTrigger" [])
                         )
                    )
            }
    }