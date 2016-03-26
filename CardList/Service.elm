module CardList.Service (loadCards) where

import Common.Model exposing (Card)
import Effects exposing (Never)
import Http exposing (Request, defaultSettings, empty, fromJson)
import Json.Decode as Json exposing ((:=))
import Task exposing (Task, map, onError, succeed)
import CardList.Model exposing (Model)


cardDecoder : Json.Decoder Card
cardDecoder =
    Json.object3 Card
        (Json.oneOf[ "cardId" := Json.string, Json.succeed "No card Id"])
        (Json.oneOf[ "name" := Json.string, Json.succeed "No name" ])
        (Json.oneOf[ "img" := Json.string, Json.succeed "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg" ])


decodeCardList : Json.Decoder (List Card)
decodeCardList = 
    Json.list cardDecoder


intoModel : List Card -> Model
intoModel cards =
    { cards = cards
    , message = ""
    }


loadCardsHttp : Task Http.Error Model
loadCardsHttp =
    Http.send Http.defaultSettings
      { verb = "GET"
      , headers = [("X-Mashape-Key", "Ufg6vwlHZ8mshvYg5E9y8Qcz4WAXp1RDcdijsnn2gcCmIav3tI")]
      , url = "https://omgvamp-hearthstone-v1.p.mashape.com/cards/sets/Basic"
      , body = Http.empty
      }
      |> Http.fromJson decodeCardList
      |> map intoModel


errorMessage : Http.Error -> Task Never Model
errorMessage =
    always (succeed { cards = [], message = "An error has occurred." })


loadCards : Task Never Model
loadCards = 
    loadCardsHttp `onError` errorMessage

