module DeckBuilderMain (deckBuilderMainFeature) where

import Common.Model exposing (Card, testCard)
import Effects exposing (Never)
import Html exposing (Html, div)
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

deckBuilderMainView : Html -> Html -> Html
deckBuilderMainView cardListView deckView =
    div
        []
        [ cardListView
        , deckView
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
