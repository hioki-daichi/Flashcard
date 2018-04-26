module Healths.View exposing (view)

import Html exposing (Html, text, div)
import Healths.Messages exposing (Msg(..))
import Healths.Models exposing (Health)


view : Health -> Html Msg
view health =
    div [] [ text health.time ]
