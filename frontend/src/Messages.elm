module Messages exposing (Msg(..))

import Navigation
import Healths.Messages


type Msg
    = OnLocationChange Navigation.Location
    | HealthsMsg Healths.Messages.Msg
