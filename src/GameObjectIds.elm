module GameObjectIds exposing (..)


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


type RelicId
    = RelicId Int
