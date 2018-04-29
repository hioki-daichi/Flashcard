module Healths.Commands exposing (ping)

import Http
import Json.Decode
import Healths.Models exposing (Health)
import Healths.Messages exposing (Msg(..))
import Util exposing (baseUrl)


ping : Cmd Msg
ping =
    Http.get (baseUrl ++ "/ping") healthDecoder |> Http.send OnPing


healthDecoder : Json.Decode.Decoder Health
healthDecoder =
    Json.Decode.map2 Health (Json.Decode.field "id" Json.Decode.int) (Json.Decode.field "time" Json.Decode.string)
