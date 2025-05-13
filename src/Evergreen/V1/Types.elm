module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V1.DirtDict
import Evergreen.V1.GameObjectTypes
import Evergreen.V1.PersonDict
import Evergreen.V1.RelicDict
import Lamdera
import Time
import Url


type alias RealDirtDict =
    Evergreen.V1.DirtDict.DirtDict Evergreen.V1.GameObjectTypes.DirtData


type alias RelicLocation =
    ( Int, Int, Int )


type alias RealRelicDict =
    Evergreen.V1.RelicDict.RelicDict Evergreen.V1.GameObjectTypes.RelicData


type alias RelicsByLocation =
    Dict.Dict RelicLocation RealRelicDict


type alias GameState =
    { personDict : Evergreen.V1.PersonDict.PersonDict Evergreen.V1.GameObjectTypes.PersonData
    , dirtDict : RealDirtDict
    , relicsByLocation : RelicsByLocation
    }


type alias FrontendPlayingState =
    { gameState : GameState
    , myId : Evergreen.V1.GameObjectTypes.PersonId
    , targetPosition : Maybe Evergreen.V1.GameObjectTypes.Point
    , showingDebugStuff : Bool
    , mapSize :
        Maybe
            { width : Float
            , height : Float
            }
    , cameraPosition : Evergreen.V1.GameObjectTypes.Point
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
    , sessionIdToPersonId : Dict.Dict Lamdera.SessionId Evergreen.V1.GameObjectTypes.PersonId
    , biggestId : Int
    , bigRandom : Int
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | PerformAction Evergreen.V1.GameObjectTypes.ActionOnGamestate
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ActivatedRelic Evergreen.V1.GameObjectTypes.PersonId Evergreen.V1.GameObjectTypes.RelicId
    | ClickTarget Evergreen.V1.GameObjectTypes.Point
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
    | ClientPerformsAction Evergreen.V1.GameObjectTypes.ActionOnGamestate
    | PleaseMakeMeDirty
    | PleaseGenerateRelic
    | PleaseActivateRelic Evergreen.V1.GameObjectTypes.PersonId Evergreen.V1.GameObjectTypes.RelicId


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected Lamdera.SessionId Lamdera.ClientId
    | ClientDisconnected Lamdera.SessionId Lamdera.ClientId


type ActionPerformer
    = Client Evergreen.V1.GameObjectTypes.PersonId
    | Server


type alias BackendToFrontendState =
    { gameState : GameState
    , myId : Evergreen.V1.GameObjectTypes.PersonId
    }


type ToFrontend
    = NoOpToFrontend
    | OtherClientPerformedAction ActionPerformer Evergreen.V1.GameObjectTypes.ActionOnGamestate
    | UpdateFullState BackendToFrontendState
