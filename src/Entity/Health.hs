{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Entity.Health where

import           Database.HDBC.Query.TH       (defineTableFromDB)
import           Database.HDBC.Schema.SQLite3 (driverSQLite3)
import           DataSource

defineTableFromDB connect driverSQLite3 "main" "health" [''Show]
