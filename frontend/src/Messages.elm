module Messages exposing (Msg(..))

import Healths.Messages


type Msg
    = HealthsMsg Healths.Messages.Msg
