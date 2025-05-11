module Evergreen.V6.GameObjectTypes exposing (..)

import Evergreen.V6.GameObjectIds
import SeqSet


type alias Point =
    { x : Int
    , y : Int
    }


type alias PersonStats =
    { cleanCount : Int
    , clearCount : Int
    }


type alias PersonData =
    { id : Evergreen.V6.GameObjectIds.PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    }


type RelicType
    = CleanFast
    | MoreXP
    | DropAndDouble (List Evergreen.V6.GameObjectIds.PersonId)
    | SplashBucket
    | GuestBook (SeqSet.SeqSet Evergreen.V6.GameObjectIds.PersonId)


type RelicRarity
    = Common
    | Uncommon
    | Rare
    | Epic
    | Legendary


type alias RelicData =
    { id : Evergreen.V6.GameObjectIds.RelicId
    , relicType : RelicType
    , rarity : RelicRarity
    , exp : Int
    }


type alias DirtData =
    { id : Evergreen.V6.GameObjectIds.DirtId
    , amount : Int
    , position : Point
    }


type Direction
    = Up
    | Down
    | Left
    | Right
    | UpLeft
    | UpRight
    | DownLeft
    | DownRight


type ActionOnGamestate
    = MovePerson Evergreen.V6.GameObjectIds.PersonId Direction
    | Clean Evergreen.V6.GameObjectIds.PersonId Point
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic Evergreen.V6.GameObjectIds.RelicId Evergreen.V6.GameObjectIds.PersonId
    | DropRelic Evergreen.V6.GameObjectIds.RelicId Evergreen.V6.GameObjectIds.PersonId
    | ActivateGenerosityTrap Evergreen.V6.GameObjectIds.PersonId Evergreen.V6.GameObjectIds.RelicId Int
    | BatchAction (List ActionOnGamestate)
    | GameStateNoOp
