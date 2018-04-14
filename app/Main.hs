{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module Main where

import           Control.Monad.IO.Class (liftIO)
import           Data.Aeson.TH
import           Data.IORef
import           Data.Time.Clock
import           Web.Spock
import           Web.Spock.Config

newtype Health = Health
  { time :: UTCTime
  } deriving (Show)

deriveJSON defaultOptions ''Health

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
    json (Health currentTime)
