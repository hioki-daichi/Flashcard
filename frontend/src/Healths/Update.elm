module Healths.Update exposing (update)

import Healths.Models exposing (Model, Health)
import Healths.Messages exposing (Msg(..))
import Healths.Commands exposing (ping)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ping ->
            ( model, ping )

        OnPing (Ok health) ->
            ( health.time, Cmd.none )

        OnPing (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
                ( model, Cmd.none )
