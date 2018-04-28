module Routing exposing (Route(..), parseLocation)

import Navigation exposing (Location)
import UrlParser exposing ((</>), parseHash, Parser, oneOf, map, top, s, int)


type Route
    = WelcomeRoute
    | BooksRoute
    | BookRoute Int
    | HealthRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map WelcomeRoute top
        , map BooksRoute (s "books")
        , map BookRoute (s "books" </> int)
        , map HealthRoute (s "health")
        ]


parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
