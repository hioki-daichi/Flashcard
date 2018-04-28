module Books.Commands exposing (fetchBooks)

import Http
import Json.Decode
import Books.Models exposing (Book)
import Books.Messages exposing (Msg(..))
import Util exposing (baseUrl)


fetchBooks : Cmd Msg
fetchBooks =
    Http.get (baseUrl ++ "/books") booksDecoder
        |> Http.send OnFetchBooks


booksDecoder : Json.Decode.Decoder (List Book)
booksDecoder =
    Json.Decode.list bookDecoder


bookDecoder : Json.Decode.Decoder Book
bookDecoder =
    Json.Decode.map2 Book (Json.Decode.field "id" Json.Decode.int) (Json.Decode.field "title" Json.Decode.string)
