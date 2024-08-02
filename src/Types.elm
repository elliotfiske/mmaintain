module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import DirtDict exposing (DirtDict)
import GameObjectTypes exposing (..)
import Lamdera exposing (ClientId, SessionId)
import PersonDict exposing (PersonDict)
import RelicDict exposing (RelicDict)
import Url exposing (Url)


type alias GameState =
    { personDict : PersonDict PersonData
    , relicDict : RelicDict RelicData
    , dirtDict : DirtDict DirtData
    }


type alias FrontendModel =
    { key : Key
    , state : FrontendState
    }


type alias FrontendPlayingState =
    { personDict : PersonDict PersonData
    , relicDict : RelicDict RelicData
    , dirtDict : DirtDict DirtData
    , myId : PersonId
    }


type FrontendState
    = Loading
    | Playing FrontendPlayingState
    | Error String


type alias BackendModel =
    { personDict : PersonDict PersonData
    , relicDict : RelicDict RelicData
    , dirtDict : DirtDict DirtData
    , connectedClients : List ClientId
    , sessionIdToPersonId : Dict SessionId PersonId
    , biggestId : Int
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | PerformAction ActionOnGamestate


type ToBackend
    = NoOpToBackend
    | ClientPerformsAction ActionOnGamestate


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected SessionId ClientId
    | ClientDisconnected SessionId ClientId


type ToFrontend
    = NoOpToFrontend
    | OtherClientPerformedAction ActionOnGamestate
    | UpdateFullState FrontendPlayingState
