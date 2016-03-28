module CardList.Feature (CardListFeature, createCardListFeature) where

import Common.Model exposing (Card)
import StartApp exposing (App, start)
import Library.Util exposing (broadcast)
import CardList.Action exposing (Action)
import CardList.Model exposing (Model)
import CardList.Service exposing (loadCards)
import CardList.Update exposing (initialModelAndEffects, update)
import CardList.View exposing (view)

type alias Config =
    { inputs : List (Signal Action)
    , outputs :
        { onUpdatedList : List (Signal.Address (List Card))
        , onCardClicked : List (Signal.Address Card)
        }
    }

type alias CardListFeature =
    App Model

createCardListFeature : Config -> CardListFeature
createCardListFeature config =
    start
        {init = initialModelAndEffects
        , update =
            update
                { loadCards = loadCards
                , signalUpdatedList = broadcast config.outputs.onUpdatedList
                , signalCardClicked = broadcast config.outputs.onCardClicked
                }
        , view = view
        , inputs = config.inputs
        }
