{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Model.Health
  ( touchHealth
  ) where

import           Data.Aeson.TH             (defaultOptions, deriveJSON)
import qualified Data.Time.Clock           as TM (getCurrentTime)
import qualified Data.Time.LocalTime       as TM (LocalTime, utc, utcToLocalTime)
import           Database.HDBC.Record      (runQuery', runUpdate)
import           Database.HDBC.Session     (withConnectionCommit)
import           Database.Relational.Query (Query, Update, derivedUpdate, desc, placeholder, query, relation,
                                            relationalQuery', wheres, (!), (.=.), (<-#), (><))
import           DataSource                (connect)
import qualified Entity.Health             as E (Healths, healths, id, id', time')
import           GHC.Int                   (Int64)
import           Language.SQL.Keyword      (Keyword (LIMIT), word)

deriveJSON defaultOptions ''E.Healths

touchHealth :: IO E.Healths
touchHealth = do
  health <- getHealth
  _ <- updateHealth (E.id health)
  getHealth

getHealth :: IO E.Healths
getHealth = do
  conn <- connect
  healths <- runQuery' conn getHealthQuery ()
  return $ head healths

getHealthQuery :: Query () E.Healths
getHealthQuery = relationalQuery' (relation q) [LIMIT, word "1"]
  where
    q = do
      h <- query E.healths
      desc $ h ! E.time'
      return h

updateHealth :: Int64 -> IO Integer
updateHealth healthId = do
  utcTime <- currentUtcTime
  withConnectionCommit connect $ \conn -> runUpdate conn updateHealthQuery (utcTime, healthId)

updateHealthQuery :: Update (TM.LocalTime, Int64)
updateHealthQuery =
  derivedUpdate $ \proj -> do
    (phTime, ()) <- placeholder (\ph -> E.time' <-# ph)
    (phId, ()) <- placeholder (\ph -> wheres $ proj ! E.id' .=. ph)
    return $ phTime >< phId

currentUtcTime :: IO TM.LocalTime
currentUtcTime = TM.utcToLocalTime TM.utc <$> TM.getCurrentTime
