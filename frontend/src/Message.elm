module Message exposing (Msg(..))

import Http
import Model exposing (Health)


type Msg
    = Ping
    | OnPing (Result Http.Error Health)
