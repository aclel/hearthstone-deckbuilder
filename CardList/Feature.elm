module CardList.Feature (CardListFeature, createCardListFeature) where

import Common.Model exposing (Card)
import StartApp exposing (App, start)
import Library.Util exposing (broadcast)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import CardList.Action exposing (Action(..))
import CardList.Model exposing (Model, initialModel)
import CardList.Service exposing (loadCards)
import CardList.Update exposing (update)
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


-- Loads the cards when the app is initialised
initialModelAndEffects : ( Model, Effects Action )
initialModelAndEffects = 
    ( initialModel, Effects.task (loadCards |> Task.map ShowList) )


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

