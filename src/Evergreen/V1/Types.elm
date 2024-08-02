module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V1.DirtDict
import Evergreen.V1.GameObjectTypes
import Evergreen.V1.PersonDict
import Evergreen.V1.RelicDict
import Lamdera
import Url


type alias FrontendPlayingState =
    { personDict : Evergreen.V1.PersonDict.PersonDict Evergreen.V1.GameObjectTypes.PersonData
    , relicDict : Evergreen.V1.RelicDict.RelicDict Evergreen.V1.GameObjectTypes.RelicData
    , dirtDict : Evergreen.V1.DirtDict.DirtDict Evergreen.V1.GameObjectTypes.DirtData
    , myId : Evergreen.V1.GameObjectTypes.PersonId
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
    { personDict : Evergreen.V1.PersonDict.PersonDict Evergreen.V1.GameObjectTypes.PersonData
    , relicDict : Evergreen.V1.RelicDict.RelicDict Evergreen.V1.GameObjectTypes.RelicData
    , dirtDict : Evergreen.V1.DirtDict.DirtDict Evergreen.V1.GameObjectTypes.DirtData
    , connectedClients : List Lamdera.ClientId
    , sessionIdToPersonId : Dict.Dict Lamdera.SessionId Evergreen.V1.GameObjectTypes.PersonId
    , biggestId : Int
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOpFrontendMsg
    | PerformAction Evergreen.V1.GameObjectTypes.ActionOnGamestate


type ToBackend
    = NoOpToBackend
    | ClientPerformsAction Evergreen.V1.GameObjectTypes.ActionOnGamestate


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected Lamdera.SessionId Lamdera.ClientId
    | ClientDisconnected Lamdera.SessionId Lamdera.ClientId


type ToFrontend
    = NoOpToFrontend
    | OtherClientPerformedAction Evergreen.V1.GameObjectTypes.ActionOnGamestate
    | UpdateFullState FrontendPlayingState
