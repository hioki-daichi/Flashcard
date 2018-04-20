module DataSource
  ( connect
  ) where

import           Database.HDBC.Sqlite3 (Connection, connectSqlite3)

connect :: IO Connection
connect = connectSqlite3 "flashcard.db"
