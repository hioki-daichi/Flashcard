module Books.Messages exposing (Msg(..))

import Http
import Books.Models exposing (Book, Page)


type Msg
    = ShowBooks
    | OnFetchBooks (Result Http.Error (List Book))
    | ShowBook Int
    | OnFetchPages (Result Http.Error (List Page))
