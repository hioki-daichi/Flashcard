{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Model.Health where

import           Data.Aeson.TH
import           Database.HDBC.Record
import           Database.HDBC.Sqlite3
import           Database.Relational.Query
import qualified Entity.Health             as E
import           Language.SQL.Keyword

deriveJSON defaultOptions ''E.Health

getHealth :: IO E.Health
getHealth = do
  conn <- connect
  healths <- runQuery' conn getHealthQuery ()
  return $ head healths

getHealthQuery :: Query () E.Health
getHealthQuery = relationalQuery' (relation q) [LIMIT, word (show "1")]
  where
    q = do
      h <- query E.health
      desc $ h ! E.time'
      return h

connect :: IO Connection
connect = connectSqlite3 "flashcard.db"
