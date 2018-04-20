module Healths.Update exposing (update)

import Healths.Messages exposing (Msg(..))
import Healths.Commands exposing (ping)
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ping ->
            ( model, ping )

        OnPing (Ok health) ->
            ( { model | health = health }, Cmd.none )

        OnPing (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
                ( model, Cmd.none )
