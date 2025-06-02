module Evergreen.V3.GameObjectTypes exposing (..)

import Evergreen.V3.GameObjectIds
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
    { id : Evergreen.V3.GameObjectIds.PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    }


type RelicPosition
    = HeldBy Evergreen.V3.GameObjectIds.PersonId
    | OnFloor Point


type RelicType
    = CleanFast
    | MoreXP
    | DropAndDouble (List Evergreen.V3.GameObjectIds.PersonId)
    | SplashBucket
    | GuestBook (SeqSet.SeqSet Evergreen.V3.GameObjectIds.PersonId)
    | DiminishingPower
        { currentDirtPatch : Maybe Point
        , currentPower : Float
        }


type RelicRarity
    = Common
    | Uncommon
    | Rare
    | Epic
    | Legendary


type alias RelicData =
    { id : Evergreen.V3.GameObjectIds.RelicId
    , relicType : RelicType
    , rarity : RelicRarity
    , exp : Int
    }


type alias DirtData =
    { id : Evergreen.V3.GameObjectIds.DirtId
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
    = MovePerson Evergreen.V3.GameObjectIds.PersonId Direction
    | Clean Evergreen.V3.GameObjectIds.PersonId Point
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic Evergreen.V3.GameObjectIds.RelicId Evergreen.V3.GameObjectIds.PersonId
    | DropRelic Evergreen.V3.GameObjectIds.RelicId Evergreen.V3.GameObjectIds.PersonId
    | ActivateGenerosityTrap Evergreen.V3.GameObjectIds.PersonId Evergreen.V3.GameObjectIds.RelicId Int
    | BatchAction (List ActionOnGamestate)
    | GameStateNoOp
