module Messages exposing (Msg(..))

import Navigation
import Healths.Messages
import Books.Messages


type Msg
    = OnLocationChange Navigation.Location
    | BooksMsg Books.Messages.Msg
    | HealthsMsg Healths.Messages.Msg
