module PersonDict exposing
    ( empty, singleton, insert, update, remove
    , PersonDict
    , keys, values, toList, fromList
    , isEmpty, member, get, size
    , map, foldl, foldr, filter, partition
    )

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
import GameObjectIds


type PersonDict v
    = PersonDict (Dict.Dict Int ( GameObjectIds.PersonId, v ))


empty : PersonDict v
empty =
    PersonDict Dict.empty


singleton : GameObjectIds.PersonId -> v -> PersonDict v
singleton key value =
    PersonDict
        (Dict.singleton (GameObjectIds.personIdToInt key) ( key, value ))


insert : GameObjectIds.PersonId -> v -> PersonDict v -> PersonDict v
insert key value d =
    case d of
        PersonDict dict ->
            PersonDict
                (Dict.insert
                    (GameObjectIds.personIdToInt key)
                    ( key, value )
                    dict
                )


update :
    GameObjectIds.PersonId
    -> (Maybe b -> Maybe b)
    -> PersonDict b
    -> PersonDict b
update key f d =
    case d of
        PersonDict dict ->
            PersonDict
                (Dict.update
                    (GameObjectIds.personIdToInt key)
                    (\updateUnpack ->
                        Maybe.map
                            (Tuple.pair key)
                            (f (Maybe.map Tuple.second updateUnpack))
                    )
                    dict
                )


remove : GameObjectIds.PersonId -> PersonDict v -> PersonDict v
remove key d =
    case d of
        PersonDict dict ->
            PersonDict (Dict.remove (GameObjectIds.personIdToInt key) dict)


isEmpty : PersonDict v -> Bool
isEmpty d =
    case d of
        PersonDict dict ->
            Dict.isEmpty dict


member : GameObjectIds.PersonId -> PersonDict v -> Bool
member key d =
    case d of
        PersonDict dict ->
            Dict.member (GameObjectIds.personIdToInt key) dict


get : GameObjectIds.PersonId -> PersonDict b -> Maybe b
get key d =
    case d of
        PersonDict dict ->
            Maybe.map
                Tuple.second
                (Dict.get (GameObjectIds.personIdToInt key) dict)


size : PersonDict v -> Int
size d =
    case d of
        PersonDict dict ->
            Dict.size dict


keys : PersonDict v -> List GameObjectIds.PersonId
keys d =
    case d of
        PersonDict dict ->
            List.map Tuple.first (Dict.values dict)


values : PersonDict v -> List v
values d =
    case d of
        PersonDict dict ->
            List.map Tuple.second (Dict.values dict)


toList : PersonDict v -> List ( GameObjectIds.PersonId, v )
toList d =
    case d of
        PersonDict dict ->
            Dict.values dict


fromList : List ( GameObjectIds.PersonId, v ) -> PersonDict v
fromList l =
    PersonDict
        (Dict.fromList
            (List.map
                (\e ->
                    case e of
                        ( k, v ) ->
                            ( GameObjectIds.personIdToInt k, e )
                )
                l
            )
        )


map : (GameObjectIds.PersonId -> a -> b) -> PersonDict a -> PersonDict b
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


foldl : (GameObjectIds.PersonId -> v -> b -> b) -> b -> PersonDict v -> b
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


foldr : (GameObjectIds.PersonId -> v -> b -> b) -> b -> PersonDict v -> b
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


filter : (GameObjectIds.PersonId -> v -> Bool) -> PersonDict v -> PersonDict v
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
    (GameObjectIds.PersonId -> v -> Bool)
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
