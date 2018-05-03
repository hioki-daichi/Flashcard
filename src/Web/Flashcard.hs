{-# LANGUAGE OverloadedStrings #-}

module Web.Flashcard
  ( runFlashcard
  ) where

import           Control.Monad.IO.Class    (liftIO)
import           GHC.Int                   (Int64)
import           Model.Book                (getBook, getBooks, postBook)
import           Model.Health              (touchHealth)
import           Model.Page                (getPagesByBookId)
import           Network.HTTP.Types.Status (status404)
import           Web.Spock                 (SpockAction, SpockM, Var, get, json, param', post, prehook, runSpock,
                                            setHeader, setStatus, spock, var, (<//>))
import           Web.Spock.Config          (PoolOrConn (PCNoDatabase), defaultSpockCfg)

type Api = SpockM () () () ()

type ApiAction a = SpockAction () () () a

app :: Api
app =
  prehook setCommonHeader $ do
    get "ping" $ do
      health <- liftIO touchHealth
      json health
    post "books" $ do
      userId <- param' "userId"
      title <- param' "title"
      _ <- liftIO $ postBook userId title
      books <- liftIO getBooks
      json books
    get "books" $ do
      books <- liftIO getBooks
      json books
    get ("books" <//> (var :: Var Int64)) $ \bookId -> do
      mBook <- liftIO $ getBook bookId
      case mBook of
        Just book -> json book
        Nothing   -> setStatus status404
    get ("books" <//> (var :: Var Int64) <//> "pages") $ \bookId -> do
      pages <- liftIO $ getPagesByBookId bookId
      json pages
  where
    setCommonHeader :: ApiAction ()
    setCommonHeader = setHeader "Access-Control-Allow-Origin" "http://localhost:4000"

runFlashcard :: IO ()
runFlashcard = do
  cfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock 8080 (spock cfg app)
