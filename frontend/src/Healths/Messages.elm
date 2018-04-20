module Healths.Messages exposing (Msg(..))

import Http
import Healths.Models exposing (Health)


type Msg
    = Ping
    | OnPing (Result Http.Error Health)
