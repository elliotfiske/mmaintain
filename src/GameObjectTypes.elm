module GameObjectTypes exposing (..)


type PersonId
    = PersonId Int


personIdToInt : PersonId -> Int
personIdToInt (PersonId id) =
    id


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


type GameObject
    = Person PersonData
    | Dirt DirtData
    | Relic RelicData


type alias PersonData =
    { id : PersonId
    , name : String
    , experience : Int
    , x : Int
    , y : Int
    }


type alias DirtData =
    { id : DirtId, amount : Int, x : Int, y : Int }


type alias RelicData =
    { id : RelicId, relicType : RelicType, position : RelicPosition }


type RelicPosition
    = HeldBy PersonId
    | OnFloor Int Int


type RelicType
    = CleanFast
    | MoreXP


type Direction
    = Up
    | Down
    | Left
    | Right


type ActionOnGamestate
    = MovePerson PersonId Direction
    | Clean DirtId
    | AddPerson PersonData
