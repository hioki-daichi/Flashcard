module DataSource
  ( connect
  ) where

import           Database.HDBC.PostgreSQL (Connection, connectPostgreSQL)

connect :: IO Connection
connect = connectPostgreSQL "user=postgres host=localhost port=15432 dbname=flashcard_development"
