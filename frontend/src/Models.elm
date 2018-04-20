module Models exposing (Model, Health, initialModel)


type alias Model =
    String


type alias Health =
    { id : Int
    , time : String
    }


initialModel : Model
initialModel =
    "Init"
