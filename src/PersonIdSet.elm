module PersonIdSet exposing (..)

import GameObjectIds exposing (PersonId)
import Set exposing (Set)


type PersonIdSet
    = PersonIdSet (Set String)


size : PersonIdSet -> Int
size (PersonIdSet set) =
    Set.size set


insert : PersonId -> PersonIdSet -> PersonIdSet
insert personId (PersonIdSet set) =
    PersonIdSet (Set.insert (GameObjectIds.personIdToString personId) set)


remove : PersonId -> PersonIdSet -> PersonIdSet
remove personId (PersonIdSet set) =
    PersonIdSet (Set.remove (GameObjectIds.personIdToString personId) set)


member : PersonId -> PersonIdSet -> Bool
member personId (PersonIdSet set) =
    Set.member (GameObjectIds.personIdToString personId) set
