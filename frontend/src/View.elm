module View exposing (view)

import Routing exposing (Route(..))
import Html exposing (Html, div, text, a, ul, li)
import Html.Events exposing (onClick)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Healths.Messages
import Healths.View
import Books.Messages
import Books.List


view : Model -> Html Msg
view model =
    div [] [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        WelcomeRoute ->
            welcomeView

        BooksRoute ->
            booksView model

        HealthRoute ->
            healthView model

        NotFoundRoute ->
            notFoundView


welcomeView : Html Msg
welcomeView =
    div []
        [ ul []
            [ li [] [ a [ onClick (HealthsMsg Healths.Messages.ShowHealth) ] [ text "Health" ] ]
            , li [] [ a [ onClick (BooksMsg Books.Messages.ShowBooks) ] [ text "Books" ] ]
            ]
        ]


booksView : Model -> Html Msg
booksView model =
    div [] [ Html.map BooksMsg (Books.List.view model.books) ]


healthView : Model -> Html Msg
healthView model =
    div [] [ Html.map HealthsMsg (Healths.View.view model.health) ]


notFoundView : Html Msg
notFoundView =
    div [] [ text "Not Found" ]
