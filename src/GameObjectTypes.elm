module GameObjectTypes exposing (..)

{-| This is the "topmost" (for now) Types module. It knows about all the types relating to the GameState and
the objects within.

It _doesn't_ know about things like a "frontend" vs a "backend".

Also note that it can't have the idea of a "PersonDict" or "RelicDict" because those are dependent on
what a Person and Relic is.

GameObjectTypes => Types => Rest of world
GameObjectTypes => RelicDict/PersonDict/DirtDict => Types

-}


type PersonId
    = PersonId Int


personIdToInt : PersonId -> Int
personIdToInt (PersonId id) =
    id


personIdToString : PersonId -> String
personIdToString =
    personIdToInt >> String.fromInt


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
    | DropAndDouble (List PersonId)


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
    | UpLeft
    | UpRight
    | DownLeft
    | DownRight


type ActionOnGamestate
    = MovePerson PersonId Direction
    | Clean PersonId DirtId
    | ChangeDirtAmount DirtId Int
    | AddDirt DirtData
    | AddRelic RelicData
    | AddPerson PersonData
    | PickUpRelic RelicId PersonId
    | DropRelic RelicId PersonId
      -- todo: now that I decided to have this be backend-authoritative, this can be PersonData and RelicData for convenience
    | ActivateGenerosityTrap PersonId RelicId Int
    | GameStateNoOp
