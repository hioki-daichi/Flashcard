module View exposing (view)

import Html exposing (Html, div)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Healths.View


view : Model -> Html Msg
view model =
    div [] [ Html.map HealthsMsg (Healths.View.view model.health) ]
