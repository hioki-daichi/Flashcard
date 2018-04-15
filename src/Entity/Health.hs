{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Entity.Health where

import           Database.HDBC.Query.TH       (defineTableFromDB)
import           Database.HDBC.Schema.SQLite3 (driverSQLite3)
import           Database.HDBC.Sqlite3        (connectSqlite3)

defineTableFromDB (connectSqlite3 "flashcard.db") driverSQLite3 "main" "health" [''Show]
