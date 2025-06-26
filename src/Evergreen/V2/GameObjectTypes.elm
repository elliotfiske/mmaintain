module Evergreen.V2.GameObjectTypes exposing (..)

import Evergreen.V2.GameObjectIds
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
    , giver : Evergreen.V2.GameObjectIds.PersonId
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
    { id : Evergreen.V2.GameObjectIds.PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    , bestHighFiveBoost : Maybe HighFiveBoost
    , skillTree : SkillTree
    }


type RelicPosition
    = HeldBy Evergreen.V2.GameObjectIds.PersonId
    | OnFloor Point


type RelicType
    = Broom
    | Mop
    | MoreXP
    | DropAndDouble (List Evergreen.V2.GameObjectIds.PersonId)
    | SplashBucket
    | GuestBook (SeqSet.SeqSet Evergreen.V2.GameObjectIds.PersonId)
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
    { id : Evergreen.V2.GameObjectIds.RelicId
    , relicType : RelicType
    , rarity : RelicRarity
    , exp : Int
    }


type alias DirtData =
    { id : Evergreen.V2.GameObjectIds.DirtId
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
    = MovePerson Evergreen.V2.GameObjectIds.PersonId Direction
    | Clean Evergreen.V2.GameObjectIds.PersonId Point
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic Evergreen.V2.GameObjectIds.RelicId Evergreen.V2.GameObjectIds.PersonId
    | DropRelic Evergreen.V2.GameObjectIds.RelicId Evergreen.V2.GameObjectIds.PersonId
    | ActivateGenerosityTrap Evergreen.V2.GameObjectIds.PersonId Evergreen.V2.GameObjectIds.RelicId
    | UnlockSkillAction Evergreen.V2.GameObjectIds.PersonId Skill
    | BatchAction (List ActionOnGamestate)
    | GameStateNoOp


type ActionId
    = ActionId Int


type alias ActionWithMetadata =
    { action : ActionOnGamestate
    , performer : Evergreen.V2.GameObjectIds.PersonId
    , id : ActionId
    }
