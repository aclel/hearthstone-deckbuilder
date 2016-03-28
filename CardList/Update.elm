module CardList.Update (update) where

import Common.Model exposing (Card)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import CardList.Action exposing (Action(NoOp, LoadList, ShowList, CardClicked, CardAdded, CardRemoved ))
import CardList.Model exposing (Model, initialModel)


type alias Services =
    { loadCards : Task Never Model
    , signalUpdatedList : List Card -> Action -> Effects Action
    , signalCardClicked : Card -> Action -> Effects Action
    }

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

        CardClicked card ->
            ( model, services.signalCardClicked card NoOp )

        CardAdded card ->
            let 
                updatedCards = incrementCopies model.cards card
            in
                ( { model | cards = updatedCards, message = "" } , Effects.none)

        CardRemoved card ->
            let 
                updatedCards = decrementCopies model.cards card
            in
                ( { model | cards = updatedCards, message = "" } , Effects.none)



-- Increment the number of copies of the given card, up to the maxCopies
incrementCopies : List Card -> Card -> List Card
incrementCopies cards card =
    let
        updateNumCopies c =
            if c.cardId == card.cardId  && card.numCopies < card.maxCopies then
                { c | numCopies = c.numCopies + 1 }
            else
                c
    in
        List.map updateNumCopies cards

-- Decrement the number of copies of the given card, ensuring it remains >= 0
decrementCopies : List Card -> Card -> List Card
decrementCopies cards card =
    let
        updateNumCopies c =
            if c.cardId == card.cardId && c.numCopies > 0 then
                { c | numCopies = c.numCopies - 1 }
            else
                c
    in
        List.map updateNumCopies cards




