module GameObjectTypes exposing (..)

import GameObjectIds exposing (DirtId, PersonId, RelicId)
import SeqSet exposing (SeqSet)


{-| This is the "topmost" Types module. It knows about all the types relating to the GameState and
the objects within.

It _doesn't_ know about things like a "frontend" vs a "backend".

Also note that it can't have the idea of a "PersonDict" or "RelicDict" because those are dependent on
what a Person and Relic is.

GameObjectTypes => Types => Rest of world
GameObjectTypes => RelicDict/PersonDict/DirtDict => Types

-}
type alias Point =
    { x : Int, y : Int }


type alias PersonStats =
    { cleanCount : Int
    , clearCount : Int
    }


type alias HighFiveBoost =
    { boost : Int
    , giver : PersonId
    }


type alias PersonData =
    { id : PersonId
    , name : String
    , experience : Int
    , position : Point
    , stats : PersonStats
    , bestHighFiveBoost : Maybe HighFiveBoost
    }


type alias DirtData =
    { id : DirtId, amount : Int, position : Point }


type alias RelicData =
    { id : RelicId, relicType : RelicType, rarity : RelicRarity, exp : Int }


type RelicPosition
    = HeldBy PersonId
    | OnFloor Point


type RelicType
    = CleanFast
    | MoreXP
    | DropAndDouble (List PersonId)
    | SplashBucket
    | GuestBook (SeqSet PersonId)
    | DiminishingPower { currentDirtPatch : Maybe Point, currentPower : Float }
    | HighFive


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


type ActionId
    = ActionId Int


type alias ActionWithMetadata =
    { action : ActionOnGamestate
    , performer : PersonId
    , id : ActionId
    }


type ActionOnGamestate
    = MovePerson PersonId Direction
    | Clean PersonId Point
    | AddDirt DirtData
    | AddRelic RelicData Point
    | AddPerson PersonData
    | PickUpRelic RelicId PersonId
    | DropRelic RelicId PersonId
    | ActivateGenerosityTrap PersonId RelicId Int
    | BatchAction (List ActionOnGamestate)
    | GameStateNoOp
