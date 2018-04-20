module Messages exposing (Msg(..))

import Navigation
import Healths.Messages


type Msg
    = OnLocationChange Navigation.Location
    | ShowPing
    | HealthsMsg Healths.Messages.Msg
