module Healths.View exposing (view)

import Html exposing (Html, button, text, div)
import Html.Events exposing (onClick)
import Healths.Messages exposing (Msg(..))
import Healths.Models exposing (Health)


view : Health -> Html Msg
view health =
    div
        []
        [ button [ onClick Ping ] [ text "Ping" ]
        , div [] [ text health.time ]
        ]
