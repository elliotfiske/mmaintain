module GameObjectTypes exposing (..)


type PersonId
    = PersonId Int


personIdToInt : PersonId -> Int
personIdToInt (PersonId id) =
    id


personIdToString : PersonId -> String
personIdToString id =
    String.fromInt (personIdToInt id)


type DirtId
    = DirtId Int


dirtIdToInt : DirtId -> Int
dirtIdToInt (DirtId id) =
    id


type RelicId
    = RelicId Int


relicIdToInt : RelicId -> Int
relicIdToInt (RelicId id) =
    id


relicIdToString : RelicId -> String
relicIdToString id =
    String.fromInt (relicIdToInt id)


type GameObject
    = Person PersonData
    | Dirt DirtData
    | Relic RelicData


type alias PersonStats =
    { cleanCount : Int
    , clearCount : Int
    }


type alias PersonData =
    { id : PersonId
    , name : String
    , experience : Int
    , x : Int
    , y : Int
    , stats : PersonStats
    }


type alias DirtData =
    { id : DirtId, amount : Int, x : Int, y : Int }


type alias RelicData =
    { id : RelicId, relicType : RelicType, position : RelicPosition, rarity : RelicRarity, exp : Int }


type RelicPosition
    = HeldBy PersonId
    | OnFloor Int Int


type RelicType
    = CleanFast
    | MoreXP


type RelicRarity
    = Common
    | Uncommon
    | Rare
    | Epic
    | Legendary


type Direction
    = Up
    | Down
    | Left
    | Right


type ActionOnGamestate
    = MovePerson PersonId Direction
    | Clean PersonId DirtId Int
    | ChangeDirtAmount DirtId Int
    | AddDirt DirtData
    | AddRelic RelicData
    | AddPerson PersonData
    | PickUpRelic RelicId PersonId
    | DropRelic RelicId PersonId
    | GameStateNoOp
