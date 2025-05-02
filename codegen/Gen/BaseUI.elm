module Gen.BaseUI exposing
    ( moduleName_, progressBar, simpleTitle, basicDialog, dialog, card
    , call_, values_
    )

{-|
# Generated bindings for BaseUI

@docs moduleName_, progressBar, simpleTitle, basicDialog, dialog, card
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BaseUI" ]


{-| progressBar: Int -> Html.Html msg -}
progressBar : Int -> Elm.Expression
progressBar progressBarArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BaseUI" ]
             , name = "progressBar"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.int progressBarArg_ ]


{-| simpleTitle: String -> Html.Html msg -}
simpleTitle : String -> Elm.Expression
simpleTitle simpleTitleArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BaseUI" ]
             , name = "simpleTitle"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.string simpleTitleArg_ ]


{-| basicDialog: Html.Html msg -> Html.Html msg -}
basicDialog : Elm.Expression -> Elm.Expression
basicDialog basicDialogArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BaseUI" ]
             , name = "basicDialog"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ]
                          ]
                          (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                     )
             }
        )
        [ basicDialogArg_ ]


{-| dialog: BaseUI.DialogArgs msg -> Html.Html msg -}
dialog : Elm.Expression -> Elm.Expression
dialog dialogArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BaseUI" ]
             , name = "dialog"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BaseUI" ]
                              "DialogArgs"
                              [ Type.var "msg" ]
                          ]
                          (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                     )
             }
        )
        [ dialogArg_ ]


{-| card: String -> List (Html.Html msg) -> List (Html.Html msg) -> Html.Html msg -}
card : String -> List Elm.Expression -> List Elm.Expression -> Elm.Expression
card cardArg_ cardArg_0 cardArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BaseUI" ]
             , name = "card"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list
                              (Type.namedWith
                                 [ "Html" ]
                                 "Html"
                                 [ Type.var "msg" ]
                              )
                          , Type.list
                              (Type.namedWith
                                 [ "Html" ]
                                 "Html"
                                 [ Type.var "msg" ]
                              )
                          ]
                          (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.string cardArg_, Elm.list cardArg_0, Elm.list cardArg_1 ]


call_ :
    { progressBar : Elm.Expression -> Elm.Expression
    , simpleTitle : Elm.Expression -> Elm.Expression
    , basicDialog : Elm.Expression -> Elm.Expression
    , dialog : Elm.Expression -> Elm.Expression
    , card :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { progressBar =
        \progressBarArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BaseUI" ]
                     , name = "progressBar"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ progressBarArg_ ]
    , simpleTitle =
        \simpleTitleArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BaseUI" ]
                     , name = "simpleTitle"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ simpleTitleArg_ ]
    , basicDialog =
        \basicDialogArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BaseUI" ]
                     , name = "basicDialog"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Html" ]
                                      "Html"
                                      [ Type.var "msg" ]
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ basicDialogArg_ ]
    , dialog =
        \dialogArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BaseUI" ]
                     , name = "dialog"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BaseUI" ]
                                      "DialogArgs"
                                      [ Type.var "msg" ]
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ dialogArg_ ]
    , card =
        \cardArg_ cardArg_0 cardArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BaseUI" ]
                     , name = "card"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list
                                      (Type.namedWith
                                         [ "Html" ]
                                         "Html"
                                         [ Type.var "msg" ]
                                      )
                                  , Type.list
                                      (Type.namedWith
                                         [ "Html" ]
                                         "Html"
                                         [ Type.var "msg" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ cardArg_, cardArg_0, cardArg_1 ]
    }


values_ :
    { progressBar : Elm.Expression
    , simpleTitle : Elm.Expression
    , basicDialog : Elm.Expression
    , dialog : Elm.Expression
    , card : Elm.Expression
    }
values_ =
    { progressBar =
        Elm.value
            { importFrom = [ "BaseUI" ]
            , name = "progressBar"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                    )
            }
    , simpleTitle =
        Elm.value
            { importFrom = [ "BaseUI" ]
            , name = "simpleTitle"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                    )
            }
    , basicDialog =
        Elm.value
            { importFrom = [ "BaseUI" ]
            , name = "basicDialog"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ] ]
                         (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                    )
            }
    , dialog =
        Elm.value
            { importFrom = [ "BaseUI" ]
            , name = "dialog"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BaseUI" ]
                             "DialogArgs"
                             [ Type.var "msg" ]
                         ]
                         (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                    )
            }
    , card =
        Elm.value
            { importFrom = [ "BaseUI" ]
            , name = "card"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list
                             (Type.namedWith
                                [ "Html" ]
                                "Html"
                                [ Type.var "msg" ]
                             )
                         , Type.list
                             (Type.namedWith
                                [ "Html" ]
                                "Html"
                                [ Type.var "msg" ]
                             )
                         ]
                         (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                    )
            }
    }