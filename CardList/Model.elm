module CardList.Model (Model, initialModel) where

import Common.Model exposing (Card)

type alias Model = 
    { cards : List Card
    , message : String
    }

initialModel : Model
initialModel = 
    { cards = []
    , message = "Initialising..."
    }