module RelicDict exposing
    ( empty, singleton, insert, update, remove
    , RelicDict
    , keys, values, toList, fromList
    , isEmpty, member, get, size
    , map, foldl, foldr, filter, partition
    )

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
import GameObjectIds


type RelicDict v
    = RelicDict (Dict.Dict Int ( GameObjectIds.RelicId, v ))


empty : RelicDict v
empty =
    RelicDict Dict.empty


singleton : GameObjectIds.RelicId -> v -> RelicDict v
singleton key value =
    RelicDict (Dict.singleton (GameObjectIds.relicIdToInt key) ( key, value ))


insert : GameObjectIds.RelicId -> v -> RelicDict v -> RelicDict v
insert key value d =
    case d of
        RelicDict dict ->
            RelicDict
                (Dict.insert
                    (GameObjectIds.relicIdToInt key)
                    ( key, value )
                    dict
                )


update :
    GameObjectIds.RelicId
    -> (Maybe b -> Maybe b)
    -> RelicDict b
    -> RelicDict b
update key f d =
    case d of
        RelicDict dict ->
            RelicDict
                (Dict.update
                    (GameObjectIds.relicIdToInt key)
                    (\updateUnpack ->
                        Maybe.map
                            (Tuple.pair key)
                            (f (Maybe.map Tuple.second updateUnpack))
                    )
                    dict
                )


remove : GameObjectIds.RelicId -> RelicDict v -> RelicDict v
remove key d =
    case d of
        RelicDict dict ->
            RelicDict (Dict.remove (GameObjectIds.relicIdToInt key) dict)


isEmpty : RelicDict v -> Bool
isEmpty d =
    case d of
        RelicDict dict ->
            Dict.isEmpty dict


member : GameObjectIds.RelicId -> RelicDict v -> Bool
member key d =
    case d of
        RelicDict dict ->
            Dict.member (GameObjectIds.relicIdToInt key) dict


get : GameObjectIds.RelicId -> RelicDict b -> Maybe b
get key d =
    case d of
        RelicDict dict ->
            Maybe.map
                Tuple.second
                (Dict.get (GameObjectIds.relicIdToInt key) dict)


size : RelicDict v -> Int
size d =
    case d of
        RelicDict dict ->
            Dict.size dict


keys : RelicDict v -> List GameObjectIds.RelicId
keys d =
    case d of
        RelicDict dict ->
            List.map Tuple.first (Dict.values dict)


values : RelicDict v -> List v
values d =
    case d of
        RelicDict dict ->
            List.map Tuple.second (Dict.values dict)


toList : RelicDict v -> List ( GameObjectIds.RelicId, v )
toList d =
    case d of
        RelicDict dict ->
            Dict.values dict


fromList : List ( GameObjectIds.RelicId, v ) -> RelicDict v
fromList l =
    RelicDict
        (Dict.fromList
            (List.map
                (\e ->
                    case e of
                        ( k, v ) ->
                            ( GameObjectIds.relicIdToInt k, e )
                )
                l
            )
        )


map : (GameObjectIds.RelicId -> a -> b) -> RelicDict a -> RelicDict b
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


foldl : (GameObjectIds.RelicId -> v -> b -> b) -> b -> RelicDict v -> b
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


foldr : (GameObjectIds.RelicId -> v -> b -> b) -> b -> RelicDict v -> b
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


filter : (GameObjectIds.RelicId -> v -> Bool) -> RelicDict v -> RelicDict v
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
    (GameObjectIds.RelicId -> v -> Bool)
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
