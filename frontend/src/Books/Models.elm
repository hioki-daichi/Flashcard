module Books.Models exposing (Book, NewBook, Page)


type alias Book =
    { id : Int
    , title : String
    }


type alias NewBook =
    { title : String
    }


type alias Page =
    { question : String
    , answer : String
    }
