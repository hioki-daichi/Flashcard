module View exposing (view)

import Html exposing (Html, button, text, div)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Message exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        []
        [ button [ onClick Ping ] [ text "Ping" ]
        , div [] [ text model ]
        ]
