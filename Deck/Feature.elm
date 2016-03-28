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
    , outputs : 
        { onCardAdded : List (Signal.Address Card)
        , onCardRemoved : List (Signal.Address Card)
        }
    }

type alias DeckFeature =
    App Model


createDeckFeature : Config -> DeckFeature
createDeckFeature config =
    start
        { init = initialModelAndEffects
        , update =
            update
                { signalCardAdded = broadcast config.outputs.onCardAdded
                , signalCardRemoved = broadcast config.outputs.onCardRemoved
                }
        , view = view
        , inputs = config.inputs
        }
