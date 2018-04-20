module Update exposing (update)

import Navigation
import Routing
import Models exposing (Model)
import Messages exposing (Msg(..))
import Healths.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                route =
                    Routing.parseLocation location
            in
                ( { model | route = route }, Cmd.none )

        ShowHealth ->
            ( model, Navigation.newUrl "#health" )

        HealthsMsg subMsg ->
            let
                ( updatedModel, cmd ) =
                    Healths.Update.update subMsg model
            in
                ( updatedModel, Cmd.map HealthsMsg cmd )
