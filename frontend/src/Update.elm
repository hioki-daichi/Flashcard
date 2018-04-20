module Update exposing (update)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Healths.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HealthsMsg subMsg ->
            let
                ( updatedModel, cmd ) =
                    Healths.Update.update subMsg model
            in
                ( updatedModel, Cmd.map HealthsMsg cmd )
