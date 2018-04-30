{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Model.Page
  ( getPagesByBookId
  ) where

import           Data.Aeson.TH             (defaultOptions, deriveJSON)
import           Database.HDBC.Record      (runQuery)
import           Database.Relational.Query (Query, placeholder, query, relation', relationalQuery, wheres, (!), (.=.))
import           DataSource                (connect)
import qualified Entity.Page               as E (Pages, bookId', pages)
import           GHC.Int                   (Int64)

deriveJSON defaultOptions ''E.Pages

getPagesByBookId :: Int64 -> IO [E.Pages]
getPagesByBookId bookId = do
  conn <- connect
  runQuery conn getPagesByBookIdQuery bookId

getPagesByBookIdQuery :: Query Int64 E.Pages
getPagesByBookIdQuery =
  relationalQuery . relation' . placeholder $ \ph -> do
    b <- query E.pages
    wheres $ b ! E.bookId' .=. ph
    return b
