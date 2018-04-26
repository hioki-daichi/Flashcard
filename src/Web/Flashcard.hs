{-# LANGUAGE OverloadedStrings #-}

module Web.Flashcard where

import           Control.Monad.IO.Class    (liftIO)
import           Data.IORef                (IORef, newIORef)
import           GHC.Int
import           Model.Book
import           Model.Health
import           Model.Page
import           Network.HTTP.Types.Status
import           Web.Spock
import           Web.Spock.Config

data MySession =
  EmptySession

newtype MyAppState =
  DummyAppState (IORef Int)

app :: SpockM () MySession MyAppState ()
app = do
  get "ping" $ do
    setCommonHeader
    health <- liftIO touchHealth
    json health
  get "books" $ do
    setCommonHeader
    books <- liftIO getBooks
    json books
  get ("books" <//> (var :: Var Int64)) $ \bookId -> do
    setCommonHeader
    mBook <- liftIO $ getBook bookId
    case mBook of
      Just book -> json book
      Nothing   -> setStatus status404
  get ("books" <//> (var :: Var Int64) <//> "pages") $ \bookId -> do
    setCommonHeader
    pages <- liftIO $ getPagesByBookId bookId
    json pages
  where
    setCommonHeader :: ActionCtxT ctx (WebStateM () MySession MyAppState) ()
    setCommonHeader = setHeader "Access-Control-Allow-Origin" "http://localhost:3000"

runFlashcard :: IO ()
runFlashcard = do
  ref <- newIORef 0
  cfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
  runSpock 8080 (spock cfg app)
