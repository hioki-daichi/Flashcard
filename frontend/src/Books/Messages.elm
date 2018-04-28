module Books.Messages exposing (Msg(..))

import Http
import Books.Models exposing (Book)


type Msg
    = ShowBooks
    | OnFetchBooks (Result Http.Error (List Book))
