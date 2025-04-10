module Evergreen.V1.GameObjectTypes exposing (..)


type PersonId
    = PersonId Int


type alias Point =
    { x : Int
    , y : Int
    }


type alias PersonStats =
    { cleanCount : Int
    , clearCount : Int
    }


type alias PersonData =
    { id : PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    }


type DirtId
    = DirtId Int


type alias DirtData =
    { id : DirtId
    , amount : Int
    , position : Point
    }


type RelicId
    = RelicId Int


type RelicType
    = CleanFast
    | MoreXP
    | DropAndDouble (List PersonId)


type RelicRarity
    = Common
    | Uncommon
    | Rare
    | Epic
    | Legendary


type alias RelicData =
    { id : RelicId
    , relicType : RelicType
    , rarity : RelicRarity
    , exp : Int
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
    = MovePerson PersonId Direction
    | Clean PersonId DirtId
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic RelicId PersonId
    | DropRelic RelicId PersonId
    | ActivateGenerosityTrap PersonId RelicId Int
    | GameStateNoOp
