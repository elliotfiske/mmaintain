module Evergreen.V6.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V6.GameObjectIds
import Evergreen.V6.GameObjectTypes
import Evergreen.V6.PersonDict
import Evergreen.V6.RelicDict
import Lamdera
import Time
import Url


type alias RelicLocation =
    ( Int, Int, Int )


type alias RealRelicDict =
    Evergreen.V6.RelicDict.RelicDict Evergreen.V6.GameObjectTypes.RelicData


type alias RelicsByLocation =
    Dict.Dict RelicLocation RealRelicDict


type alias DirtLocation =
    ( Int, Int )


type alias DirtByLocation =
    Dict.Dict DirtLocation Evergreen.V6.GameObjectTypes.DirtData


type alias GameState =
    { personDict : Evergreen.V6.PersonDict.PersonDict Evergreen.V6.GameObjectTypes.PersonData
    , relicsByPosition : RelicsByLocation
    , dirtByLocation : DirtByLocation
    }


type alias FrontendPlayingState =
    { gameState : GameState
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
    }


type FrontendState
    = Loading
    | Playing FrontendPlayingState
    | Error String


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , state : FrontendState
    }


type alias BackendModel =
    { gameState : GameState
    , connectedClients : List Lamdera.ClientId
    , sessionIdToPersonId : Dict.Dict Lamdera.SessionId Evergreen.V6.GameObjectIds.PersonId
    , biggestId : Int
    , bigRandom : Int
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | PerformAction Evergreen.V6.GameObjectTypes.ActionOnGamestate
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ActivatedRelic Evergreen.V6.GameObjectIds.PersonId Evergreen.V6.GameObjectIds.RelicId
    | ClickTarget Evergreen.V6.GameObjectTypes.Point
    | Tick Time.Posix
    | ToggleDebugStuff
    | ReceivedMapSize
        { width : Float
        , height : Float
        }
    | ToggleMobileRelicMenu
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend
    | ClientPerformsAction Evergreen.V6.GameObjectTypes.ActionOnGamestate
    | PleaseMakeMeDirty
    | PleaseGenerateRelic
    | PleaseActivateRelic Evergreen.V6.GameObjectIds.PersonId Evergreen.V6.GameObjectIds.RelicId


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected Lamdera.SessionId Lamdera.ClientId
    | ClientDisconnected Lamdera.SessionId Lamdera.ClientId


type ActionPerformer
    = Client Evergreen.V6.GameObjectIds.PersonId
    | Server


type alias BackendToFrontendState =
    { gameState : GameState
    , myId : Evergreen.V6.GameObjectIds.PersonId
    }


type ToFrontend
    = NoOpToFrontend
    | OtherClientPerformedAction ActionPerformer Evergreen.V6.GameObjectTypes.ActionOnGamestate
    | UpdateFullState BackendToFrontendState
