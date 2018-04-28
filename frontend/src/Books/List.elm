module Books.List exposing (view)

import Html exposing (Html, div, text, ul, li)
import Books.Models exposing (Book)
import Books.Messages exposing (Msg(..))


view : List Book -> Html Msg
view books =
    div [] [ ul [] (List.map bookRow books) ]


bookRow : Book -> Html Msg
bookRow book =
    li [] [ text book.title ]
