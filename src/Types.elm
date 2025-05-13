module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import Lamdera exposing (ClientId, SessionId)
import SeqDict exposing (SeqDict)
import Time exposing (Posix)
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
    { key : Key
    , state : FrontendState
    }


type alias FrontendPlayingState =
    { gameState : GameState
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
    , sessionIdToPersonId : Dict SessionId PersonId
    , biggestId : Int
    , bigRandom : Int
    }


type BackendTrigger
    = NoOpBackendTrigger
    | ClearedPollution PersonId DirtData
    | BatchTrigger (List BackendTrigger)
      -- Player is out of sync with the backend and needs the full state sent down
    | NuhUh PersonId


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | PerformAction ActionOnGamestate
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ActivatedRelic PersonId RelicId
    | ClickTarget Point
    | Tick Posix
    | ToggleDebugStuff
    | CloseModals
    | ReceivedMapSize { width : Float, height : Float }
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
