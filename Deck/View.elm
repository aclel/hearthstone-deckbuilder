module Deck.View (view) where

import Common.Model exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Deck.Model exposing (Model)
import Deck.Action exposing (Action(..))


-- Allow the use of => operator when defining styles
(=>) = (,)

renderCard : Signal.Address Action -> Card -> Html
renderCard address card =
    li  [ cardStyle, onClick address (RemoveCard card) ]
        [ h2 [] [text ((toString card.cost) ++ " " ++ card.name)] ]

cardStyle : Attribute
cardStyle = 
    style
        [ "list-style-type" => "none"
        , "cursor" => "pointer"
        , "border" => "1px solid black"
        , "margin-bottom" => "2px"
        ]

view : Signal.Address Action -> Model -> Html
view address model =
    div [ deckList ]
        [
            h2 [] [text ("Deck List" ++ " (" ++ (toString (List.length model)) ++ "/30)")],
            ul [ style [ "padding-left" => "0"]]
                (List.map (renderCard address) model)
        ]

deckList : Attribute
deckList =
    style
    [ "width" => "29%"
    , "float" => "right"
    ]