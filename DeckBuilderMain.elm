module DeckBuilderMain (deckBuilderMainFeature) where

import Common.Model exposing (Card, testCard)
import Effects exposing (Never)
import Html exposing (..)
import Html.Attributes exposing (style, src)
import Task exposing (Task)
import CardList.Action exposing (Action(ShowList))
import CardList.Feature exposing (CardListFeature, createCardListFeature)
import CardList.Model exposing (initialModel)
import Deck.Action exposing (Action(AddCard))
import Deck.Feature exposing (DeckFeature, createDeckFeature)
import Deck.Model exposing (initialModel)

cardListMailbox : Signal.Mailbox CardList.Action.Action
cardListMailbox = 
    Signal.mailbox (ShowList CardList.Model.initialModel)

deckMailbox : Signal.Mailbox Deck.Action.Action
deckMailbox =
    Signal.mailbox (AddCard testCard)

cardListFeature : CardListFeature
cardListFeature = 
    createCardListFeature
        { inputs = [ cardListMailbox.signal ]
        , outputs = 
            { onCardClicked = [ Signal.forwardTo deckMailbox.address AddCard ]
            , onUpdatedList = []
            }
        }

deckFeature : DeckFeature
deckFeature =
    createDeckFeature
        { inputs = [ deckMailbox.signal ]
        , outputs =
            { }
        }

-- Allow the use of => operator when defining styles
(=>) = (,)

deckBuilderMainView : Html -> Html -> Html
deckBuilderMainView cardListView deckView =
    div
        []
        [
            banner,
            div []
            [cardListView
            , deckView
            ]
        ]

banner : Html
banner =
    div 
        [ bannerStyle ]
        [
            logo "assets/hearthstone_logo.png"
        ]

bannerStyle : Attribute
bannerStyle =
    style
        [ "width" => "100%"
        , "height" => "120px"
        , "padding-top" => "10px"
        , "padding-bottom" => "10px"
        , "background-color" => "#000"
        , "display" => "flex"
        , "align-items" => "center"
        , "justify-content" => "center"
        ]


logo : String -> Html
logo url =
    img [ src url, logoStyle] []

logoStyle : Attribute
logoStyle =
    style 
        [ "width" => "30%"
        ]

html : Signal Html
html =
    Signal.map2 deckBuilderMainView cardListFeature.html deckFeature.html

tasks : Signal (Task Never ())
tasks =
    Signal.mergeMany
        [ cardListFeature.tasks
        ]

deckBuilderMainFeature = 
    { html = html
    , tasks = tasks}
