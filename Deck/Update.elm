module Deck.Update  (initialModelAndEffects, update) where

import Common.Model exposing (Card)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import List.Extra exposing (elemIndex)
import Deck.Action exposing (Action(NoOp, AddCard, RemoveCard))
import Deck.Model exposing (Model, initialModel)


initialModelAndEffects : ( Model, Effects Action )
initialModelAndEffects =
    ( initialModel
    , Effects.none
    )


update : Action -> Model -> ( Model, Effects Action )
update action model =
    case action of
        NoOp ->
            ( model, Effects.none )

        AddCard card ->
            ( model ++ [ card ], Effects.none )

        RemoveCard card ->
            ( removeFromList (elemIndex card model) model, Effects.none )

-- Remove element at index i from list
removeFromList : Maybe Int -> List Card -> List Card
removeFromList i list =
    case i of
        Just i -> (List.take i list) ++ (List.drop (i+1) list) 
        Nothing -> list
        


