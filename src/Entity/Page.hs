{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}

module Entity.Page where

import           Database.HDBC.Query.TH          (defineTableFromDB)
import           Database.HDBC.Schema.PostgreSQL (driverPostgreSQL)
import           DataSource                      (connect)

defineTableFromDB connect driverPostgreSQL "public" "pages" [''Show]
