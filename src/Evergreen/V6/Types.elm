module Evergreen.V6.Types exposing (..)

import Browser
import Effect.Browser.Navigation
import Effect.Lamdera
import Effect.Time
import Evergreen.V6.GameObjectIds
import Evergreen.V6.GameObjectTypes
import SeqDict
import Url


type alias RelicsById =
    SeqDict.SeqDict Evergreen.V6.GameObjectIds.RelicId Evergreen.V6.GameObjectTypes.RelicData


type alias RelicsByLocation =
    SeqDict.SeqDict Evergreen.V6.GameObjectTypes.RelicPosition RelicsById


type alias DirtByLocation =
    SeqDict.SeqDict Evergreen.V6.GameObjectTypes.Point Evergreen.V6.GameObjectTypes.DirtData


type alias GameState =
    { personDict : SeqDict.SeqDict Evergreen.V6.GameObjectIds.PersonId Evergreen.V6.GameObjectTypes.PersonData
    , relicsByLocation : RelicsByLocation
    , dirtByLocation : DirtByLocation
    , relicIdToLocationIndex : SeqDict.SeqDict Evergreen.V6.GameObjectIds.RelicId Evergreen.V6.GameObjectTypes.RelicPosition
    }


type alias FrontendPlayingState =
    { backendConfirmedGameState : GameState
    , optimisticActions : List Evergreen.V6.GameObjectTypes.ActionOnGamestate
    , myId : Evergreen.V6.GameObjectIds.PersonId
    , targetPosition : Maybe Evergreen.V6.GameObjectTypes.Point
    , showingDebugStuff : Bool
    , mapSize :
        Maybe
            { width : Float
            , height : Float
            }
    , cameraPosition : Evergreen.V6.GameObjectTypes.Point
    , mobileRelicMenuOpen : Bool
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    , currentTime : Effect.Time.Posix
    , stunnedUntil : Effect.Time.Posix
    , cleaningRandom : Int
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
    , sessionIdToPersonId : SeqDict.SeqDict Effect.Lamdera.SessionId Evergreen.V6.GameObjectIds.PersonId
    , biggestId : Int
    , bigRandom : Int
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | PerformAction Evergreen.V6.GameObjectTypes.ActionOnGamestate
    | StunSelf
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ActivatedRelic Evergreen.V6.GameObjectIds.PersonId Evergreen.V6.GameObjectIds.RelicId
    | ClickTarget Evergreen.V6.GameObjectTypes.Point
    | Tick Effect.Time.Posix
    | AnimationTick Effect.Time.Posix
    | ToggleDebugStuff
    | CloseModals
    | ReceivedMapSize
        { width : Float
        , height : Float
        }
    | ToggleMobileRelicMenu
    | NoOpFrontendMsg
    | NukeBackend
    | UpdateDebugDirtParamsMsg
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }


type ToBackend
    = NoOpToBackend
    | ClientPerformsAction Evergreen.V6.GameObjectTypes.ActionOnGamestate
    | PleaseMakeMeDirty
    | PleaseGenerateRelic
    | PleaseActivateRelic Evergreen.V6.GameObjectIds.PersonId Evergreen.V6.GameObjectIds.RelicId
    | PleaseNukeBackend
    | UpdateDebugDirtParams
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected Effect.Lamdera.SessionId Effect.Lamdera.ClientId
    | ClientDisconnected Effect.Lamdera.SessionId Effect.Lamdera.ClientId


type ActionPerformer
    = Client Evergreen.V6.GameObjectIds.PersonId
    | Server


type alias BackendToFrontendState =
    { gameState : GameState
    , myId : Evergreen.V6.GameObjectIds.PersonId
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    }


type ToFrontend
    = NoOpToFrontend
    | OtherClientPerformedAction ActionPerformer Evergreen.V6.GameObjectTypes.ActionOnGamestate
    | UpdateFullState BackendToFrontendState
