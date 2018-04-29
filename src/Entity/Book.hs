{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Entity.Book where

import           Database.HDBC.Query.TH          (defineTableFromDB)
import           Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import           DataSource                      (connect)

defineTableFromDB connect driverPostgreSQL "public" "books" [''Show]
