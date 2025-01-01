module Evergreen.V1.GameObjectTypes exposing (..)


type PersonId
    = PersonId Int


type alias PersonData =
    { id : PersonId
    , name : String
    , experience : Int
    , x : Int
    , y : Int
    }


type RelicId
    = RelicId Int


type RelicType
    = CleanFast
    | MoreXP


type RelicPosition
    = HeldBy PersonId
    | OnFloor Int Int


type alias RelicData =
    { id : RelicId
    , relicType : RelicType
    , position : RelicPosition
    }


type DirtId
    = DirtId Int


type alias DirtData =
    { id : DirtId
    , amount : Int
    , x : Int
    , y : Int
    }


type Direction
    = Up
    | Down
    | Left
    | Right


type ActionOnGamestate
    = MovePerson PersonId Direction
    | Clean DirtId
    | AddPerson PersonData
