module Deck.Feature (createDeckFeature, DeckFeature) where

import Common.Model exposing (Card)
import StartApp exposing (App, start)
import Library.Util exposing (broadcast)
import Deck.Action exposing (Action)
import Deck.Model exposing (Model)
import Deck.Update exposing (initialModelAndEffects, update)
import Deck.View exposing (view)


type alias Config =
    { inputs : List (Signal.Signal Action)
    , outputs : {}
    }

type alias DeckFeature =
    App Model


createDeckFeature : Config -> DeckFeature
createDeckFeature config =
    start
        { init = initialModelAndEffects
        , update = update
        , view = view
        , inputs = config.inputs
        }
