module Models exposing (Model, initialModel)

import Routing
import Books.Models exposing (Book, NewBook, Page)
import Healths.Models exposing (Health)


type alias Model =
    { route : Routing.Route
    , health : Health
    , books : List Book
    , newBook : NewBook
    , pages : List Page
    }


initialModel : Routing.Route -> Model
initialModel route =
    { route = route
    , health = Health 0 ""
    , books = []
    , newBook = NewBook ""
    , pages = []
    }
