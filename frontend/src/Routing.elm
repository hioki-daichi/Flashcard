module Routing exposing (Route(..), parseLocation)

import Navigation exposing (Location)
import UrlParser exposing (parseHash, Parser, oneOf, map, top, s)


type Route
    = WelcomeRoute
    | HealthRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map WelcomeRoute top
        , map HealthRoute (s "health")
        ]


parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
