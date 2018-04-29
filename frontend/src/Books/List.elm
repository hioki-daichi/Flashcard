module Books.List exposing (view)

import Html exposing (Html, div, text, ul, li, a)
import Html.Events exposing (onClick)
import Books.Models exposing (Book)
import Books.Messages exposing (Msg(..))


view : List Book -> Html Msg
view books =
    div [] [ ul [] (List.map bookRow books) ]


bookRow : Book -> Html Msg
bookRow book =
    li [] [ a [ onClick (ShowBook book.id) ] [ text book.title ] ]
