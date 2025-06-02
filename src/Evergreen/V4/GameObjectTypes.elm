module Evergreen.V4.GameObjectTypes exposing (..)

import Evergreen.V4.GameObjectIds
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
    { id : Evergreen.V4.GameObjectIds.PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    }


type RelicPosition
    = HeldBy Evergreen.V4.GameObjectIds.PersonId
    | OnFloor Point


type RelicType
    = CleanFast
    | MoreXP
    | DropAndDouble (List Evergreen.V4.GameObjectIds.PersonId)
    | SplashBucket
    | GuestBook (SeqSet.SeqSet Evergreen.V4.GameObjectIds.PersonId)
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
    { id : Evergreen.V4.GameObjectIds.RelicId
    , relicType : RelicType
    , rarity : RelicRarity
    , exp : Int
    }


type alias DirtData =
    { id : Evergreen.V4.GameObjectIds.DirtId
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
    = MovePerson Evergreen.V4.GameObjectIds.PersonId Direction
    | Clean Evergreen.V4.GameObjectIds.PersonId Point
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic Evergreen.V4.GameObjectIds.RelicId Evergreen.V4.GameObjectIds.PersonId
    | DropRelic Evergreen.V4.GameObjectIds.RelicId Evergreen.V4.GameObjectIds.PersonId
    | ActivateGenerosityTrap Evergreen.V4.GameObjectIds.PersonId Evergreen.V4.GameObjectIds.RelicId Int
    | BatchAction (List ActionOnGamestate)
    | GameStateNoOp
