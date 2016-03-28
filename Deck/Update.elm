module Deck.Update  (initialModelAndEffects, update) where

import Common.Model exposing (Card)
import Effects exposing (Effects, Never)
import Task exposing (Task)
import Deck.Action exposing (Action(NoOp, AddCard))
import Deck.Model exposing (Model, initialModel)


initialModelAndEffects : ( Model, Effects Action )
initialModelAndEffects =
    ( initialModel
    , Effects.none
    )


update : Action -> Model -> ( Model, Effects Action)
update action model =
    case action of
        NoOp ->
            ( model, Effects.none )

        AddCard card ->
            ( model ++ [ card ], Effects.none )

