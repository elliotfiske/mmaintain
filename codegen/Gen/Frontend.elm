module Gen.Frontend exposing
    ( moduleName_, performClean, tryCleaning, pickUpButton, dropButton, relicCardTitle
    , heldRelicView, relicLevelProgressBar, relicRarityBadge, lockedSlotView, availableRelicView, renderRelicSlots, renderRelicList
    , renderDirtOnThisSquare, renderOnThisSquare, renderHeldRelics, renderDesktopRelicSidebar, renderMobileRelicDialog, renderMobileHamburgerButton, renderRelicContent
    , renderXPMultiplier, renderExpProgress, renderCleanStrength, levelProgressBar, renderXP, renderMap, renderMyHUD
    , renderPlayingStateWithMe, renderPlayingState, extractMyself, renderModel, view, initFrontendPlayingState, updatePlayingStateWithBackendStateDump
    , updateFromBackend, updateCameraPositionWithPlayer, updateCameraPosition, updateStateWithAction, updateModelWithAction, updateModelWithActionFromMyself, moveMeTowardsTargetPoint
    , moveMeTowardsMyTargetIfAny, modelUpdateTarget, modelUpdateIfPlaying, toggleMobileRelicMenu, toggleDebugStuff, update, init
    , handleKey, toKey, keyDecoder, maybeFireEveryTick, subscriptions, receiveElementSize, annotation_
    , call_, values_
    )

{-|
# Generated bindings for Frontend

@docs moduleName_, performClean, tryCleaning, pickUpButton, dropButton, relicCardTitle
@docs heldRelicView, relicLevelProgressBar, relicRarityBadge, lockedSlotView, availableRelicView, renderRelicSlots
@docs renderRelicList, renderDirtOnThisSquare, renderOnThisSquare, renderHeldRelics, renderDesktopRelicSidebar, renderMobileRelicDialog
@docs renderMobileHamburgerButton, renderRelicContent, renderXPMultiplier, renderExpProgress, renderCleanStrength, levelProgressBar
@docs renderXP, renderMap, renderMyHUD, renderPlayingStateWithMe, renderPlayingState, extractMyself
@docs renderModel, view, initFrontendPlayingState, updatePlayingStateWithBackendStateDump, updateFromBackend, updateCameraPositionWithPlayer
@docs updateCameraPosition, updateStateWithAction, updateModelWithAction, updateModelWithActionFromMyself, moveMeTowardsTargetPoint, moveMeTowardsMyTargetIfAny
@docs modelUpdateTarget, modelUpdateIfPlaying, toggleMobileRelicMenu, toggleDebugStuff, update, init
@docs handleKey, toKey, keyDecoder, maybeFireEveryTick, subscriptions, receiveElementSize
@docs annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Frontend" ]


{-| performClean: 
    GameObjectTypes.PersonData
    -> Frontend.FrontendPlayingState
    -> GameObjectTypes.ActionOnGamestate
-}
performClean : Elm.Expression -> Elm.Expression -> Elm.Expression
performClean performCleanArg_ performCleanArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "performClean"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          , Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "GameObjectTypes" ]
                               "ActionOnGamestate"
                               []
                          )
                     )
             }
        )
        [ performCleanArg_, performCleanArg_0 ]


{-| tryCleaning: Frontend.FrontendPlayingState -> GameObjectTypes.ActionOnGamestate -}
tryCleaning : Elm.Expression -> Elm.Expression
tryCleaning tryCleaningArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "tryCleaning"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "GameObjectTypes" ]
                               "ActionOnGamestate"
                               []
                          )
                     )
             }
        )
        [ tryCleaningArg_ ]


{-| pickUpButton: 
    GameObjectTypes.RelicId
    -> GameObjectTypes.PersonId
    -> Frontend.Html Frontend.FrontendMsg
-}
pickUpButton : Elm.Expression -> Elm.Expression -> Elm.Expression
pickUpButton pickUpButtonArg_ pickUpButtonArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "pickUpButton"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "RelicId" []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonId" []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ pickUpButtonArg_, pickUpButtonArg_0 ]


{-| dropButton: 
    GameObjectTypes.RelicId
    -> GameObjectTypes.PersonId
    -> Frontend.Html Frontend.FrontendMsg
-}
dropButton : Elm.Expression -> Elm.Expression -> Elm.Expression
dropButton dropButtonArg_ dropButtonArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "dropButton"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "RelicId" []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonId" []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ dropButtonArg_, dropButtonArg_0 ]


{-| relicCardTitle: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> GameObjectTypes.RelicData
    -> Html.Html Frontend.FrontendMsg
-}
relicCardTitle :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
relicCardTitle relicCardTitleArg_ relicCardTitleArg_0 relicCardTitleArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "relicCardTitle"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          , Type.namedWith [ "GameObjectTypes" ] "RelicData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ relicCardTitleArg_, relicCardTitleArg_0, relicCardTitleArg_1 ]


{-| heldRelicView: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> GameObjectTypes.RelicData
    -> Html.Html Frontend.FrontendMsg
-}
heldRelicView :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
heldRelicView heldRelicViewArg_ heldRelicViewArg_0 heldRelicViewArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "heldRelicView"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          , Type.namedWith [ "GameObjectTypes" ] "RelicData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ heldRelicViewArg_, heldRelicViewArg_0, heldRelicViewArg_1 ]


{-| relicLevelProgressBar: GameObjectTypes.RelicData -> Html.Html msg -}
relicLevelProgressBar : Elm.Expression -> Elm.Expression
relicLevelProgressBar relicLevelProgressBarArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "relicLevelProgressBar"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "RelicData" []
                          ]
                          (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                     )
             }
        )
        [ relicLevelProgressBarArg_ ]


{-| relicRarityBadge: GameObjectTypes.RelicRarity -> Frontend.Html msg -}
relicRarityBadge : Elm.Expression -> Elm.Expression
relicRarityBadge relicRarityBadgeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "relicRarityBadge"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameObjectTypes" ]
                              "RelicRarity"
                              []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "Html"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ relicRarityBadgeArg_ ]


{-| lockedSlotView: Int -> Html.Html Frontend.FrontendMsg -}
lockedSlotView : Int -> Elm.Expression
lockedSlotView lockedSlotViewArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "lockedSlotView"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ Elm.int lockedSlotViewArg_ ]


{-| availableRelicView: Html.Html Frontend.FrontendMsg -}
availableRelicView : Elm.Expression
availableRelicView =
    Elm.value
        { importFrom = [ "Frontend" ]
        , name = "availableRelicView"
        , annotation =
            Just
                (Type.namedWith
                     [ "Html" ]
                     "Html"
                     [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                )
        }


{-| renderRelicSlots: GameObjectTypes.PersonData -> Int -> List (Html.Html Frontend.FrontendMsg) -}
renderRelicSlots : Elm.Expression -> Int -> Elm.Expression
renderRelicSlots renderRelicSlotsArg_ renderRelicSlotsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderRelicSlots"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          , Type.int
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Html" ]
                                    "Html"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ renderRelicSlotsArg_, Elm.int renderRelicSlotsArg_0 ]


{-| renderRelicList: 
    List GameObjectTypes.RelicData
    -> Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> List (Html.Html Frontend.FrontendMsg)
-}
renderRelicList :
    List Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
renderRelicList renderRelicListArg_ renderRelicListArg_0 renderRelicListArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderRelicList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "GameObjectTypes" ]
                                 "RelicData"
                                 []
                              )
                          , Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Html" ]
                                    "Html"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ Elm.list renderRelicListArg_
        , renderRelicListArg_0
        , renderRelicListArg_1
        ]


{-| renderDirtOnThisSquare: 
    GameObjectTypes.PersonData
    -> GameObjectTypes.DirtData
    -> Html.Html Frontend.FrontendMsg
-}
renderDirtOnThisSquare : Elm.Expression -> Elm.Expression -> Elm.Expression
renderDirtOnThisSquare renderDirtOnThisSquareArg_ renderDirtOnThisSquareArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderDirtOnThisSquare"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          , Type.namedWith [ "GameObjectTypes" ] "DirtData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderDirtOnThisSquareArg_, renderDirtOnThisSquareArg_0 ]


{-| renderOnThisSquare: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderOnThisSquare : Elm.Expression -> Elm.Expression -> Elm.Expression
renderOnThisSquare renderOnThisSquareArg_ renderOnThisSquareArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderOnThisSquare"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderOnThisSquareArg_, renderOnThisSquareArg_0 ]


{-| renderHeldRelics: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderHeldRelics : Elm.Expression -> Elm.Expression -> Elm.Expression
renderHeldRelics renderHeldRelicsArg_ renderHeldRelicsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderHeldRelics"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderHeldRelicsArg_, renderHeldRelicsArg_0 ]


{-| renderDesktopRelicSidebar: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderDesktopRelicSidebar : Elm.Expression -> Elm.Expression -> Elm.Expression
renderDesktopRelicSidebar renderDesktopRelicSidebarArg_ renderDesktopRelicSidebarArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderDesktopRelicSidebar"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderDesktopRelicSidebarArg_, renderDesktopRelicSidebarArg_0 ]


{-| renderMobileRelicDialog: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderMobileRelicDialog : Elm.Expression -> Elm.Expression -> Elm.Expression
renderMobileRelicDialog renderMobileRelicDialogArg_ renderMobileRelicDialogArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderMobileRelicDialog"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderMobileRelicDialogArg_, renderMobileRelicDialogArg_0 ]


{-| renderMobileHamburgerButton: Html.Html Frontend.FrontendMsg -}
renderMobileHamburgerButton : Elm.Expression
renderMobileHamburgerButton =
    Elm.value
        { importFrom = [ "Frontend" ]
        , name = "renderMobileHamburgerButton"
        , annotation =
            Just
                (Type.namedWith
                     [ "Html" ]
                     "Html"
                     [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                )
        }


{-| renderRelicContent: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> List (Html.Html Frontend.FrontendMsg)
-}
renderRelicContent : Elm.Expression -> Elm.Expression -> Elm.Expression
renderRelicContent renderRelicContentArg_ renderRelicContentArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderRelicContent"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.list
                               (Type.namedWith
                                    [ "Html" ]
                                    "Html"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ renderRelicContentArg_, renderRelicContentArg_0 ]


{-| renderXPMultiplier: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderXPMultiplier : Elm.Expression -> Elm.Expression -> Elm.Expression
renderXPMultiplier renderXPMultiplierArg_ renderXPMultiplierArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderXPMultiplier"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderXPMultiplierArg_, renderXPMultiplierArg_0 ]


{-| renderExpProgress: GameObjectTypes.PersonData -> Html.Html Frontend.FrontendMsg -}
renderExpProgress : Elm.Expression -> Elm.Expression
renderExpProgress renderExpProgressArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderExpProgress"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderExpProgressArg_ ]


{-| renderCleanStrength: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderCleanStrength : Elm.Expression -> Elm.Expression -> Elm.Expression
renderCleanStrength renderCleanStrengthArg_ renderCleanStrengthArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderCleanStrength"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderCleanStrengthArg_, renderCleanStrengthArg_0 ]


{-| levelProgressBar: GameObjectTypes.PersonData -> Html.Html Frontend.FrontendMsg -}
levelProgressBar : Elm.Expression -> Elm.Expression
levelProgressBar levelProgressBarArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "levelProgressBar"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ levelProgressBarArg_ ]


{-| renderXP: GameObjectTypes.PersonData -> Html.Html Frontend.FrontendMsg -}
renderXP : Elm.Expression -> Elm.Expression
renderXP renderXPArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderXP"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderXPArg_ ]


{-| renderMap: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderMap : Elm.Expression -> Elm.Expression -> Elm.Expression
renderMap renderMapArg_ renderMapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderMap"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderMapArg_, renderMapArg_0 ]


{-| renderMyHUD: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderMyHUD : Elm.Expression -> Elm.Expression -> Elm.Expression
renderMyHUD renderMyHUDArg_ renderMyHUDArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderMyHUD"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderMyHUDArg_, renderMyHUDArg_0 ]


{-| renderPlayingStateWithMe: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> Html.Html Frontend.FrontendMsg
-}
renderPlayingStateWithMe : Elm.Expression -> Elm.Expression -> Elm.Expression
renderPlayingStateWithMe renderPlayingStateWithMeArg_ renderPlayingStateWithMeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderPlayingStateWithMe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderPlayingStateWithMeArg_, renderPlayingStateWithMeArg_0 ]


{-| renderPlayingState: Frontend.FrontendPlayingState -> Html.Html Frontend.FrontendMsg -}
renderPlayingState : Elm.Expression -> Elm.Expression
renderPlayingState renderPlayingStateArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderPlayingState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderPlayingStateArg_ ]


{-| extractMyself: Frontend.FrontendPlayingState -> Maybe GameObjectTypes.PersonData -}
extractMyself : Elm.Expression -> Elm.Expression
extractMyself extractMyselfArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "extractMyself"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "GameObjectTypes" ]
                                    "PersonData"
                                    []
                               )
                          )
                     )
             }
        )
        [ extractMyselfArg_ ]


{-| renderModel: Frontend.Model -> Html.Html Frontend.FrontendMsg -}
renderModel : Elm.Expression -> Elm.Expression
renderModel renderModelArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "renderModel"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" [] ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ renderModelArg_ ]


{-| view: Frontend.Model -> Browser.Document Frontend.FrontendMsg -}
view : Elm.Expression -> Elm.Expression
view viewArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "view"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" [] ]
                          (Type.namedWith
                               [ "Browser" ]
                               "Document"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ viewArg_ ]


{-| initFrontendPlayingState: Frontend.BackendToFrontendState -> Frontend.FrontendPlayingState -}
initFrontendPlayingState : Elm.Expression -> Elm.Expression
initFrontendPlayingState initFrontendPlayingStateArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "initFrontendPlayingState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "BackendToFrontendState"
                              []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "FrontendPlayingState"
                               []
                          )
                     )
             }
        )
        [ initFrontendPlayingStateArg_ ]


{-| updatePlayingStateWithBackendStateDump: 
    Frontend.BackendToFrontendState
    -> Frontend.FrontendPlayingState
    -> Frontend.FrontendPlayingState
-}
updatePlayingStateWithBackendStateDump :
    Elm.Expression -> Elm.Expression -> Elm.Expression
updatePlayingStateWithBackendStateDump updatePlayingStateWithBackendStateDumpArg_ updatePlayingStateWithBackendStateDumpArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updatePlayingStateWithBackendStateDump"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "BackendToFrontendState"
                              []
                          , Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "FrontendPlayingState"
                               []
                          )
                     )
             }
        )
        [ updatePlayingStateWithBackendStateDumpArg_
        , updatePlayingStateWithBackendStateDumpArg_0
        ]


{-| updateFromBackend: 
    Frontend.ToFrontend
    -> Frontend.Model
    -> ( Frontend.Model, Frontend.Cmd Frontend.FrontendMsg )
-}
updateFromBackend : Elm.Expression -> Elm.Expression -> Elm.Expression
updateFromBackend updateFromBackendArg_ updateFromBackendArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updateFromBackend"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "ToFrontend" []
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Frontend" ] "Model" [])
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ updateFromBackendArg_, updateFromBackendArg_0 ]


{-| updateCameraPositionWithPlayer: 
    Frontend.FrontendPlayingState
    -> GameObjectTypes.PersonData
    -> { width : Float, height : Float }
    -> Frontend.FrontendPlayingState
-}
updateCameraPositionWithPlayer :
    Elm.Expression
    -> Elm.Expression
    -> { width : Float, height : Float }
    -> Elm.Expression
updateCameraPositionWithPlayer updateCameraPositionWithPlayerArg_ updateCameraPositionWithPlayerArg_0 updateCameraPositionWithPlayerArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updateCameraPositionWithPlayer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                          , Type.record
                              [ ( "width", Type.float )
                              , ( "height", Type.float )
                              ]
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "FrontendPlayingState"
                               []
                          )
                     )
             }
        )
        [ updateCameraPositionWithPlayerArg_
        , updateCameraPositionWithPlayerArg_0
        , Elm.record
            [ Tuple.pair
                  "width"
                  (Elm.float updateCameraPositionWithPlayerArg_1.width)
            , Tuple.pair
                  "height"
                  (Elm.float updateCameraPositionWithPlayerArg_1.height)
            ]
        ]


{-| updateCameraPosition: Frontend.FrontendPlayingState -> Frontend.FrontendPlayingState -}
updateCameraPosition : Elm.Expression -> Elm.Expression
updateCameraPosition updateCameraPositionArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updateCameraPosition"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "FrontendPlayingState"
                               []
                          )
                     )
             }
        )
        [ updateCameraPositionArg_ ]


{-| updateStateWithAction: 
    Frontend.ActionPerformer
    -> GameObjectTypes.ActionOnGamestate
    -> Frontend.FrontendPlayingState
    -> Frontend.FrontendPlayingState
-}
updateStateWithAction :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
updateStateWithAction updateStateWithActionArg_ updateStateWithActionArg_0 updateStateWithActionArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updateStateWithAction"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "ActionPerformer" []
                          , Type.namedWith
                              [ "GameObjectTypes" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "FrontendPlayingState"
                               []
                          )
                     )
             }
        )
        [ updateStateWithActionArg_
        , updateStateWithActionArg_0
        , updateStateWithActionArg_1
        ]


{-| updateModelWithAction: 
    Frontend.ActionPerformer
    -> GameObjectTypes.ActionOnGamestate
    -> Frontend.Model
    -> Frontend.Model
-}
updateModelWithAction :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
updateModelWithAction updateModelWithActionArg_ updateModelWithActionArg_0 updateModelWithActionArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updateModelWithAction"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "ActionPerformer" []
                          , Type.namedWith
                              [ "GameObjectTypes" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.namedWith [ "Frontend" ] "Model" [])
                     )
             }
        )
        [ updateModelWithActionArg_
        , updateModelWithActionArg_0
        , updateModelWithActionArg_1
        ]


{-| updateModelWithActionFromMyself: GameObjectTypes.ActionOnGamestate -> Frontend.Model -> Frontend.Model -}
updateModelWithActionFromMyself :
    Elm.Expression -> Elm.Expression -> Elm.Expression
updateModelWithActionFromMyself updateModelWithActionFromMyselfArg_ updateModelWithActionFromMyselfArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "updateModelWithActionFromMyself"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "GameObjectTypes" ]
                              "ActionOnGamestate"
                              []
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.namedWith [ "Frontend" ] "Model" [])
                     )
             }
        )
        [ updateModelWithActionFromMyselfArg_
        , updateModelWithActionFromMyselfArg_0
        ]


{-| moveMeTowardsTargetPoint: 
    Frontend.FrontendPlayingState
    -> ( Frontend.FrontendPlayingState, Frontend.Cmd Frontend.FrontendMsg )
-}
moveMeTowardsTargetPoint : Elm.Expression -> Elm.Expression
moveMeTowardsTargetPoint moveMeTowardsTargetPointArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "moveMeTowardsTargetPoint"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "FrontendPlayingState"
                                    []
                               )
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ moveMeTowardsTargetPointArg_ ]


{-| moveMeTowardsMyTargetIfAny: Frontend.Model -> ( Frontend.Model, Frontend.Cmd Frontend.FrontendMsg ) -}
moveMeTowardsMyTargetIfAny : Elm.Expression -> Elm.Expression
moveMeTowardsMyTargetIfAny moveMeTowardsMyTargetIfAnyArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "moveMeTowardsMyTargetIfAny"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" [] ]
                          (Type.tuple
                               (Type.namedWith [ "Frontend" ] "Model" [])
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ moveMeTowardsMyTargetIfAnyArg_ ]


{-| modelUpdateTarget: Maybe GameObjectTypes.Point -> Frontend.Model -> Frontend.Model -}
modelUpdateTarget : Elm.Expression -> Elm.Expression -> Elm.Expression
modelUpdateTarget modelUpdateTargetArg_ modelUpdateTargetArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "modelUpdateTarget"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe
                              (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.namedWith [ "Frontend" ] "Model" [])
                     )
             }
        )
        [ modelUpdateTargetArg_, modelUpdateTargetArg_0 ]


{-| modelUpdateIfPlaying: 
    (Frontend.FrontendPlayingState -> Frontend.FrontendPlayingState)
    -> Frontend.Model
    -> Frontend.Model
-}
modelUpdateIfPlaying :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
modelUpdateIfPlaying modelUpdateIfPlayingArg_ modelUpdateIfPlayingArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "modelUpdateIfPlaying"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "Frontend" ]
                                    "FrontendPlayingState"
                                    []
                              ]
                              (Type.namedWith
                                 [ "Frontend" ]
                                 "FrontendPlayingState"
                                 []
                              )
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.namedWith [ "Frontend" ] "Model" [])
                     )
             }
        )
        [ Elm.functionReduced
            "modelUpdateIfPlayingUnpack"
            modelUpdateIfPlayingArg_
        , modelUpdateIfPlayingArg_0
        ]


{-| toggleMobileRelicMenu: Frontend.FrontendPlayingState -> Frontend.FrontendPlayingState -}
toggleMobileRelicMenu : Elm.Expression -> Elm.Expression
toggleMobileRelicMenu toggleMobileRelicMenuArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "toggleMobileRelicMenu"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "FrontendPlayingState"
                               []
                          )
                     )
             }
        )
        [ toggleMobileRelicMenuArg_ ]


{-| toggleDebugStuff: Frontend.FrontendPlayingState -> Frontend.FrontendPlayingState -}
toggleDebugStuff : Elm.Expression -> Elm.Expression
toggleDebugStuff toggleDebugStuffArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "toggleDebugStuff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "FrontendPlayingState"
                               []
                          )
                     )
             }
        )
        [ toggleDebugStuffArg_ ]


{-| update: 
    Frontend.FrontendMsg
    -> Frontend.Model
    -> ( Frontend.Model, Frontend.Cmd Frontend.FrontendMsg )
-}
update : Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg_ updateArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                          , Type.namedWith [ "Frontend" ] "Model" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Frontend" ] "Model" [])
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ updateArg_, updateArg_0 ]


{-| init: 
    Url.Url
    -> Browser.Navigation.Key
    -> ( Frontend.Model, Frontend.Cmd Frontend.FrontendMsg )
-}
init : Elm.Expression -> Elm.Expression -> Elm.Expression
init initArg_ initArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Url" ] "Url" []
                          , Type.namedWith [ "Browser", "Navigation" ] "Key" []
                          ]
                          (Type.tuple
                               (Type.namedWith [ "Frontend" ] "Model" [])
                               (Type.namedWith
                                    [ "Frontend" ]
                                    "Cmd"
                                    [ Type.namedWith
                                        [ "Frontend" ]
                                        "FrontendMsg"
                                        []
                                    ]
                               )
                          )
                     )
             }
        )
        [ initArg_, initArg_0 ]


{-| handleKey: Frontend.FrontendPlayingState -> String -> Frontend.FrontendMsg -}
handleKey : Elm.Expression -> String -> Elm.Expression
handleKey handleKeyArg_ handleKeyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "handleKey"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                          , Type.string
                          ]
                          (Type.namedWith [ "Frontend" ] "FrontendMsg" [])
                     )
             }
        )
        [ handleKeyArg_, Elm.string handleKeyArg_0 ]


{-| toKey: Frontend.Model -> String -> Frontend.FrontendMsg -}
toKey : Elm.Expression -> String -> Elm.Expression
toKey toKeyArg_ toKeyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "toKey"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" []
                          , Type.string
                          ]
                          (Type.namedWith [ "Frontend" ] "FrontendMsg" [])
                     )
             }
        )
        [ toKeyArg_, Elm.string toKeyArg_0 ]


{-| keyDecoder: Frontend.Model -> Json.Decode.Decoder Frontend.FrontendMsg -}
keyDecoder : Elm.Expression -> Elm.Expression
keyDecoder keyDecoderArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "keyDecoder"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" [] ]
                          (Type.namedWith
                               [ "Json", "Decode" ]
                               "Decoder"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ keyDecoderArg_ ]


{-| maybeFireEveryTick: Frontend.Model -> Frontend.Sub Frontend.FrontendMsg -}
maybeFireEveryTick : Elm.Expression -> Elm.Expression
maybeFireEveryTick maybeFireEveryTickArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "maybeFireEveryTick"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" [] ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "Sub"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ maybeFireEveryTickArg_ ]


{-| subscriptions: Frontend.Model -> Frontend.Sub Frontend.FrontendMsg -}
subscriptions : Elm.Expression -> Elm.Expression
subscriptions subscriptionsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "subscriptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Frontend" ] "Model" [] ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "Sub"
                               [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                               ]
                          )
                     )
             }
        )
        [ subscriptionsArg_ ]


{-| receiveElementSize: ({ width : Float, height : Float } -> msg) -> Frontend.Sub msg -}
receiveElementSize : (Elm.Expression -> Elm.Expression) -> Elm.Expression
receiveElementSize receiveElementSizeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Frontend" ]
             , name = "receiveElementSize"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.record
                                    [ ( "width", Type.float )
                                    , ( "height", Type.float )
                                    ]
                              ]
                              (Type.var "msg")
                          ]
                          (Type.namedWith
                               [ "Frontend" ]
                               "Sub"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "receiveElementSizeUnpack" receiveElementSizeArg_
        ]


annotation_ : { model : Type.Annotation }
annotation_ =
    { model =
        Type.alias
            moduleName_
            "Model"
            []
            (Type.namedWith [ "Frontend" ] "FrontendModel" [])
    }


call_ :
    { performClean : Elm.Expression -> Elm.Expression -> Elm.Expression
    , tryCleaning : Elm.Expression -> Elm.Expression
    , pickUpButton : Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropButton : Elm.Expression -> Elm.Expression -> Elm.Expression
    , relicCardTitle :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , heldRelicView :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , relicLevelProgressBar : Elm.Expression -> Elm.Expression
    , relicRarityBadge : Elm.Expression -> Elm.Expression
    , lockedSlotView : Elm.Expression -> Elm.Expression
    , renderRelicSlots : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderRelicList :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderDirtOnThisSquare :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderOnThisSquare : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderHeldRelics : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderDesktopRelicSidebar :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderMobileRelicDialog :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderRelicContent : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderXPMultiplier : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderExpProgress : Elm.Expression -> Elm.Expression
    , renderCleanStrength : Elm.Expression -> Elm.Expression -> Elm.Expression
    , levelProgressBar : Elm.Expression -> Elm.Expression
    , renderXP : Elm.Expression -> Elm.Expression
    , renderMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderMyHUD : Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderPlayingStateWithMe :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , renderPlayingState : Elm.Expression -> Elm.Expression
    , extractMyself : Elm.Expression -> Elm.Expression
    , renderModel : Elm.Expression -> Elm.Expression
    , view : Elm.Expression -> Elm.Expression
    , initFrontendPlayingState : Elm.Expression -> Elm.Expression
    , updatePlayingStateWithBackendStateDump :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateFromBackend : Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateCameraPositionWithPlayer :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateCameraPosition : Elm.Expression -> Elm.Expression
    , updateStateWithAction :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateModelWithAction :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateModelWithActionFromMyself :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , moveMeTowardsTargetPoint : Elm.Expression -> Elm.Expression
    , moveMeTowardsMyTargetIfAny : Elm.Expression -> Elm.Expression
    , modelUpdateTarget : Elm.Expression -> Elm.Expression -> Elm.Expression
    , modelUpdateIfPlaying : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toggleMobileRelicMenu : Elm.Expression -> Elm.Expression
    , toggleDebugStuff : Elm.Expression -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression -> Elm.Expression
    , init : Elm.Expression -> Elm.Expression -> Elm.Expression
    , handleKey : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toKey : Elm.Expression -> Elm.Expression -> Elm.Expression
    , keyDecoder : Elm.Expression -> Elm.Expression
    , maybeFireEveryTick : Elm.Expression -> Elm.Expression
    , subscriptions : Elm.Expression -> Elm.Expression
    , receiveElementSize : Elm.Expression -> Elm.Expression
    }
call_ =
    { performClean =
        \performCleanArg_ performCleanArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "performClean"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  , Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "ActionOnGamestate"
                                       []
                                  )
                             )
                     }
                )
                [ performCleanArg_, performCleanArg_0 ]
    , tryCleaning =
        \tryCleaningArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "tryCleaning"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "GameObjectTypes" ]
                                       "ActionOnGamestate"
                                       []
                                  )
                             )
                     }
                )
                [ tryCleaningArg_ ]
    , pickUpButton =
        \pickUpButtonArg_ pickUpButtonArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "pickUpButton"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonId"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ pickUpButtonArg_, pickUpButtonArg_0 ]
    , dropButton =
        \dropButtonArg_ dropButtonArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "dropButton"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "RelicId"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonId"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ dropButtonArg_, dropButtonArg_0 ]
    , relicCardTitle =
        \relicCardTitleArg_ relicCardTitleArg_0 relicCardTitleArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "relicCardTitle"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "RelicData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ relicCardTitleArg_, relicCardTitleArg_0, relicCardTitleArg_1 ]
    , heldRelicView =
        \heldRelicViewArg_ heldRelicViewArg_0 heldRelicViewArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "heldRelicView"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "RelicData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ heldRelicViewArg_, heldRelicViewArg_0, heldRelicViewArg_1 ]
    , relicLevelProgressBar =
        \relicLevelProgressBarArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "relicLevelProgressBar"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "RelicData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ relicLevelProgressBarArg_ ]
    , relicRarityBadge =
        \relicRarityBadgeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "relicRarityBadge"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "RelicRarity"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ relicRarityBadgeArg_ ]
    , lockedSlotView =
        \lockedSlotViewArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "lockedSlotView"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ lockedSlotViewArg_ ]
    , renderRelicSlots =
        \renderRelicSlotsArg_ renderRelicSlotsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderRelicSlots"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  , Type.int
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Html" ]
                                            "Html"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ renderRelicSlotsArg_, renderRelicSlotsArg_0 ]
    , renderRelicList =
        \renderRelicListArg_ renderRelicListArg_0 renderRelicListArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderRelicList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "GameObjectTypes" ]
                                         "RelicData"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Html" ]
                                            "Html"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ renderRelicListArg_
                , renderRelicListArg_0
                , renderRelicListArg_1
                ]
    , renderDirtOnThisSquare =
        \renderDirtOnThisSquareArg_ renderDirtOnThisSquareArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderDirtOnThisSquare"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "DirtData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderDirtOnThisSquareArg_, renderDirtOnThisSquareArg_0 ]
    , renderOnThisSquare =
        \renderOnThisSquareArg_ renderOnThisSquareArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderOnThisSquare"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderOnThisSquareArg_, renderOnThisSquareArg_0 ]
    , renderHeldRelics =
        \renderHeldRelicsArg_ renderHeldRelicsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderHeldRelics"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderHeldRelicsArg_, renderHeldRelicsArg_0 ]
    , renderDesktopRelicSidebar =
        \renderDesktopRelicSidebarArg_ renderDesktopRelicSidebarArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderDesktopRelicSidebar"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderDesktopRelicSidebarArg_
                , renderDesktopRelicSidebarArg_0
                ]
    , renderMobileRelicDialog =
        \renderMobileRelicDialogArg_ renderMobileRelicDialogArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderMobileRelicDialog"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderMobileRelicDialogArg_, renderMobileRelicDialogArg_0 ]
    , renderRelicContent =
        \renderRelicContentArg_ renderRelicContentArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderRelicContent"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.list
                                       (Type.namedWith
                                            [ "Html" ]
                                            "Html"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ renderRelicContentArg_, renderRelicContentArg_0 ]
    , renderXPMultiplier =
        \renderXPMultiplierArg_ renderXPMultiplierArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderXPMultiplier"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderXPMultiplierArg_, renderXPMultiplierArg_0 ]
    , renderExpProgress =
        \renderExpProgressArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderExpProgress"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderExpProgressArg_ ]
    , renderCleanStrength =
        \renderCleanStrengthArg_ renderCleanStrengthArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderCleanStrength"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderCleanStrengthArg_, renderCleanStrengthArg_0 ]
    , levelProgressBar =
        \levelProgressBarArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "levelProgressBar"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ levelProgressBarArg_ ]
    , renderXP =
        \renderXPArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderXP"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderXPArg_ ]
    , renderMap =
        \renderMapArg_ renderMapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderMap"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderMapArg_, renderMapArg_0 ]
    , renderMyHUD =
        \renderMyHUDArg_ renderMyHUDArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderMyHUD"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderMyHUDArg_, renderMyHUDArg_0 ]
    , renderPlayingStateWithMe =
        \renderPlayingStateWithMeArg_ renderPlayingStateWithMeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderPlayingStateWithMe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderPlayingStateWithMeArg_, renderPlayingStateWithMeArg_0 ]
    , renderPlayingState =
        \renderPlayingStateArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderPlayingState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderPlayingStateArg_ ]
    , extractMyself =
        \extractMyselfArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "extractMyself"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "GameObjectTypes" ]
                                            "PersonData"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ extractMyselfArg_ ]
    , renderModel =
        \renderModelArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "renderModel"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" [] ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ renderModelArg_ ]
    , view =
        \viewArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "view"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" [] ]
                                  (Type.namedWith
                                       [ "Browser" ]
                                       "Document"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ viewArg_ ]
    , initFrontendPlayingState =
        \initFrontendPlayingStateArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "initFrontendPlayingState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "BackendToFrontendState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendPlayingState"
                                       []
                                  )
                             )
                     }
                )
                [ initFrontendPlayingStateArg_ ]
    , updatePlayingStateWithBackendStateDump =
        \updatePlayingStateWithBackendStateDumpArg_ updatePlayingStateWithBackendStateDumpArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updatePlayingStateWithBackendStateDump"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "BackendToFrontendState"
                                      []
                                  , Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendPlayingState"
                                       []
                                  )
                             )
                     }
                )
                [ updatePlayingStateWithBackendStateDumpArg_
                , updatePlayingStateWithBackendStateDumpArg_0
                ]
    , updateFromBackend =
        \updateFromBackendArg_ updateFromBackendArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updateFromBackend"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "ToFrontend"
                                      []
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Frontend" ] "Model" []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ updateFromBackendArg_, updateFromBackendArg_0 ]
    , updateCameraPositionWithPlayer =
        \updateCameraPositionWithPlayerArg_ updateCameraPositionWithPlayerArg_0 updateCameraPositionWithPlayerArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updateCameraPositionWithPlayer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "PersonData"
                                      []
                                  , Type.record
                                      [ ( "width", Type.float )
                                      , ( "height", Type.float )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendPlayingState"
                                       []
                                  )
                             )
                     }
                )
                [ updateCameraPositionWithPlayerArg_
                , updateCameraPositionWithPlayerArg_0
                , updateCameraPositionWithPlayerArg_1
                ]
    , updateCameraPosition =
        \updateCameraPositionArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updateCameraPosition"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendPlayingState"
                                       []
                                  )
                             )
                     }
                )
                [ updateCameraPositionArg_ ]
    , updateStateWithAction =
        \updateStateWithActionArg_ updateStateWithActionArg_0 updateStateWithActionArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updateStateWithAction"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "ActionPerformer"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendPlayingState"
                                       []
                                  )
                             )
                     }
                )
                [ updateStateWithActionArg_
                , updateStateWithActionArg_0
                , updateStateWithActionArg_1
                ]
    , updateModelWithAction =
        \updateModelWithActionArg_ updateModelWithActionArg_0 updateModelWithActionArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updateModelWithAction"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "ActionPerformer"
                                      []
                                  , Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.namedWith [ "Frontend" ] "Model" [])
                             )
                     }
                )
                [ updateModelWithActionArg_
                , updateModelWithActionArg_0
                , updateModelWithActionArg_1
                ]
    , updateModelWithActionFromMyself =
        \updateModelWithActionFromMyselfArg_ updateModelWithActionFromMyselfArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "updateModelWithActionFromMyself"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "GameObjectTypes" ]
                                      "ActionOnGamestate"
                                      []
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.namedWith [ "Frontend" ] "Model" [])
                             )
                     }
                )
                [ updateModelWithActionFromMyselfArg_
                , updateModelWithActionFromMyselfArg_0
                ]
    , moveMeTowardsTargetPoint =
        \moveMeTowardsTargetPointArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "moveMeTowardsTargetPoint"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "FrontendPlayingState"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ moveMeTowardsTargetPointArg_ ]
    , moveMeTowardsMyTargetIfAny =
        \moveMeTowardsMyTargetIfAnyArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "moveMeTowardsMyTargetIfAny"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" [] ]
                                  (Type.tuple
                                       (Type.namedWith [ "Frontend" ] "Model" []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ moveMeTowardsMyTargetIfAnyArg_ ]
    , modelUpdateTarget =
        \modelUpdateTargetArg_ modelUpdateTargetArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "modelUpdateTarget"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe
                                      (Type.namedWith
                                         [ "GameObjectTypes" ]
                                         "Point"
                                         []
                                      )
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.namedWith [ "Frontend" ] "Model" [])
                             )
                     }
                )
                [ modelUpdateTargetArg_, modelUpdateTargetArg_0 ]
    , modelUpdateIfPlaying =
        \modelUpdateIfPlayingArg_ modelUpdateIfPlayingArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "modelUpdateIfPlaying"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "Frontend" ]
                                            "FrontendPlayingState"
                                            []
                                      ]
                                      (Type.namedWith
                                         [ "Frontend" ]
                                         "FrontendPlayingState"
                                         []
                                      )
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.namedWith [ "Frontend" ] "Model" [])
                             )
                     }
                )
                [ modelUpdateIfPlayingArg_, modelUpdateIfPlayingArg_0 ]
    , toggleMobileRelicMenu =
        \toggleMobileRelicMenuArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "toggleMobileRelicMenu"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendPlayingState"
                                       []
                                  )
                             )
                     }
                )
                [ toggleMobileRelicMenuArg_ ]
    , toggleDebugStuff =
        \toggleDebugStuffArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "toggleDebugStuff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendPlayingState"
                                       []
                                  )
                             )
                     }
                )
                [ toggleDebugStuffArg_ ]
    , update =
        \updateArg_ updateArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendMsg"
                                      []
                                  , Type.namedWith [ "Frontend" ] "Model" []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Frontend" ] "Model" []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ updateArg_, updateArg_0 ]
    , init =
        \initArg_ initArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Url" ] "Url" []
                                  , Type.namedWith
                                      [ "Browser", "Navigation" ]
                                      "Key"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith [ "Frontend" ] "Model" []
                                       )
                                       (Type.namedWith
                                            [ "Frontend" ]
                                            "Cmd"
                                            [ Type.namedWith
                                                [ "Frontend" ]
                                                "FrontendMsg"
                                                []
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ initArg_, initArg_0 ]
    , handleKey =
        \handleKeyArg_ handleKeyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "handleKey"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Frontend" ]
                                      "FrontendPlayingState"
                                      []
                                  , Type.string
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                  )
                             )
                     }
                )
                [ handleKeyArg_, handleKeyArg_0 ]
    , toKey =
        \toKeyArg_ toKeyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "toKey"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" []
                                  , Type.string
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                  )
                             )
                     }
                )
                [ toKeyArg_, toKeyArg_0 ]
    , keyDecoder =
        \keyDecoderArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "keyDecoder"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" [] ]
                                  (Type.namedWith
                                       [ "Json", "Decode" ]
                                       "Decoder"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ keyDecoderArg_ ]
    , maybeFireEveryTick =
        \maybeFireEveryTickArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "maybeFireEveryTick"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" [] ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "Sub"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ maybeFireEveryTickArg_ ]
    , subscriptions =
        \subscriptionsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "subscriptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Frontend" ] "Model" [] ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "Sub"
                                       [ Type.namedWith
                                           [ "Frontend" ]
                                           "FrontendMsg"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ subscriptionsArg_ ]
    , receiveElementSize =
        \receiveElementSizeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Frontend" ]
                     , name = "receiveElementSize"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.record
                                            [ ( "width", Type.float )
                                            , ( "height", Type.float )
                                            ]
                                      ]
                                      (Type.var "msg")
                                  ]
                                  (Type.namedWith
                                       [ "Frontend" ]
                                       "Sub"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ receiveElementSizeArg_ ]
    }


values_ :
    { performClean : Elm.Expression
    , tryCleaning : Elm.Expression
    , pickUpButton : Elm.Expression
    , dropButton : Elm.Expression
    , relicCardTitle : Elm.Expression
    , heldRelicView : Elm.Expression
    , relicLevelProgressBar : Elm.Expression
    , relicRarityBadge : Elm.Expression
    , lockedSlotView : Elm.Expression
    , availableRelicView : Elm.Expression
    , renderRelicSlots : Elm.Expression
    , renderRelicList : Elm.Expression
    , renderDirtOnThisSquare : Elm.Expression
    , renderOnThisSquare : Elm.Expression
    , renderHeldRelics : Elm.Expression
    , renderDesktopRelicSidebar : Elm.Expression
    , renderMobileRelicDialog : Elm.Expression
    , renderMobileHamburgerButton : Elm.Expression
    , renderRelicContent : Elm.Expression
    , renderXPMultiplier : Elm.Expression
    , renderExpProgress : Elm.Expression
    , renderCleanStrength : Elm.Expression
    , levelProgressBar : Elm.Expression
    , renderXP : Elm.Expression
    , renderMap : Elm.Expression
    , renderMyHUD : Elm.Expression
    , renderPlayingStateWithMe : Elm.Expression
    , renderPlayingState : Elm.Expression
    , extractMyself : Elm.Expression
    , renderModel : Elm.Expression
    , view : Elm.Expression
    , initFrontendPlayingState : Elm.Expression
    , updatePlayingStateWithBackendStateDump : Elm.Expression
    , updateFromBackend : Elm.Expression
    , updateCameraPositionWithPlayer : Elm.Expression
    , updateCameraPosition : Elm.Expression
    , updateStateWithAction : Elm.Expression
    , updateModelWithAction : Elm.Expression
    , updateModelWithActionFromMyself : Elm.Expression
    , moveMeTowardsTargetPoint : Elm.Expression
    , moveMeTowardsMyTargetIfAny : Elm.Expression
    , modelUpdateTarget : Elm.Expression
    , modelUpdateIfPlaying : Elm.Expression
    , toggleMobileRelicMenu : Elm.Expression
    , toggleDebugStuff : Elm.Expression
    , update : Elm.Expression
    , init : Elm.Expression
    , handleKey : Elm.Expression
    , toKey : Elm.Expression
    , keyDecoder : Elm.Expression
    , maybeFireEveryTick : Elm.Expression
    , subscriptions : Elm.Expression
    , receiveElementSize : Elm.Expression
    }
values_ =
    { performClean =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "performClean"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         , Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "GameObjectTypes" ]
                              "ActionOnGamestate"
                              []
                         )
                    )
            }
    , tryCleaning =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "tryCleaning"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "GameObjectTypes" ]
                              "ActionOnGamestate"
                              []
                         )
                    )
            }
    , pickUpButton =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "pickUpButton"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "RelicId" []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonId" []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , dropButton =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "dropButton"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "RelicId" []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonId" []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , relicCardTitle =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "relicCardTitle"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         , Type.namedWith [ "GameObjectTypes" ] "RelicData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , heldRelicView =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "heldRelicView"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         , Type.namedWith [ "GameObjectTypes" ] "RelicData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , relicLevelProgressBar =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "relicLevelProgressBar"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "RelicData" [] ]
                         (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                    )
            }
    , relicRarityBadge =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "relicRarityBadge"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "RelicRarity" []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "Html"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , lockedSlotView =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "lockedSlotView"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , availableRelicView =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "availableRelicView"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Html" ]
                         "Html"
                         [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                    )
            }
    , renderRelicSlots =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderRelicSlots"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         , Type.int
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "Html" ]
                                   "Html"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , renderRelicList =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderRelicList"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "GameObjectTypes" ]
                                "RelicData"
                                []
                             )
                         , Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "Html" ]
                                   "Html"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , renderDirtOnThisSquare =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderDirtOnThisSquare"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         , Type.namedWith [ "GameObjectTypes" ] "DirtData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderOnThisSquare =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderOnThisSquare"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderHeldRelics =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderHeldRelics"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderDesktopRelicSidebar =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderDesktopRelicSidebar"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderMobileRelicDialog =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderMobileRelicDialog"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderMobileHamburgerButton =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderMobileHamburgerButton"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Html" ]
                         "Html"
                         [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                    )
            }
    , renderRelicContent =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderRelicContent"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.list
                              (Type.namedWith
                                   [ "Html" ]
                                   "Html"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , renderXPMultiplier =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderXPMultiplier"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderExpProgress =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderExpProgress"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderCleanStrength =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderCleanStrength"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , levelProgressBar =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "levelProgressBar"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderXP =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderXP"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderMap =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderMap"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderMyHUD =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderMyHUD"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderPlayingStateWithMe =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderPlayingStateWithMe"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , renderPlayingState =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderPlayingState"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , extractMyself =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "extractMyself"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "GameObjectTypes" ]
                                   "PersonData"
                                   []
                              )
                         )
                    )
            }
    , renderModel =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "renderModel"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" [] ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , view =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "view"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" [] ]
                         (Type.namedWith
                              [ "Browser" ]
                              "Document"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , initFrontendPlayingState =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "initFrontendPlayingState"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "BackendToFrontendState"
                             []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                         )
                    )
            }
    , updatePlayingStateWithBackendStateDump =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updatePlayingStateWithBackendStateDump"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "BackendToFrontendState"
                             []
                         , Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                         )
                    )
            }
    , updateFromBackend =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updateFromBackend"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "ToFrontend" []
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Frontend" ] "Model" [])
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , updateCameraPositionWithPlayer =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updateCameraPositionWithPlayer"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.namedWith [ "GameObjectTypes" ] "PersonData" []
                         , Type.record
                             [ ( "width", Type.float )
                             , ( "height", Type.float )
                             ]
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                         )
                    )
            }
    , updateCameraPosition =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updateCameraPosition"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                         )
                    )
            }
    , updateStateWithAction =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updateStateWithAction"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "ActionPerformer" []
                         , Type.namedWith
                             [ "GameObjectTypes" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                         )
                    )
            }
    , updateModelWithAction =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updateModelWithAction"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "ActionPerformer" []
                         , Type.namedWith
                             [ "GameObjectTypes" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.namedWith [ "Frontend" ] "Model" [])
                    )
            }
    , updateModelWithActionFromMyself =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "updateModelWithActionFromMyself"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "GameObjectTypes" ]
                             "ActionOnGamestate"
                             []
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.namedWith [ "Frontend" ] "Model" [])
                    )
            }
    , moveMeTowardsTargetPoint =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "moveMeTowardsTargetPoint"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "FrontendPlayingState"
                                   []
                              )
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , moveMeTowardsMyTargetIfAny =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "moveMeTowardsMyTargetIfAny"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" [] ]
                         (Type.tuple
                              (Type.namedWith [ "Frontend" ] "Model" [])
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , modelUpdateTarget =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "modelUpdateTarget"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe
                             (Type.namedWith [ "GameObjectTypes" ] "Point" [])
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.namedWith [ "Frontend" ] "Model" [])
                    )
            }
    , modelUpdateIfPlaying =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "modelUpdateIfPlaying"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "Frontend" ]
                                   "FrontendPlayingState"
                                   []
                             ]
                             (Type.namedWith
                                [ "Frontend" ]
                                "FrontendPlayingState"
                                []
                             )
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.namedWith [ "Frontend" ] "Model" [])
                    )
            }
    , toggleMobileRelicMenu =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "toggleMobileRelicMenu"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                         )
                    )
            }
    , toggleDebugStuff =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "toggleDebugStuff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "FrontendPlayingState"
                              []
                         )
                    )
            }
    , update =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "FrontendMsg" []
                         , Type.namedWith [ "Frontend" ] "Model" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Frontend" ] "Model" [])
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , init =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Url" ] "Url" []
                         , Type.namedWith [ "Browser", "Navigation" ] "Key" []
                         ]
                         (Type.tuple
                              (Type.namedWith [ "Frontend" ] "Model" [])
                              (Type.namedWith
                                   [ "Frontend" ]
                                   "Cmd"
                                   [ Type.namedWith
                                       [ "Frontend" ]
                                       "FrontendMsg"
                                       []
                                   ]
                              )
                         )
                    )
            }
    , handleKey =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "handleKey"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Frontend" ]
                             "FrontendPlayingState"
                             []
                         , Type.string
                         ]
                         (Type.namedWith [ "Frontend" ] "FrontendMsg" [])
                    )
            }
    , toKey =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "toKey"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" []
                         , Type.string
                         ]
                         (Type.namedWith [ "Frontend" ] "FrontendMsg" [])
                    )
            }
    , keyDecoder =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "keyDecoder"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" [] ]
                         (Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , maybeFireEveryTick =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "maybeFireEveryTick"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" [] ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "Sub"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , subscriptions =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "subscriptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Frontend" ] "Model" [] ]
                         (Type.namedWith
                              [ "Frontend" ]
                              "Sub"
                              [ Type.namedWith [ "Frontend" ] "FrontendMsg" [] ]
                         )
                    )
            }
    , receiveElementSize =
        Elm.value
            { importFrom = [ "Frontend" ]
            , name = "receiveElementSize"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.record
                                   [ ( "width", Type.float )
                                   , ( "height", Type.float )
                                   ]
                             ]
                             (Type.var "msg")
                         ]
                         (Type.namedWith [ "Frontend" ] "Sub" [ Type.var "msg" ]
                         )
                    )
            }
    }