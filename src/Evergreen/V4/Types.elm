module Evergreen.V4.Types exposing (..)

import Browser
import Effect.Browser.Navigation
import Effect.Lamdera
import Effect.Time
import Evergreen.V4.GameObjectIds
import Evergreen.V4.GameObjectTypes
import SeqDict
import Url


type alias RelicsById =
    SeqDict.SeqDict Evergreen.V4.GameObjectIds.RelicId Evergreen.V4.GameObjectTypes.RelicData


type alias RelicsByLocation =
    SeqDict.SeqDict Evergreen.V4.GameObjectTypes.RelicPosition RelicsById


type alias DirtByLocation =
    SeqDict.SeqDict Evergreen.V4.GameObjectTypes.Point Evergreen.V4.GameObjectTypes.DirtData


type alias GameState =
    { personDict : SeqDict.SeqDict Evergreen.V4.GameObjectIds.PersonId Evergreen.V4.GameObjectTypes.PersonData
    , relicsByLocation : RelicsByLocation
    , dirtByLocation : DirtByLocation
    }


type alias FrontendPlayingState =
    { backendConfirmedGameState : GameState
    , optimisticActions : List Evergreen.V4.GameObjectTypes.ActionOnGamestate
    , myId : Evergreen.V4.GameObjectIds.PersonId
    , targetPosition : Maybe Evergreen.V4.GameObjectTypes.Point
    , showingDebugStuff : Bool
    , mapSize :
        Maybe
            { width : Float
            , height : Float
            }
    , cameraPosition : Evergreen.V4.GameObjectTypes.Point
    , mobileRelicMenuOpen : Bool
    }


type FrontendState
    = Loading
    | Playing FrontendPlayingState
    | Error String


type alias FrontendModel =
    { key : Effect.Browser.Navigation.Key
    , state : FrontendState
    }


type alias BackendModel =
    { gameState : GameState
    , connectedClients : List Effect.Lamdera.ClientId
    , sessionIdToPersonId : SeqDict.SeqDict Effect.Lamdera.SessionId Evergreen.V4.GameObjectIds.PersonId
    , biggestId : Int
    , bigRandom : Int
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | PerformAction Evergreen.V4.GameObjectTypes.ActionOnGamestate
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ActivatedRelic Evergreen.V4.GameObjectIds.PersonId Evergreen.V4.GameObjectIds.RelicId
    | ClickTarget Evergreen.V4.GameObjectTypes.Point
    | Tick Effect.Time.Posix
    | ToggleDebugStuff
    | CloseModals
    | ReceivedMapSize
        { width : Float
        , height : Float
        }
    | ToggleMobileRelicMenu
    | NoOpFrontendMsg
    | NukeBackend


type ToBackend
    = NoOpToBackend
    | ClientPerformsAction Evergreen.V4.GameObjectTypes.ActionOnGamestate
    | PleaseMakeMeDirty
    | PleaseGenerateRelic
    | PleaseActivateRelic Evergreen.V4.GameObjectIds.PersonId Evergreen.V4.GameObjectIds.RelicId
    | PleaseNukeBackend


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected Effect.Lamdera.SessionId Effect.Lamdera.ClientId
    | ClientDisconnected Effect.Lamdera.SessionId Effect.Lamdera.ClientId


type ActionPerformer
    = Client Evergreen.V4.GameObjectIds.PersonId
    | Server


type alias BackendToFrontendState =
    { gameState : GameState
    , myId : Evergreen.V4.GameObjectIds.PersonId
    }


type ToFrontend
    = NoOpToFrontend
    | OtherClientPerformedAction ActionPerformer Evergreen.V4.GameObjectTypes.ActionOnGamestate
    | UpdateFullState BackendToFrontendState
