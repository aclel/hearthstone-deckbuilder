module Deck.Model (Model, initialModel) where

import Common.Model exposing (Card)

type alias Model = List Card

initialModel : Model
initialModel = 
    []