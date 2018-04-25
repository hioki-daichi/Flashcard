{-# LANGUAGE OverloadedStrings #-}

module Web.Flashcard where

import           Control.Monad.IO.Class (liftIO)
import           Data.IORef             (IORef, newIORef)
import           Model.Health
import           Web.Spock
import           Web.Spock.Config

data MySession =
  EmptySession

newtype MyAppState =
  DummyAppState (IORef Int)

app :: SpockM () MySession MyAppState ()
app =
  get "ping" $ do
    setCommonHeader
    health <- liftIO touchHealth
    json health
  where
    setCommonHeader :: ActionCtxT ctx (WebStateM () MySession MyAppState) ()
    setCommonHeader = setHeader "Access-Control-Allow-Origin" "http://localhost:3000"

runFlashcard :: IO ()
runFlashcard = do
  ref <- newIORef 0
  cfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
  runSpock 8080 (spock cfg app)
