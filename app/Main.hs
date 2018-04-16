{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Monad.IO.Class (liftIO)
import           Data.IORef
import           Model.Health
import           Web.Spock
import           Web.Spock.Config

data MySession =
  EmptySession

newtype MyAppState =
  DummyAppState (IORef Int)

main :: IO ()
main = do
  ref <- newIORef 0
  spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
  runSpock 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
  get "ping" $ do
    setHeader "Access-Control-Allow-Origin" "http://localhost:3000"
    health <- liftIO touchHealth
    json health
