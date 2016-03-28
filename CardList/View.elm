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
    [ div [imgStyle card.img] []
    , div [] 
        [text (toString card.numCopies ++ "/" ++ toString card.maxCopies)
        ]
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
    , "height" => "400px"
    , "background-position" => "center center"
    , "background-size" => "cover"
    , "background-image" => ("url('" ++ url ++ "')")
    , "cursor" => "pointer"
    ]


view : Signal.Address Action -> Model -> Html
view address model =
    div []
        [ div [ messageStyle ] [ text model.message ]
        , div [ cardListStyle ]
            (List.map (renderCard address) model.cards)
        ]

messageStyle : Attribute 
messageStyle =
    style 
    [ "font-size" => "25px"
    , "font-weight" => "600"
    , "padding-left" => "10px" ]        


cardListStyle : Attribute
cardListStyle =
    style
      [ "width" => "70%"
      , "float" => "left"
      , "height" => "768px"
      , "overflow-y" => "auto"
      , "border-right" => "2px solid black"
      , "display" => "flex"
      , "flex-wrap" => "wrap"
      , "justify-content" => "space-around"
      ]