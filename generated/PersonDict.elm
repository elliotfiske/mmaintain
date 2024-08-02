module PersonDict exposing (PersonDict, empty, filter, foldl, foldr, fromList, get, insert, isEmpty, keys, map, member, partition, remove, singleton, size, toList, update, values)

{-| 
## Build

@docs empty, singleton, insert, update, remove

## Dictionaries

@docs PersonDict

## Lists

@docs keys, values, toList, fromList

## Query

@docs isEmpty, member, get, size

## Transform

@docs map, foldl, foldr, filter, partition
-}


import Dict
import GameObjectTypes


type PersonDict v
    = PersonDict (Dict.Dict Int ( GameObjectTypes.PersonId, v ))


empty : PersonDict v
empty =
    PersonDict Dict.empty


singleton : GameObjectTypes.PersonId -> v -> PersonDict v
singleton key value =
    PersonDict
        (Dict.singleton (GameObjectTypes.personIdToInt key) ( key, value ))


insert : GameObjectTypes.PersonId -> v -> PersonDict v -> PersonDict v
insert key value d =
    case d of
        PersonDict dict ->
            PersonDict
                (Dict.insert
                     (GameObjectTypes.personIdToInt key)
                     ( key, value )
                     dict
                )


update :
    GameObjectTypes.PersonId
    -> (Maybe b -> Maybe b)
    -> PersonDict b
    -> PersonDict b
update key f d =
    case d of
        PersonDict dict ->
            PersonDict
                (Dict.update
                     (GameObjectTypes.personIdToInt key)
                     (\updateUnpack ->
                          Maybe.map
                              (Tuple.pair key)
                              (f (Maybe.map Tuple.second updateUnpack))
                     )
                     dict
                )


remove : GameObjectTypes.PersonId -> PersonDict v -> PersonDict v
remove key d =
    case d of
        PersonDict dict ->
            PersonDict (Dict.remove (GameObjectTypes.personIdToInt key) dict)


isEmpty : PersonDict v -> Bool
isEmpty d =
    case d of
        PersonDict dict ->
            Dict.isEmpty dict


member : GameObjectTypes.PersonId -> PersonDict v -> Bool
member key d =
    case d of
        PersonDict dict ->
            Dict.member (GameObjectTypes.personIdToInt key) dict


get : GameObjectTypes.PersonId -> PersonDict b -> Maybe b
get key d =
    case d of
        PersonDict dict ->
            Maybe.map
                Tuple.second
                (Dict.get (GameObjectTypes.personIdToInt key) dict)


size : PersonDict v -> Int
size d =
    case d of
        PersonDict dict ->
            Dict.size dict


keys : PersonDict v -> List GameObjectTypes.PersonId
keys d =
    case d of
        PersonDict dict ->
            List.map Tuple.first (Dict.values dict)


values : PersonDict v -> List v
values d =
    case d of
        PersonDict dict ->
            List.map Tuple.second (Dict.values dict)


toList : PersonDict v -> List ( GameObjectTypes.PersonId, v )
toList d =
    case d of
        PersonDict dict ->
            Dict.values dict


fromList : List ( GameObjectTypes.PersonId, v ) -> PersonDict v
fromList l =
    PersonDict
        (Dict.fromList
             (List.map
                  (\e ->
                       case e of
                           ( k, v ) ->
                               ( GameObjectTypes.personIdToInt k, e )
                  )
                  l
             )
        )


map : (GameObjectTypes.PersonId -> a -> b) -> PersonDict a -> PersonDict b
map f d =
    case d of
        PersonDict dict ->
            PersonDict
                (Dict.map
                     (\mapUnpack ->
                          \unpack ->
                              case unpack of
                                  ( k, a ) ->
                                      ( k, f k a )
                     )
                     dict
                )


foldl : (GameObjectTypes.PersonId -> v -> b -> b) -> b -> PersonDict v -> b
foldl f b0 d =
    case d of
        PersonDict dict ->
            Dict.foldl
                (\_ kv b ->
                     case kv of
                         ( k, v ) ->
                             f k v b
                )
                b0
                dict


foldr : (GameObjectTypes.PersonId -> v -> b -> b) -> b -> PersonDict v -> b
foldr f b0 d =
    case d of
        PersonDict dict ->
            Dict.foldr
                (\_ kv b ->
                     case kv of
                         ( k, v ) ->
                             f k v b
                )
                b0
                dict


filter : (GameObjectTypes.PersonId -> v -> Bool) -> PersonDict v -> PersonDict v
filter f d =
    PersonDict
        (case d of
             PersonDict dict ->
                 Dict.filter
                     (\filterUnpack ->
                          \unpack ->
                              case unpack of
                                  ( k, v ) ->
                                      f k v
                     )
                     dict
        )


partition :
    (GameObjectTypes.PersonId -> v -> Bool)
    -> PersonDict v
    -> ( PersonDict v, PersonDict v )
partition f d =
    case d of
        PersonDict dict ->
            Tuple.mapBoth
                PersonDict
                PersonDict
                (Dict.partition
                     (\partitionUnpack ->
                          \unpack ->
                              case unpack of
                                  ( k, v ) ->
                                      f k v
                     )
                     dict
                )