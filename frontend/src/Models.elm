module Models exposing (Model, initialModel)

import Routing
import Books.Models exposing (Book)
import Healths.Models exposing (Health)


type alias Model =
    { route : Routing.Route
    , health : Health
    , books : List Book
    }


initialModel : Routing.Route -> Model
initialModel route =
    { route = route
    , health = Health 0 ""
    , books = []
    }
