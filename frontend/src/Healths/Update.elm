module Healths.Update exposing (update)

import Http
import Json.Decode
import Healths.Models exposing (Model, Health)
import Healths.Messages exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ping ->
            ( model, Http.get "http://localhost:8080/ping" healthDecoder |> Http.send OnPing )

        OnPing (Ok health) ->
            ( health.time, Cmd.none )

        OnPing (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
                ( model, Cmd.none )


healthDecoder : Json.Decode.Decoder Health
healthDecoder =
    Json.Decode.map2 Health (Json.Decode.field "id" Json.Decode.int) (Json.Decode.field "time" Json.Decode.string)
