module GameObject exposing (..)

import DirtDict exposing (DirtDict)
import GameObjectTypes exposing (..)
import PersonDict exposing (PersonDict)
import RelicDict
import Types exposing (GameState, RealDirtDict, RealRelicDict)


movePerson : Direction -> PersonData -> PersonData
movePerson direction person =
    case direction of
        Up ->
            { person | y = person.y - 1 }

        Down ->
            { person | y = person.y + 1 }

        Left ->
            { person | x = person.x - 1 }

        Right ->
            { person | x = person.x + 1 }


pickUpRelic : PersonId -> RelicData -> RelicData
pickUpRelic personId relic =
    { relic | position = HeldBy personId }


dropRelic : PersonData -> RelicData -> RelicData
dropRelic personData relicData =
    { relicData | position = OnFloor personData.x personData.y }


createPerson : PersonId -> String -> PersonData
createPerson id name =
    { id = id
    , name = name
    , experience = 0
    , x = 0
    , y = 0
    }


movePersonWithId : PersonId -> Direction -> PersonDict PersonData -> PersonDict PersonData
movePersonWithId id direction dict =
    PersonDict.update id (Maybe.map (movePerson direction)) dict


cleanDirt : DirtData -> DirtData
cleanDirt dirt =
    { dirt | amount = dirt.amount - 1 }


setDirtAmount : Int -> DirtData -> DirtData
setDirtAmount amount dirt =
    { dirt | amount = amount }


makeDirtCleaner : DirtId -> DirtDict DirtData -> DirtDict DirtData
makeDirtCleaner id dict =
    let
        newDirt =
            Maybe.map cleanDirt (DirtDict.get id dict)
    in
    case newDirt of
        Nothing ->
            dict

        Just dirt ->
            updateDirtOrRemoveEmpty dirt dict


updateDirtOrRemoveEmpty : DirtData -> DirtDict DirtData -> DirtDict DirtData
updateDirtOrRemoveEmpty dirt dict =
    if dirt.amount <= 0 then
        DirtDict.remove dirt.id dict

    else
        DirtDict.insert dirt.id dirt dict


changeDirtAmount : DirtId -> Int -> RealDirtDict -> RealDirtDict
changeDirtAmount id amount dict =
    DirtDict.update id (Maybe.map (setDirtAmount amount)) dict


dirtIsAtLocation : Int -> Int -> GameObjectTypes.DirtData -> Bool
dirtIsAtLocation x y dirtData =
    dirtData.x == x && dirtData.y == y


getDirtAtLocation : Int -> Int -> RealDirtDict -> Maybe DirtData
getDirtAtLocation x y dict =
    dict
        |> DirtDict.values
        |> List.filter (dirtIsAtLocation x y)
        |> List.head


relicIsAtLocation : Int -> Int -> GameObjectTypes.RelicData -> Bool
relicIsAtLocation x y { position } =
    case position of
        HeldBy _ ->
            False

        OnFloor relicX relicY ->
            x == relicX && y == relicY


getRelicAtLocation : Int -> Int -> RealRelicDict -> Maybe RelicData
getRelicAtLocation x y dict =
    dict
        |> RelicDict.values
        |> List.filter (relicIsAtLocation x y)
        |> List.head


relicHolder : RelicData -> Maybe PersonId
relicHolder relic =
    case relic.position of
        HeldBy personId ->
            Just personId

        OnFloor _ _ ->
            Nothing


relicModifiesAction : RelicData -> ActionOnGamestate -> ActionOnGamestate
relicModifiesAction relic action =
    case action of
        BatchAction actions ->
            BatchAction (List.map (relicModifiesAction relic) actions)

        _ ->
            case relic.relicType of
                CleanFast ->
                    case action of
                        Clean personId _ ->
                            if Just personId == relicHolder relic then
                                BatchAction [ action, action ]

                            else
                                action

                        _ ->
                            action

                MoreXP ->
                    -- unimplemented
                    action


relicName : RelicType -> String
relicName relicType =
    case relicType of
        CleanFast ->
            "Clean Fast!"

        MoreXP ->
            "More XP!"


updateWithRelics : ActionOnGamestate -> GameState -> ActionOnGamestate
updateWithRelics action state =
    RelicDict.values state.relicDict
        |> List.foldl relicModifiesAction action


internalExecuteActionOnGameState : ActionOnGamestate -> GameState -> GameState
internalExecuteActionOnGameState action state =
    case action of
        Clean _ dirtId ->
            { state | dirtDict = makeDirtCleaner dirtId state.dirtDict }

        MovePerson personId direction ->
            { state | personDict = movePersonWithId personId direction state.personDict }

        AddPerson personData ->
            { state | personDict = PersonDict.insert personData.id personData state.personDict }

        PickUpRelic relicId personId ->
            { state | relicDict = RelicDict.update relicId (Maybe.map (pickUpRelic personId)) state.relicDict }

        DropRelic relicId personId ->
            let
                maybeDropper =
                    PersonDict.get personId state.personDict

                maybeRelic =
                    RelicDict.get relicId state.relicDict
            in
            -- TODO: Cool helper function like "return state unchanged if either of these are Nothing, otherwise execute update". I think I may do this a lot.
            case ( maybeDropper, maybeRelic ) of
                ( Just dropper, Just relic ) ->
                    { state | relicDict = RelicDict.insert relicId (dropRelic dropper relic) state.relicDict }

                _ ->
                    state

        ChangeDirtAmount dirtId int ->
            { state | dirtDict = changeDirtAmount dirtId int state.dirtDict }

        AddDirt dirtData ->
            { state | dirtDict = DirtDict.insert dirtData.id dirtData state.dirtDict }

        AddRelic relicData ->
            { state | relicDict = RelicDict.insert relicData.id relicData state.relicDict }

        BatchAction actionList ->
            List.foldl internalExecuteActionOnGameState state actionList

        GameStateNoOp ->
            state


executeActionOnGameState : ActionOnGamestate -> GameState -> GameState
executeActionOnGameState actionOnGamestate state =
    internalExecuteActionOnGameState (updateWithRelics actionOnGamestate state) state
