module CardList.Update (initialModelAndEffects, update) where

import Common.Model exposing (Card)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import CardList.Action exposing (Action(NoOp, LoadList, ShowList))
import CardList.Model exposing (Model, initialModel)


type alias Services =
    { loadCards : Task Never Model
    , signalUpdatedList : List Card -> Action -> Effects Action
    }


initialModelAndEffects : ( Model, Effects Action )
initialModelAndEffects = 
    ( initialModel, Effects.none )


update : Services -> Action -> Model -> (Model, Effects Action)
update services action model =
    case action of
        NoOp ->
            ( model, Effects.none )

        LoadList ->
            ({ cards = []
             , message = "Loading, please wait..."
             }
            , Effects.task (services.loadCards |> Task.map ShowList)
            )

        ShowList list ->
            ( list, services.signalUpdatedList list.cards NoOp )