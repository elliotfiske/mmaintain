module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import DirtDict exposing (DirtDict)
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import Lamdera exposing (ClientId, SessionId)
import PersonDict exposing (PersonDict)
import RelicDict exposing (RelicDict)
import Time exposing (Posix)
import Url exposing (Url)



-- TODO: could probably generate Real*Dict with other generated dictionary code


type alias RealPersonDict =
    PersonDict PersonData


type alias RealRelicDict =
    RelicDict RelicData


type alias RealDirtDict =
    DirtDict DirtData


type alias PersonWithRelics =
    { person : PersonData, heldRelics : List RelicData }


type alias RelicLocation =
    ( Int, Int, Int )


type alias RelicsByLocation =
    Dict RelicLocation RealRelicDict


type alias DirtLocation =
    ( Int, Int )


type alias DirtByLocation =
    Dict DirtLocation DirtData


type alias GameState =
    { personDict : PersonDict PersonData
    , relicsByPosition : RelicsByLocation
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
