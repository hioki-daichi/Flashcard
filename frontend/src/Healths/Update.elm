module Healths.Update exposing (update)

import Navigation
import Healths.Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowHealth ->
            ( model, Navigation.newUrl "#health" )

        OnPing (Ok health) ->
            ( { model | health = health }, Cmd.none )

        OnPing (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
                ( model, Cmd.none )
