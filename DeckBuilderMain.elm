module DeckBuilderMain (deckBuilderMainFeature) where

import Common.Model exposing (Card)
import Effects exposing (Never)
import Html exposing (Html, div)
import Task exposing (Task)
import CardList.Action exposing (Action(ShowList))
import CardList.Feature exposing (CardListFeature, createCardListFeature)
import CardList.Model exposing (initialModel)

cardListMailbox : Signal.Mailbox CardList.Action.Action
cardListMailbox = 
    Signal.mailbox (ShowList CardList.Model.initialModel)

cardListFeature : CardListFeature
cardListFeature = 
    createCardListFeature
        { inputs = [ cardListMailbox.signal ]
        , outputs = 
            { onUpdatedList = []
            }
        }

deckBuilderMainView : Html -> Html
deckBuilderMainView cardListView =
    div
        []
        [ cardListView
        ]

html : Signal Html
html =
    Signal.map deckBuilderMainView cardListFeature.html

tasks : Signal (Task Never ())
tasks =
    Signal.mergeMany
        [ cardListFeature.tasks
        ]

deckBuilderMainFeature = 
    { html = html
    , tasks = tasks}