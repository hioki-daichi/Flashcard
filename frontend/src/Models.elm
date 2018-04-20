module Models exposing (Model, initialModel)

import Healths.Models exposing (Health)


type alias Model =
    { health : Health }


initialModel : Model
initialModel =
    { health = Health 0 "" }
