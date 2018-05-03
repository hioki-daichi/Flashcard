{-# LANGUAGE OverloadedStrings #-}

module Web.Flashcard
  ( runFlashcard
  ) where

import           Control.Monad.IO.Class    (liftIO)
import           GHC.Int                   (Int64)
import           Model.Book                (getBook, getBooks)
import           Model.Health              (touchHealth)
import           Model.Page                (getPagesByBookId)
import           Network.HTTP.Types.Status (status404)
import           Web.Spock                 (SpockAction, SpockM, Var, get, json, runSpock, setHeader, setStatus, spock,
                                            var, (<//>))
import           Web.Spock.Config          (PoolOrConn (PCNoDatabase), defaultSpockCfg)

type Api = SpockM () () () ()

type ApiAction a = SpockAction () () () a

app :: Api
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
    setCommonHeader :: ApiAction ()
    setCommonHeader = setHeader "Access-Control-Allow-Origin" "http://localhost:4000"

runFlashcard :: IO ()
runFlashcard = do
  cfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock 8080 (spock cfg app)
