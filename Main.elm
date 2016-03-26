module Main (..) where

import DeckBuilderMain exposing (deckBuilderMainFeature)
import Effects exposing (Never)
import Html exposing (Html)
import Task exposing (Task)

main : Signal Html
main =
    deckBuilderMainFeature.html

port tasks : Signal (Task Never ())
port tasks = 
    deckBuilderMainFeature.tasks