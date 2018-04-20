module Main exposing (main)

import Html exposing (program)
import Healths.Messages exposing (Msg)
import Healths.Update exposing (update)
import Healths.View exposing (view)
import Models exposing (Model, initialModel)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


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
