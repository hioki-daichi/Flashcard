module Messages exposing (Msg(..))

import Navigation
import Healths.Messages


type Msg
    = OnLocationChange Navigation.Location
    | ShowHealth
    | HealthsMsg Healths.Messages.Msg
