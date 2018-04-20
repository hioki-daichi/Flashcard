module Healths.Commands exposing (..)

import Http
import Json.Decode
import Healths.Models exposing (Health)
import Healths.Messages exposing (Msg(..))


ping : Cmd Msg
ping =
    Http.get "http://localhost:8080/ping" healthDecoder |> Http.send OnPing


healthDecoder : Json.Decode.Decoder Health
healthDecoder =
    Json.Decode.map2 Health (Json.Decode.field "id" Json.Decode.int) (Json.Decode.field "time" Json.Decode.string)
