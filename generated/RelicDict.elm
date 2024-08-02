module RelicDict exposing (RelicDict, empty, filter, foldl, foldr, fromList, get, insert, isEmpty, keys, map, member, partition, remove, singleton, size, toList, update, values)

{-| 
## Build

@docs empty, singleton, insert, update, remove

## Dictionaries

@docs RelicDict

## Lists

@docs keys, values, toList, fromList

## Query

@docs isEmpty, member, get, size

## Transform

@docs map, foldl, foldr, filter, partition
-}


import Dict
import GameObjectTypes


type RelicDict v
    = RelicDict (Dict.Dict Int ( GameObjectTypes.RelicId, v ))


empty : RelicDict v
empty =
    RelicDict Dict.empty


singleton : GameObjectTypes.RelicId -> v -> RelicDict v
singleton key value =
    RelicDict (Dict.singleton (GameObjectTypes.relicIdToInt key) ( key, value ))


insert : GameObjectTypes.RelicId -> v -> RelicDict v -> RelicDict v
insert key value d =
    case d of
        RelicDict dict ->
            RelicDict
                (Dict.insert
                     (GameObjectTypes.relicIdToInt key)
                     ( key, value )
                     dict
                )


update :
    GameObjectTypes.RelicId
    -> (Maybe b -> Maybe b)
    -> RelicDict b
    -> RelicDict b
update key f d =
    case d of
        RelicDict dict ->
            RelicDict
                (Dict.update
                     (GameObjectTypes.relicIdToInt key)
                     (\updateUnpack ->
                          Maybe.map
                              (Tuple.pair key)
                              (f (Maybe.map Tuple.second updateUnpack))
                     )
                     dict
                )


remove : GameObjectTypes.RelicId -> RelicDict v -> RelicDict v
remove key d =
    case d of
        RelicDict dict ->
            RelicDict (Dict.remove (GameObjectTypes.relicIdToInt key) dict)


isEmpty : RelicDict v -> Bool
isEmpty d =
    case d of
        RelicDict dict ->
            Dict.isEmpty dict


member : GameObjectTypes.RelicId -> RelicDict v -> Bool
member key d =
    case d of
        RelicDict dict ->
            Dict.member (GameObjectTypes.relicIdToInt key) dict


get : GameObjectTypes.RelicId -> RelicDict b -> Maybe b
get key d =
    case d of
        RelicDict dict ->
            Maybe.map
                Tuple.second
                (Dict.get (GameObjectTypes.relicIdToInt key) dict)


size : RelicDict v -> Int
size d =
    case d of
        RelicDict dict ->
            Dict.size dict


keys : RelicDict v -> List GameObjectTypes.RelicId
keys d =
    case d of
        RelicDict dict ->
            List.map Tuple.first (Dict.values dict)


values : RelicDict v -> List v
values d =
    case d of
        RelicDict dict ->
            List.map Tuple.second (Dict.values dict)


toList : RelicDict v -> List ( GameObjectTypes.RelicId, v )
toList d =
    case d of
        RelicDict dict ->
            Dict.values dict


fromList : List ( GameObjectTypes.RelicId, v ) -> RelicDict v
fromList l =
    RelicDict
        (Dict.fromList
             (List.map
                  (\e ->
                       case e of
                           ( k, v ) ->
                               ( GameObjectTypes.relicIdToInt k, e )
                  )
                  l
             )
        )


map : (GameObjectTypes.RelicId -> a -> b) -> RelicDict a -> RelicDict b
map f d =
    case d of
        RelicDict dict ->
            RelicDict
                (Dict.map
                     (\mapUnpack ->
                          \unpack ->
                              case unpack of
                                  ( k, a ) ->
                                      ( k, f k a )
                     )
                     dict
                )


foldl : (GameObjectTypes.RelicId -> v -> b -> b) -> b -> RelicDict v -> b
foldl f b0 d =
    case d of
        RelicDict dict ->
            Dict.foldl
                (\_ kv b ->
                     case kv of
                         ( k, v ) ->
                             f k v b
                )
                b0
                dict


foldr : (GameObjectTypes.RelicId -> v -> b -> b) -> b -> RelicDict v -> b
foldr f b0 d =
    case d of
        RelicDict dict ->
            Dict.foldr
                (\_ kv b ->
                     case kv of
                         ( k, v ) ->
                             f k v b
                )
                b0
                dict


filter : (GameObjectTypes.RelicId -> v -> Bool) -> RelicDict v -> RelicDict v
filter f d =
    RelicDict
        (case d of
             RelicDict dict ->
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
    (GameObjectTypes.RelicId -> v -> Bool)
    -> RelicDict v
    -> ( RelicDict v, RelicDict v )
partition f d =
    case d of
        RelicDict dict ->
            Tuple.mapBoth
                RelicDict
                RelicDict
                (Dict.partition
                     (\partitionUnpack ->
                          \unpack ->
                              case unpack of
                                  ( k, v ) ->
                                      f k v
                     )
                     dict
                )