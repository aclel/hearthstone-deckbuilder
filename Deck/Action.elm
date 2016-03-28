module Deck.Action (Action(..)) where

import Common.Model exposing (Card)
import Deck.Model exposing (Model)

type Action 
    = NoOp
    | AddCard Card -- Triggered from outside Deck
    | RemoveCard Card
    | CardAdded Card
    | CardRemoved Card
