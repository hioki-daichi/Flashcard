module Books.Detail exposing (view)

import Html exposing (Html, div, table, tbody, tr, td, text, input)
import Html.Attributes exposing (type_, name, value)
import Books.Models exposing (Page)
import Books.Messages exposing (Msg(..))


view : List Page -> Int -> Html Msg
view pages bookId =
    div []
        [ input [ type_ "hidden", name "bookId", value (toString bookId) ] []
        , table [] [ tbody [] (List.map pageRow pages) ]
        ]


pageRow : Page -> Html Msg
pageRow page =
    tr []
        [ td [] [ text page.question ]
        , td [] [ text page.answer ]
        ]
