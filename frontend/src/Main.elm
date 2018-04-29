module Main exposing (main)

import Navigation
import Routing
import Healths.Commands exposing (ping)
import Books.Commands exposing (fetchBooks, fetchPagesByBookId)
import Models exposing (Model, initialModel)
import Messages exposing (Msg(..))
import Update exposing (update)
import View exposing (view)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location

        cmd =
            case currentRoute of
                Routing.WelcomeRoute ->
                    Cmd.none

                Routing.BooksRoute ->
                    Cmd.map BooksMsg fetchBooks

                Routing.BookRoute bookId ->
                    Cmd.map BooksMsg (fetchPagesByBookId bookId)

                Routing.HealthRoute ->
                    Cmd.map HealthsMsg ping

                Routing.NotFoundRoute ->
                    Cmd.none
    in
        ( initialModel currentRoute, cmd )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
