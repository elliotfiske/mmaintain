module ListBuilder exposing (..)


concatMaybe : Maybe (List a) -> List a -> List a
concatMaybe maybe list =
    case maybe of
        Just toConcat ->
            list ++ toConcat

        Nothing ->
            list


add : a -> List a -> List a
add value list =
    value :: list


addMaybe : Maybe a -> List a -> List a
addMaybe maybe list =
    case maybe of
        Just toAdd ->
            toAdd :: list

        Nothing ->
            list


addIf : Bool -> a -> List a -> List a
addIf doAdd value list =
    if doAdd then
        value :: list

    else
        list


addIfMatches : (a -> Bool) -> a -> List a -> List a
addIfMatches predicate value list =
    if predicate value then
        value :: list

    else
        list
