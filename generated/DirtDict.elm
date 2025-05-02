module DirtDict exposing
    ( empty, singleton, insert, update, remove
    , DirtDict
    , keys, values, toList, fromList
    , isEmpty, member, get, size
    , map, foldl, foldr, filter, partition
    )

{-|


## Build

@docs empty, singleton, insert, update, remove


## Dictionaries

@docs DirtDict


## Lists

@docs keys, values, toList, fromList


## Query

@docs isEmpty, member, get, size


## Transform

@docs map, foldl, foldr, filter, partition

-}

import Dict
import GameObjectIds


type DirtDict v
    = DirtDict (Dict.Dict Int ( GameObjectIds.DirtId, v ))


empty : DirtDict v
empty =
    DirtDict Dict.empty


singleton : GameObjectIds.DirtId -> v -> DirtDict v
singleton key value =
    DirtDict (Dict.singleton (GameObjectIds.dirtIdToInt key) ( key, value ))


insert : GameObjectIds.DirtId -> v -> DirtDict v -> DirtDict v
insert key value d =
    case d of
        DirtDict dict ->
            DirtDict
                (Dict.insert
                    (GameObjectIds.dirtIdToInt key)
                    ( key, value )
                    dict
                )


update : GameObjectIds.DirtId -> (Maybe b -> Maybe b) -> DirtDict b -> DirtDict b
update key f d =
    case d of
        DirtDict dict ->
            DirtDict
                (Dict.update
                    (GameObjectIds.dirtIdToInt key)
                    (\updateUnpack ->
                        Maybe.map
                            (Tuple.pair key)
                            (f (Maybe.map Tuple.second updateUnpack))
                    )
                    dict
                )


remove : GameObjectIds.DirtId -> DirtDict v -> DirtDict v
remove key d =
    case d of
        DirtDict dict ->
            DirtDict (Dict.remove (GameObjectIds.dirtIdToInt key) dict)


isEmpty : DirtDict v -> Bool
isEmpty d =
    case d of
        DirtDict dict ->
            Dict.isEmpty dict


member : GameObjectIds.DirtId -> DirtDict v -> Bool
member key d =
    case d of
        DirtDict dict ->
            Dict.member (GameObjectIds.dirtIdToInt key) dict


get : GameObjectIds.DirtId -> DirtDict b -> Maybe b
get key d =
    case d of
        DirtDict dict ->
            Maybe.map
                Tuple.second
                (Dict.get (GameObjectIds.dirtIdToInt key) dict)


size : DirtDict v -> Int
size d =
    case d of
        DirtDict dict ->
            Dict.size dict


keys : DirtDict v -> List GameObjectIds.DirtId
keys d =
    case d of
        DirtDict dict ->
            List.map Tuple.first (Dict.values dict)


values : DirtDict v -> List v
values d =
    case d of
        DirtDict dict ->
            List.map Tuple.second (Dict.values dict)


toList : DirtDict v -> List ( GameObjectIds.DirtId, v )
toList d =
    case d of
        DirtDict dict ->
            Dict.values dict


fromList : List ( GameObjectIds.DirtId, v ) -> DirtDict v
fromList l =
    DirtDict
        (Dict.fromList
            (List.map
                (\e ->
                    case e of
                        ( k, v ) ->
                            ( GameObjectIds.dirtIdToInt k, e )
                )
                l
            )
        )


map : (GameObjectIds.DirtId -> a -> b) -> DirtDict a -> DirtDict b
map f d =
    case d of
        DirtDict dict ->
            DirtDict
                (Dict.map
                    (\mapUnpack ->
                        \unpack ->
                            case unpack of
                                ( k, a ) ->
                                    ( k, f k a )
                    )
                    dict
                )


foldl : (GameObjectIds.DirtId -> v -> b -> b) -> b -> DirtDict v -> b
foldl f b0 d =
    case d of
        DirtDict dict ->
            Dict.foldl
                (\_ kv b ->
                    case kv of
                        ( k, v ) ->
                            f k v b
                )
                b0
                dict


foldr : (GameObjectIds.DirtId -> v -> b -> b) -> b -> DirtDict v -> b
foldr f b0 d =
    case d of
        DirtDict dict ->
            Dict.foldr
                (\_ kv b ->
                    case kv of
                        ( k, v ) ->
                            f k v b
                )
                b0
                dict


filter : (GameObjectIds.DirtId -> v -> Bool) -> DirtDict v -> DirtDict v
filter f d =
    DirtDict
        (case d of
            DirtDict dict ->
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
    (GameObjectIds.DirtId -> v -> Bool)
    -> DirtDict v
    -> ( DirtDict v, DirtDict v )
partition f d =
    case d of
        DirtDict dict ->
            Tuple.mapBoth
                DirtDict
                DirtDict
                (Dict.partition
                    (\partitionUnpack ->
                        \unpack ->
                            case unpack of
                                ( k, v ) ->
                                    f k v
                    )
                    dict
                )
