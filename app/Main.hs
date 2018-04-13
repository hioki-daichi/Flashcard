{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Monad.IO.Class (liftIO)
import           Data.IORef
import           Data.Monoid            ((<>))
import           Data.Text              as T
import           Data.Time.Clock
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
    currentTime <- liftIO getCurrentTime
    text $ "pong at " <> T.pack (show currentTime)
