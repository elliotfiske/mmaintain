module Types exposing (..)

import Browser exposing (UrlRequest)
import Effect.Browser.Navigation
import Effect.Lamdera exposing (ClientId, SessionId)
import Effect.Time
import GameObjectIds exposing (..)
import GameObjectTypes exposing (..)
import SeqDict exposing (SeqDict)
import Url exposing (Url)


type alias RelicsById =
    SeqDict RelicId RelicData


type alias PersonWithRelics =
    { person : PersonData, heldRelics : List RelicData }


type alias RelicsByLocation =
    SeqDict GameObjectTypes.RelicPosition RelicsById


type alias DirtByLocation =
    SeqDict Point DirtData


type alias GameState =
    { personDict : SeqDict PersonId PersonData
    , relicsByLocation : RelicsByLocation
    , dirtByLocation : DirtByLocation
    , relicIdToLocationIndex : SeqDict RelicId GameObjectTypes.RelicPosition
    }


type alias FrontendModel =
    { key : Effect.Browser.Navigation.Key
    , state : FrontendState
    }


type SkillTreeModalState
    = Closed
    | SkillTreeOpen
    | SkillDetailOpen String


type alias FrontendPlayingState =
    { backendConfirmedGameState : GameState
    , optimisticActions : List ActionWithMetadata
    , myId : PersonId
    , targetPosition : Maybe Point
    , showingDebugStuff : Bool
    , mapSize : Maybe { width : Float, height : Float }
    , cameraPosition : Point
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


type alias BackendToFrontendState =
    { gameState : GameState
    , myId : PersonId
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    }


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
    , debugDirtParams :
        { minX : Int
        , maxX : Int
        , minY : Int
        , maxY : Int
        }
    }


type BackendTrigger
    = NoOpBackendTrigger
    | ClearedPollution PersonId DirtData
    | BatchTrigger (List BackendTrigger)


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | PerformAction ActionOnGamestate
    | StunSelf
    | ClickedPleaseMakeMeDirty
    | DebugGenerateRelic
    | ClickTarget Point
    | Tick Effect.Time.Posix
    | AnimationTick Effect.Time.Posix
    | ToggleDebugStuff
    | CloseModals
    | ReceivedMapSize { width : Float, height : Float }
    | ToggleMobileRelicMenu
    | ToggleSkillTreeMenu
    | ClickedSkillNode String
    | CloseSkillTreeModal
    | UnlockSkill String
    | NoOpFrontendMsg
    | NukeBackend
    | UpdateDebugDirtParamsMsg { minX : Int, maxX : Int, minY : Int, maxY : Int }


type ToBackend
    = NoOpToBackend
    | ClientPerformsAction ActionWithMetadata
    | PleaseMakeMeDirty
    | PleaseGenerateRelic
    | PleaseNukeBackend
    | UpdateDebugDirtParams { minX : Int, maxX : Int, minY : Int, maxY : Int }


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected SessionId ClientId
    | ClientDisconnected SessionId ClientId


type ActionPerformer
    = Client PersonId
    | Server


type ToFrontend
    = NoOpToFrontend
    | ServerAction ActionPerformer ActionOnGamestate
    | ActionConfirmed ActionWithMetadata
    | UpdateFullState BackendToFrontendState
