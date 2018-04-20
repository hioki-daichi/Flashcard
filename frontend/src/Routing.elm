module Routing exposing (Route(..), parseLocation)

import Navigation exposing (Location)
import UrlParser


type Route
    = WelcomeRoute
    | HealthRoute
    | NotFoundRoute


matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.map WelcomeRoute UrlParser.top
        , UrlParser.map HealthRoute (UrlParser.s "ping")
        ]


parseLocation : Location -> Route
parseLocation location =
    case UrlParser.parseHash matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
