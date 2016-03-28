module Common.Model (Card, testCard) where

type alias Card = 
    { cardId : String
    , name : String
    , cost : Int
    , img : String
    , maxCopies : Int
    , numCopies : Int }

testCard : Card
testCard =
    {cardId = "TEST123"
    , name = "Test Card"
    , cost = 0
    , img = "http://wow.zamimg.com/images/hearthstone/cards/enus/original/HERO_09.png"
    , maxCopies = 2
    , numCopies = 0}