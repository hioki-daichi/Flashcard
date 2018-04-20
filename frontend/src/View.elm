module View exposing (view)

import Routing exposing (Route(..))
import Html exposing (Html, div, text, a)
import Html.Events exposing (onClick)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Healths.View


view : Model -> Html Msg
view model =
    div [] [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        WelcomeRoute ->
            welcomeView

        HealthRoute ->
            healthView model

        NotFoundRoute ->
            notFoundView


welcomeView : Html Msg
welcomeView =
    div []
        [ a [ onClick ShowHealth ] [ text "Check Health" ]
        ]


healthView : Model -> Html Msg
healthView model =
    div [] [ Html.map HealthsMsg (Healths.View.view model.health) ]


notFoundView : Html Msg
notFoundView =
    div [] [ text "Not Found" ]
