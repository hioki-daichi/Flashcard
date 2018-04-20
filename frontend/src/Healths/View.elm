module Healths.View exposing (view)

import Html exposing (Html, button, text, div)
import Html.Events exposing (onClick)
import Healths.Messages exposing (Msg(..))
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div
        []
        [ button [ onClick Ping ] [ text "Ping" ]
        , div [] [ text model.health.time ]
        ]
