module Models exposing (Model, initialModel)

import Healths.Models exposing (Health)
import Routing


type alias Model =
    { route : Routing.Route
    , health : Health
    }


initialModel : Routing.Route -> Model
initialModel route =
    { route = route
    , health = Health 0 ""
    }
