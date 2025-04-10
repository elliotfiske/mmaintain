module MapRenderer exposing (render)

import BaseUI as UI
import Dict
import DirtDict
import GameObject
import GameObjectTypes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import PersonDict
import Relic
import RelicDict
import Types exposing (..)
import Util


render : FrontendPlayingState -> PersonData -> Html.Html FrontendMsg
render state me =
    renderPeople state
        ++ renderDirt state
        ++ renderFloorRelics state
        ++ renderClickableLayer state
        ++ renderTooltipLayer state me
        |> Html.div [ class "order-2 md:order-none md:col-span-2 bg-green-800 relative overflow-hidden", id "main-map", tabindex 0 ]


renderPeople : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderPeople state =
    PersonDict.values state.gameState.personDict
        |> List.map (personView state.cameraPosition)


isDirtVisible : Point -> Point -> Int -> Int -> Bool
isDirtVisible cameraPosition position viewportWidth viewportHeight =
    let
        isXVisible =
            position.x >= cameraPosition.x && position.x <= cameraPosition.x + viewportWidth

        isYVisible =
            position.y >= cameraPosition.y && position.y <= cameraPosition.y + viewportHeight
    in
    isXVisible && isYVisible


getVisibleDirt : FrontendPlayingState -> List DirtData
getVisibleDirt state =
    case state.mapSize of
        Just mapSize ->
            let
                viewportSize =
                    Util.pixelsToTiles mapSize

                isVisible dirt =
                    isDirtVisible state.cameraPosition dirt.position viewportSize.x viewportSize.y
            in
            DirtDict.values state.gameState.dirtDict
                |> List.filter isVisible

        Nothing ->
            DirtDict.values state.gameState.dirtDict


renderDirt : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderDirt state =
    getVisibleDirt state
        |> List.map (dirtView state.cameraPosition)


renderFloorRelics : FrontendPlayingState -> List (Html FrontendMsg)
renderFloorRelics state =
    List.map (floorRelicView state.cameraPosition) (rarestRelicAtPoints state)


renderClickableLayer : FrontendPlayingState -> List (Html.Html FrontendMsg)
renderClickableLayer state =
    let
        mapHeightInTiles : Int
        mapHeightInTiles =
            state.mapSize
                |> Maybe.map (mapSizeInTiles >> .y)
                |> Maybe.withDefault 0
    in
    List.range 0 mapHeightInTiles
        |> List.concatMap (renderClickableTileRow state)


renderClickableTileRow : FrontendPlayingState -> Int -> List (Html.Html FrontendMsg)
renderClickableTileRow state row =
    let
        mapWidthInTiles : Int
        mapWidthInTiles =
            state.mapSize
                |> Maybe.map (mapSizeInTiles >> .x)
                |> Maybe.withDefault 0
    in
    List.range 0 mapWidthInTiles
        |> List.map (renderClickableTile state row)


renderClickableTile : FrontendPlayingState -> Int -> Int -> Html.Html FrontendMsg
renderClickableTile state row col =
    let
        point =
            { x = col, y = row }

        offsetX =
            col * Util.renderOffsetMultiplier |> String.fromInt

        offsetY =
            row * Util.renderOffsetMultiplier |> String.fromInt

        worldPoint =
            Util.addPoints state.cameraPosition point
    in
    Html.div
        [ class "absolute"
        , style "left" (offsetX ++ "px")
        , style "top" (offsetY ++ "px")
        , style "width" (String.fromInt Util.renderOffsetMultiplier ++ "px")
        , style "height" (String.fromInt Util.renderOffsetMultiplier ++ "px")
        , Html.Events.onClick (ClickTarget worldPoint)
        ]
        []


renderTooltipLayer : FrontendPlayingState -> PersonData -> List (Html.Html FrontendMsg)
renderTooltipLayer state me =
    relicsOnFloor state
        |> List.map (renderRelicTooltip state me)


renderRelicTooltip : FrontendPlayingState -> PersonData -> ( GameObjectTypes.Point, List GameObjectTypes.RelicData ) -> Html.Html FrontendMsg
renderRelicTooltip state me ( relicPileLocation, relics ) =
    let
        ( offsetX, offsetY ) =
            renderedOffset relicPileLocation state.cameraPosition

        tooltipClasses =
            "absolute invisible group-hover:visible opacity-0 group-hover:opacity-100 transition"
    in
    Html.div [ class "absolute z-50", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.div [ class "relative group" ]
            [ -- Empty space 32px by 32px for mouse event
              Html.div
                [ class "absolute left-0 top-0"
                , style "width" (String.fromInt Util.renderOffsetMultiplier ++ "px")
                , style "height" (String.fromInt Util.renderOffsetMultiplier ++ "px")
                , Html.Events.onClick (ClickTarget relicPileLocation)
                ]
                []
            , Html.div
                [ class (tooltipClasses ++ " w-64 flex flex-col")
                , style "left" "50px"
                , style "top" "0px"
                ]
                (List.map (renderRelicTooltipBody state me) relics)
            ]
        ]


renderRelicTooltipBody : FrontendPlayingState -> PersonData -> GameObjectTypes.RelicData -> Html.Html FrontendMsg
renderRelicTooltipBody state me relicData =
    let
        cardTitle =
            [ Html.div [ class "flex justify-between w-full" ]
                [ Html.text (Relic.relicName relicData.relicType) ]
            ]
    in
    UI.card "h-auto"
        cardTitle
        [ relicRarityBadge relicData.rarity
        , Html.div
            [ class "flex flex-col justify-between" ]
            (Relic.relicBody state relicData me)
        ]


relicRarityBadge : GameObjectTypes.RelicRarity -> Html msg
relicRarityBadge rarity =
    Html.div
        [ class ("badge dark:text-black " ++ Relic.relicBgColor rarity) ]
        [ Html.text (Relic.relicRarityName rarity) ]


personView : GameObjectTypes.Point -> PersonData -> Html.Html FrontendMsg
personView camera { id, name, position } =
    let
        ( offsetX, offsetY ) =
            renderedOffset position camera
    in
    Html.div [ class "absolute sprite person z-20", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        []


dirtView : GameObjectTypes.Point -> GameObjectTypes.DirtData -> Html.Html FrontendMsg
dirtView camera { position, amount } =
    let
        ( offsetX, offsetY ) =
            renderedOffset position camera
    in
    Html.div [ class "absolute text-orange-500", style "left" (offsetX ++ "px"), style "top" (offsetY ++ "px") ]
        [ Html.text (String.fromInt amount) ]


floorRelicView : GameObjectTypes.Point -> ( GameObjectTypes.Point, GameObjectTypes.RelicData ) -> Html.Html FrontendMsg
floorRelicView camera ( floorPosition, relicData ) =
    let
        ( offsetX, offsetY ) =
            renderedOffset floorPosition camera
    in
    Html.div
        [ class ("absolute sprite relic z-10 " ++ Relic.relicRarityToCssClass relicData.rarity)
        , style "left" (offsetX ++ "px")
        , style "top" (offsetY ++ "px")
        ]
        [ Html.text "" ]


relicsOnFloor : FrontendPlayingState -> List ( GameObjectTypes.Point, List GameObjectTypes.RelicData )
relicsOnFloor state =
    Dict.toList state.gameState.relicsByPosition
        |> List.filter (\( position, _ ) -> Relic.relicLocationIsOnFloor position)
        |> List.map relicLocationAndDictToFloorRelics


rarestRelicAtPoints : FrontendPlayingState -> List ( GameObjectTypes.Point, GameObjectTypes.RelicData )
rarestRelicAtPoints state =
    relicsOnFloor state
        |> List.filterMap rarestRelicAtPoint


rarestRelicAtPoint : ( GameObjectTypes.Point, List GameObjectTypes.RelicData ) -> Maybe ( GameObjectTypes.Point, GameObjectTypes.RelicData )
rarestRelicAtPoint ( point, relics ) =
    List.sortBy GameObject.byRelicRarity relics
        |> List.head
        |> Maybe.map (\relic -> ( point, relic ))


relicLocationAndDictToFloorRelics : ( Types.RelicLocation, RealRelicDict ) -> ( GameObjectTypes.Point, List GameObjectTypes.RelicData )
relicLocationAndDictToFloorRelics ( position, relicDict ) =
    ( Relic.floorRelicLocationToFloorPoint position, RelicDict.values relicDict )


renderedOffset : GameObjectTypes.Point -> GameObjectTypes.Point -> ( String, String )
renderedOffset objectPosition cameraOffset =
    ( (objectPosition.x - cameraOffset.x)
        * Util.renderOffsetMultiplier
        |> String.fromInt
    , (objectPosition.y - cameraOffset.y)
        * Util.renderOffsetMultiplier
        |> String.fromInt
    )


mapSizeInTiles : { width : Float, height : Float } -> GameObjectTypes.Point
mapSizeInTiles { width, height } =
    { x = truncate (width / toFloat Util.renderOffsetMultiplier)
    , y = truncate (height / toFloat Util.renderOffsetMultiplier)
    }
