module CardList.View (view) where

import Common.Model exposing (Card)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import CardList.Model exposing (Model)
import CardList.Action exposing (Action(LoadList, CardClicked))

-- Allow the use of => operator when defining styles
(=>) = (,)

renderCard : Signal.Address Action -> Card -> Html
renderCard address card = 
    div [ onClick address (CardClicked card)] 
    [ h2 [headerStyle] [text card.name]
    , div [imgStyle card.img] []
    ]

headerStyle : Attribute
headerStyle =
  style
    [ "width" => "200px"
    , "text-align" => "center"
    ]


imgStyle : String -> Attribute
imgStyle url =
  style
    [ "display" => "inline-block"
    , "width" => "300px"
    , "height" => "300px"
    , "background-position" => "center center"
    , "background-size" => "cover"
    , "background-image" => ("url('" ++ url ++ "')")
    ]


view : Signal.Address Action -> Model -> Html
view address model =
    div [ cardList ]
        [ div [ style [ "display" => "flex", "flex-wrap" => "wrap" ] ]
            (List.map (renderCard address) model.cards)
        ]


cardList : Attribute
cardList =
    style
      ["width" => "70%"
      ,"float" => "left"
      ,"height" => "768px"
      ,"overflow-y" => "auto"
      ]