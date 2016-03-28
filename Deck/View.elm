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
    li  []
        [ h2 [] [text ((toString card.cost) ++ " " ++ card.name)] ]



view : Signal.Address Action -> Model -> Html
view address model =
    div [ deckList ]
        [
            h2 [] [text "Deck List"],
            ul []
                (List.map (renderCard address) model)
        ]

deckList : Attribute
deckList =
    style
    [ "width" => "30%"
    , "float" => "right"
    ]