module Evergreen.V2.Types exposing (..)

import Browser
import Effect.Browser.Navigation
import Effect.Lamdera
import Effect.Time
import Evergreen.V2.GameObjectIds
import Evergreen.V2.GameObjectTypes
import SeqDict
import Url


type alias RelicsById =
    SeqDict.SeqDict Evergreen.V2.GameObjectIds.RelicId Evergreen.V2.GameObjectTypes.RelicData


type alias RelicsByLocation =
    SeqDict.SeqDict Evergreen.V2.GameObjectTypes.RelicPosition RelicsById


type alias DirtByLocation =
    SeqDict.SeqDict Evergreen.V2.GameObjectTypes.Point Evergreen.V2.GameObjectTypes.DirtData


type alias GameState =
    { personDict : SeqDict.SeqDict Evergreen.V2.GameObjectIds.PersonId Evergreen.V2.GameObjectTypes.PersonData
    , relicsByLocation : RelicsByLocation
    , dirtByLocation : DirtByLocation
    , relicIdToLocationIndex : SeqDict.SeqDict Evergreen.V2.GameObjectIds.RelicId Evergreen.V2.GameObjectTypes.RelicPosition
    }


type SkillTreeModalState
    = Closed
    | SkillTreeOpen
    | SkillDetailOpen Evergreen.V2.GameObjectTypes.Skill


type alias FrontendPlayingState =
    { backendConfirmedGameState : GameState
    , optimisticActions : List Evergreen.V2.GameObjectTypes.ActionWithMetadata
    , myId : Evergreen.V2.GameObjectIds.PersonId
    , targetPosition : Maybe Evergreen.V2.GameObjectTypes.Point
    , showingDebugStuff : Bool
    , mapSize :
        Maybe
            { width : Float
            , height : Float
            }
    , cameraPosition : Evergreen.V2.GameObjectTypes.Point
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
    , sessionIdToPersonId : SeqDict.SeqDict Effect.Lamdera.SessionId Evergreen.V2.GameObjectIds.PersonId
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
    | PerformAction Evergreen.V2.GameObjectTypes.ActionOnGamestate
    | StunSelf
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ClickTarget Evergreen.V2.GameObjectTypes.Point
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
    | ClickedSkillNode Evergreen.V2.GameObjectTypes.Skill
    | CloseSkillTreeModal
    | UnlockSkill Evergreen.V2.GameObjectTypes.Skill
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
    | ClientPerformsAction Evergreen.V2.GameObjectTypes.ActionWithMetadata
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
    = Client Evergreen.V2.GameObjectIds.PersonId
    | Server


type alias BackendToFrontendState =
    { gameState : GameState
    , myId : Evergreen.V2.GameObjectIds.PersonId
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    }


type ToFrontend
    = NoOpToFrontend
    | ServerAction ActionPerformer Evergreen.V2.GameObjectTypes.ActionOnGamestate
    | ActionConfirmed Evergreen.V2.GameObjectTypes.ActionWithMetadata
    | UpdateFullState BackendToFrontendState
