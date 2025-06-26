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


type alias HighFiveBoost =
    { boost : Int
    , giver : Evergreen.V4.GameObjectIds.PersonId
    }


type alias SkillTree =
    { root : Bool
    , learned : Bool
    , swiftCleaning : Bool
    , cleaningFundamentals : Bool
    , relicHunter : Bool
    , powerCleaning : Bool
    }


type alias PersonData =
    { id : Evergreen.V4.GameObjectIds.PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    , bestHighFiveBoost : Maybe HighFiveBoost
    , skillTree : SkillTree
    }


type RelicPosition
    = HeldBy Evergreen.V4.GameObjectIds.PersonId
    | OnFloor Point


type RelicType
    = Broom
    | Mop
    | MoreXP
    | DropAndDouble (List Evergreen.V4.GameObjectIds.PersonId)
    | SplashBucket
    | GuestBook (SeqSet.SeqSet Evergreen.V4.GameObjectIds.PersonId)
    | DiminishingPower
        { currentDirtPatch : Maybe Point
        , currentPower : Float
        }
    | HighFive
    | MetalDetector


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
    , maxAmount : Int
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


type Skill
    = Root
    | Learned
    | SwiftCleaning
    | CleaningFundamentals
    | RelicHunter
    | PowerCleaning


type ActionOnGamestate
    = MovePerson Evergreen.V4.GameObjectIds.PersonId Direction
    | TeleportPerson Evergreen.V4.GameObjectIds.PersonId Point
    | Clean Evergreen.V4.GameObjectIds.PersonId Point
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic Evergreen.V4.GameObjectIds.RelicId Evergreen.V4.GameObjectIds.PersonId
    | DropRelic Evergreen.V4.GameObjectIds.RelicId Evergreen.V4.GameObjectIds.PersonId
    | ActivateGenerosityTrap Evergreen.V4.GameObjectIds.PersonId Evergreen.V4.GameObjectIds.RelicId
    | UnlockSkillAction Evergreen.V4.GameObjectIds.PersonId Skill
    | BatchAction (List ActionOnGamestate)
    | GameStateNoOp


type ActionId
    = ActionId Int


type alias ActionWithMetadata =
    { action : ActionOnGamestate
    , performer : Evergreen.V4.GameObjectIds.PersonId
    , id : ActionId
    }
