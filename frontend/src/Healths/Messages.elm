module Messages exposing (Msg(..))

import Http
import Models exposing (Health)


type Msg
    = Ping
    | OnPing (Result Http.Error Health)
