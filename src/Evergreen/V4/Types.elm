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
    , relicIdToLocationIndex : SeqDict.SeqDict Evergreen.V4.GameObjectIds.RelicId Evergreen.V4.GameObjectTypes.RelicPosition
    }


type SkillTreeModalState
    = Closed
    | SkillTreeOpen
    | SkillDetailOpen Evergreen.V4.GameObjectTypes.Skill


type alias FrontendPlayingState =
    { backendConfirmedGameState : GameState
    , optimisticActions : List Evergreen.V4.GameObjectTypes.ActionWithMetadata
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
    , skillTreeModalState : SkillTreeModalState
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    , currentTime : Effect.Time.Posix
    , stunnedUntil : Effect.Time.Posix
    , cleaningRandom : Int
    , nextActionId : Int
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
    | PerformAction Evergreen.V4.GameObjectTypes.ActionOnGamestate
    | StunSelf
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ClickTarget Evergreen.V4.GameObjectTypes.Point
    | Tick Effect.Time.Posix
    | AnimationTick Effect.Time.Posix
    | ToggleDebugStuff
    | CloseModals
    | ReceivedMapSize
        { width : Float
        , height : Float
        }
    | ToggleMobileRelicMenu
    | ToggleSkillTreeMenu
    | ClickedSkillNode Evergreen.V4.GameObjectTypes.Skill
    | CloseSkillTreeModal
    | UnlockSkill Evergreen.V4.GameObjectTypes.Skill
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
    | ClientPerformsAction Evergreen.V4.GameObjectTypes.ActionWithMetadata
    | PleaseMakeMeDirty
    | PleaseGenerateRelic
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
    = Client Evergreen.V4.GameObjectIds.PersonId
    | Server


type alias BackendToFrontendState =
    { gameState : GameState
    , myId : Evergreen.V4.GameObjectIds.PersonId
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    }


type ToFrontend
    = NoOpToFrontend
    | ServerAction ActionPerformer Evergreen.V4.GameObjectTypes.ActionOnGamestate
    | ActionConfirmed Evergreen.V4.GameObjectTypes.ActionWithMetadata
    | UpdateFullState BackendToFrontendState
