module Main exposing (..)

import Html exposing (Html, div, text, program, button)
import Html.Events exposing (onClick)
import Http


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Init", Cmd.none )


type Msg
    = Ping
    | OnPing (Result Http.Error String)


view : Model -> Html Msg
view model =
    div
        []
        [ button [ onClick Ping ] [ text "Ping" ]
        , div [] [ text model ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ping ->
            ( model, Http.getString "http://localhost:8080/ping" |> Http.send OnPing )

        OnPing (Ok string) ->
            ( string, Cmd.none )

        OnPing (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
                ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
