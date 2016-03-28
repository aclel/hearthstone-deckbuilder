module CardList.Action (Action(..)) where

import Common.Model exposing (Card)
import CardList.Model exposing (Model)

type Action
 = NoOp
 | LoadList
 | ShowList Model
 | CardClicked Card