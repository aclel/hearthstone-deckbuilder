module Deck.Update  (initialModelAndEffects, update) where

import Common.Model exposing (Card)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import Library.Util exposing (actionEffect)
import List.Extra exposing (elemIndex)
import Deck.Action exposing (Action(NoOp, AddCard, RemoveCard, CardAdded, CardRemoved))
import Deck.Model exposing (Model, initialModel)


type alias Services =
    { signalCardAdded : Card -> Action -> Effects Action
    , signalCardRemoved : Card -> Action -> Effects Action
    }

initialModelAndEffects : ( Model, Effects Action )
initialModelAndEffects =
    ( initialModel
    , Effects.none
    )


update : Services -> Action -> Model -> ( Model, Effects Action )
update services action model =
    case action of
        NoOp ->
            ( model, Effects.none )

        AddCard card ->
            let
                updateCards card =
                    if card.numCopies < 2 then
                        model ++ [ card ]
                    else 
                        model
            in
                ( updateCards card, actionEffect (CardAdded card) )

        RemoveCard card ->
            ( removeFromList (elemIndex card model) model, actionEffect (CardRemoved card) )

        CardAdded card ->
            ( model, services.signalCardAdded card NoOp )

        CardRemoved card ->
            ( model, services.signalCardRemoved card NoOp )


-- Remove element at index i from list
removeFromList : Maybe Int -> List Card -> List Card
removeFromList i list =
    case i of
        Just i -> (List.take i list) ++ (List.drop (i+1) list) 
        Nothing -> list
        


