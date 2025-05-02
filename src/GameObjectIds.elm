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
