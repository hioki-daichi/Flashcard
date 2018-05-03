module Books.List exposing (view)

import Html exposing (Html, div, text, ul, li, a, form, input, button)
import Html.Attributes exposing (type_, name)
import Html.Events exposing (onClick, onInput)
import Books.Models exposing (Book)
import Books.Messages exposing (Msg(..))


view : List Book -> Html Msg
view books =
    div []
        [ bookForm
        , ul [] (List.map bookRow books)
        ]


bookRow : Book -> Html Msg
bookRow book =
    li [] [ a [ onClick (ShowBook book.id) ] [ text book.title ] ]


bookForm : Html Msg
bookForm =
    form []
        [ input [ type_ "text", name "title", onInput NewBookTitle ] []
        , button [ type_ "submit", onClick CreateBook ] [ text "Submit" ]
        ]
