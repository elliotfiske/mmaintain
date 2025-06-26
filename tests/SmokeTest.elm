module SmokeTest exposing (appTests, main)

import Backend
import Effect.Browser.Dom as Dom
import Effect.Lamdera
import Effect.Test exposing (HttpResponse(..))
import Effect.Time
import Frontend
import Test exposing (describe)
import Test.Html.Query
import Test.Html.Selector
import Types exposing (BackendModel, BackendMsg, FrontendModel, FrontendMsg, ToBackend, ToFrontend)
import Url exposing (Url)


main : Program () (Effect.Test.Model ToBackend FrontendMsg FrontendModel ToFrontend BackendMsg BackendModel) (Effect.Test.Msg ToBackend FrontendMsg FrontendModel ToFrontend BackendMsg BackendModel)
main =
    Effect.Test.viewer tests


tests : List (Effect.Test.EndToEndTest ToBackend FrontendMsg FrontendModel ToFrontend BackendMsg BackendModel)
tests =
    [ Effect.Test.start
        "Check basic render functionality"
        (Effect.Time.millisToPosix 0)
        config
        [ Effect.Test.connectFrontend
            1000
            (Effect.Lamdera.sessionIdFromString "sessionId0")
            "/"
            { width = 800, height = 600 }
            (\client1 ->
                [ client1.checkView 100 (Test.Html.Query.has [ Test.Html.Selector.exactText "THE PARK IS CLEAN!!!!" ])
                ]
            )
        ]
    , Effect.Test.start
        "Check client desync behavior"
        (Effect.Time.millisToPosix 0)
        config
        [ Effect.Test.connectFrontend
            1000
            (Effect.Lamdera.sessionIdFromString "sessionId0")
            "/"
            { width = 800, height = 600 }
            (\client1 ->
                [ client1.click 100 (Dom.id "add-dirt-button")
                , client1.keyDown 0 (Dom.id "main-map") "`" []
                , client1.keyDown 0 (Dom.id "main-map") "r" []
                , client1.keyDown 0 (Dom.id "main-map") "`" []
                , Effect.Test.connectFrontend
                    0
                    (Effect.Lamdera.sessionIdFromString "sessionId1")
                    "/"
                    { width = 800, height = 600 }
                    (\client2 ->
                        [ -- Both clients should see the relic initially
                          client1.checkView 100 (Test.Html.Query.has [ Test.Html.Selector.class "sprite", Test.Html.Selector.class "relic" ])
                        , client2.checkView 0 (Test.Html.Query.has [ Test.Html.Selector.class "sprite", Test.Html.Selector.class "relic" ])

                        -- Both clients move to the relic position (1 space up and left from start)
                        , client1.keyDown 0 (Dom.id "main-map") "ArrowLeft" []
                        , client1.keyDown 0 (Dom.id "main-map") "ArrowUp" []
                        , client2.keyDown 0 (Dom.id "main-map") "ArrowLeft" []
                        , client2.keyDown 0 (Dom.id "main-map") "ArrowUp" []

                        -- Both clients attempt to pick up the relic at the same time (spacebar)
                        , client1.keyDown 300 (Dom.id "main-map") " " []
                        , client2.keyDown 0 (Dom.id "main-map") " " []

                        -- Both clients should now see the relic in their inventory (due to optimistic update)
                        , client1.checkView 0 (Test.Html.Query.has [ Test.Html.Selector.id "drop-button" ])
                        , client2.checkView 0 (Test.Html.Query.has [ Test.Html.Selector.id "drop-button" ])

                        -- Wait for backend to process actions and resolve the conflict
                        , Effect.Test.andThen 1000
                            (\_ ->
                                [ -- The first client should now have the relic in their inventory
                                  client1.checkView 0
                                    (Test.Html.Query.has [ Test.Html.Selector.id "drop-button" ])

                                -- The second client should not have the relic in their inventory
                                , client2.checkView 0 (Test.Html.Query.hasNot [ Test.Html.Selector.id "drop-button" ])

                                -- The relic should no longer be visible on the map for either client
                                , client1.checkView 0 (Test.Html.Query.hasNot [ Test.Html.Selector.class "sprite", Test.Html.Selector.class "relic" ])
                                , client2.checkView 0 (Test.Html.Query.hasNot [ Test.Html.Selector.class "sprite", Test.Html.Selector.class "relic" ])

                                -- The first client should have a relic in their inventory
                                , client1.checkView 0 (Test.Html.Query.has [ Test.Html.Selector.id "drop-button" ])
                                ]
                            )
                        ]
                    )
                ]
            )
        ]
    ]


safeUrl : Url
safeUrl =
    { protocol = Url.Https
    , host = "park.lamdera.app"
    , port_ = Nothing
    , path = "/"
    , query = Nothing
    , fragment = Nothing
    }


config : Effect.Test.Config ToBackend FrontendMsg FrontendModel ToFrontend BackendMsg BackendModel
config =
    { frontendApp = Frontend.app_
    , backendApp = Backend.app_
    , handleHttpRequest = always NetworkErrorResponse
    , handlePortToJs = always Nothing
    , handleFileUpload = always Effect.Test.UnhandledFileUpload
    , handleMultipleFilesUpload = always Effect.Test.UnhandledMultiFileUpload
    , domain = safeUrl
    }


appTests =
    describe "App tests" (List.map Effect.Test.toTest tests)



{-

   Example test:


   unsafeUrl : Url
   unsafeUrl =
       case Url.fromString "https://chat-app.lamdera.app" of
           Just url ->
               url

           Nothing ->
               Debug.todo "Invalid url"


   config : Effect.Test.Config ToBackend FrontendMsg FrontendModel ToFrontend BackendMsg BackendModel
   config =
       { frontendApp = Frontend.app_
       , backendApp = Backend.app_
       , handleHttpRequest = always NetworkErrorResponse
       , handlePortToJs = always Nothing
       , handleFileUpload = always CancelFileUpload
       , handleMultipleFilesUpload = always CancelMultipleFilesUpload
       , domain = unsafeUrl
       }


   tests : List (Effect.Test.EndToEndTest ToBackend FrontendMsg FrontendModel ToFrontend BackendMsg BackendModel)
   tests =
       [ Effect.Test.start
           "Clients stay in sync"
           (Effect.Time.millisToPosix 0)
           config
           [ Effect.Test.connectFrontend
               100
               (Effect.Lamdera.sessionIdFromString "sessionId0")
               "/"
               { width = 800, height = 600 }
               (\client1 ->
                   [ client1.click 100 (Dom.id "plusOne")
                   , client1.click 100 (Dom.id "plusOne")
                   , client1.click 100 (Dom.id "plusOne")
                   , client1.checkView 100 (Test.Html.Query.has [ Test.Html.Selector.exactText "3" ])
                   , Effect.Test.connectFrontend
                       100
                       (Effect.Lamdera.sessionIdFromString "sessionId1")
                       "/"
                       { width = 800, height = 600 }
                       (\client2 ->
                           [ client2.checkView 100 (Test.Html.Query.has [ Test.Html.Selector.exactText "3" ])
                           , client2.click 100 (Dom.id "minusOne")
                           , client1.checkView 100 (Test.Html.Query.has [ Test.Html.Selector.exactText "2" ])
                           ]
                       )
                   ]
               )
           ]
       ]





-}
