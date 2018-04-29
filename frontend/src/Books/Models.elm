module Books.Models exposing (Book, Page)


type alias Book =
    { id : Int
    , title : String
    }


type alias Page =
    { question : String
    , answer : String
    }
