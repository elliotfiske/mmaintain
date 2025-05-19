module Types exposing (..)

import Dict exposing (Dict)
import Effect.Browser exposing (UrlRequest)
import Effect.Browser.Navigation exposing (Key)
import Effect.Lamdera exposing (ClientId, SessionId)
import Effect.Time exposing (Posix)
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import Json.Decode as Decode
import SeqDict exposing (SeqDict)
import Url exposing (Url)



-- TODO: could probably generate Real*Dict with other generated dictionary code


type alias RealPersonDict =
    SeqDict PersonId PersonData


type alias RealRelicDict =
    SeqDict RelicId RelicData


type alias PersonWithRelics =
    { person : PersonData, heldRelics : List RelicData }


type alias RelicsByLocation =
    SeqDict GameObjectTypes.RelicPosition RealRelicDict


type alias DirtByLocation =
    SeqDict Point DirtData


type alias GameState =
    { personDict : SeqDict PersonId PersonData
    , relicsByLocation : RelicsByLocation
    , dirtByLocation : DirtByLocation
    }


type alias FrontendModel =
    { key : Effect.Browser.Navigation.Key
    , state : FrontendState
    }


type alias FrontendPlayingState =
    { backendConfirmedGameState : GameState
    , optimisticActions : List ActionOnGamestate
    , myId : PersonId
    , targetPosition : Maybe Point
    , showingDebugStuff : Bool
    , mapSize : Maybe { width : Float, height : Float }
    , cameraPosition : Point
    , mobileRelicMenuOpen : Bool
    }


type alias BackendToFrontendState =
    { gameState : GameState, myId : PersonId }


type FrontendState
    = Loading
    | Playing FrontendPlayingState
    | Error String


type alias BackendModel =
    { gameState : GameState
    , connectedClients : List ClientId
    , sessionIdToPersonId : SeqDict SessionId PersonId
    , biggestId : Int
    , bigRandom : Int
    }


type BackendTrigger
    = NoOpBackendTrigger
    | ClearedPollution PersonId DirtData
    | BatchTrigger (List BackendTrigger)


type FrontendMsg
    = UrlClicked Effect.Browser.UrlRequest
    | UrlChanged Url
    | PerformAction ActionOnGamestate
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ActivatedRelic PersonId RelicId
    | ClickTarget Point
    | Tick Effect.Time.Posix
    | ToggleDebugStuff
    | CloseModals
    | ReceivedMapSize Decode.Value
    | ToggleMobileRelicMenu
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend
    | ClientPerformsAction ActionOnGamestate
    | PleaseMakeMeDirty
    | PleaseGenerateRelic
    | PleaseActivateRelic PersonId RelicId


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected SessionId ClientId
    | ClientDisconnected SessionId ClientId


type ActionPerformer
    = Client PersonId
    | Server


type ToFrontend
    = NoOpToFrontend
    | OtherClientPerformedAction ActionPerformer ActionOnGamestate
    | UpdateFullState BackendToFrontendState
