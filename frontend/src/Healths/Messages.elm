module Healths.Messages exposing (Msg(..))

import Http
import Healths.Models exposing (Health)


type Msg
    = OnPing (Result Http.Error Health)
