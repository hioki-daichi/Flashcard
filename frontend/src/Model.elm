module Model exposing (Model, Health, initialModel)


type alias Model =
    String


type alias Health =
    { time : String
    }


initialModel : Model
initialModel =
    "Init"
