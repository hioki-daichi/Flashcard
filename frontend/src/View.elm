module View exposing (view)

import Routing exposing (Route(..))
import Html exposing (Html, div, text)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Healths.View


view : Model -> Html Msg
view model =
    div [] [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        HealthRoute ->
            healthView model

        NotFoundRoute ->
            notFoundView


healthView : Model -> Html Msg
healthView model =
    div [] [ Html.map HealthsMsg (Healths.View.view model.health) ]


notFoundView : Html Msg
notFoundView =
    div [] [ text "Not Found" ]
