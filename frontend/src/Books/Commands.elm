module Books.Commands exposing (fetchBooks, fetchPagesByBookId, postBook)

import Http
import Json.Decode
import Books.Models exposing (Book, Page)
import Books.Messages exposing (Msg(..))
import Util exposing (baseUrl)


fetchBooks : Cmd Msg
fetchBooks =
    Http.get (baseUrl ++ "/books") booksDecoder
        |> Http.send OnFetchBooks


fetchPagesByBookId : Int -> Cmd Msg
fetchPagesByBookId bookId =
    Http.get (baseUrl ++ "/books/" ++ toString bookId ++ "/pages") pagesDecoder
        |> Http.send OnFetchPages


postBook : Int -> String -> Cmd Msg
postBook userId title =
    let
        body =
            Http.stringBody "application/x-www-form-urlencoded" ("userId=" ++ toString userId ++ "&title=" ++ title)

        request =
            Http.post (baseUrl ++ "/books") body booksDecoder
    in
        Http.send OnCreateBook request


booksDecoder : Json.Decode.Decoder (List Book)
booksDecoder =
    Json.Decode.list bookDecoder


bookDecoder : Json.Decode.Decoder Book
bookDecoder =
    Json.Decode.map2 Book (Json.Decode.field "id" Json.Decode.int) (Json.Decode.field "title" Json.Decode.string)


pagesDecoder : Json.Decode.Decoder (List Page)
pagesDecoder =
    Json.Decode.list pageDecoder


pageDecoder : Json.Decode.Decoder Page
pageDecoder =
    Json.Decode.map2 Page (Json.Decode.field "question" Json.Decode.string) (Json.Decode.field "answer" Json.Decode.string)
