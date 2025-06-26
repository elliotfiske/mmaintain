module Evergreen.V1.GameObjectTypes exposing (..)

import Evergreen.V1.GameObjectIds
import SeqSet


type alias Point =
    { x : Int
    , y : Int
    }


type alias PersonStats =
    { cleanCount : Int
    , clearCount : Int
    }


type alias HighFiveBoost =
    { boost : Int
    , giver : Evergreen.V1.GameObjectIds.PersonId
    }


type alias SkillTree =
    { root : Bool
    , learned : Bool
    , swiftCleaning : Bool
    , cleaningFundamentals : Bool
    }


type alias PersonData =
    { id : Evergreen.V1.GameObjectIds.PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    , bestHighFiveBoost : Maybe HighFiveBoost
    , skillTree : SkillTree
    }


type RelicPosition
    = HeldBy Evergreen.V1.GameObjectIds.PersonId
    | OnFloor Point


type RelicType
    = Broom
    | Mop
    | MoreXP
    | DropAndDouble (List Evergreen.V1.GameObjectIds.PersonId)
    | SplashBucket
    | GuestBook (SeqSet.SeqSet Evergreen.V1.GameObjectIds.PersonId)
    | DiminishingPower
        { currentDirtPatch : Maybe Point
        , currentPower : Float
        }
    | HighFive


type RelicRarity
    = Common
    | Uncommon
    | Rare
    | Epic
    | Legendary


type alias RelicData =
    { id : Evergreen.V1.GameObjectIds.RelicId
    , relicType : RelicType
    , rarity : RelicRarity
    , exp : Int
    }


type alias DirtData =
    { id : Evergreen.V1.GameObjectIds.DirtId
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
    = MovePerson Evergreen.V1.GameObjectIds.PersonId Direction
    | Clean Evergreen.V1.GameObjectIds.PersonId Point
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic Evergreen.V1.GameObjectIds.RelicId Evergreen.V1.GameObjectIds.PersonId
    | DropRelic Evergreen.V1.GameObjectIds.RelicId Evergreen.V1.GameObjectIds.PersonId
    | ActivateGenerosityTrap Evergreen.V1.GameObjectIds.PersonId Evergreen.V1.GameObjectIds.RelicId
    | UnlockSkillAction Evergreen.V1.GameObjectIds.PersonId String
    | BatchAction (List ActionOnGamestate)
    | GameStateNoOp


type ActionId
    = ActionId Int


type alias ActionWithMetadata =
    { action : ActionOnGamestate
    , performer : Evergreen.V1.GameObjectIds.PersonId
    , id : ActionId
    }
