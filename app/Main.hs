{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Web.Spock
import           Web.Spock.Config

import           Data.IORef

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
    text "pong"
