{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Model.Page where

import           Data.Aeson.TH
import           Database.HDBC.Record
import           Database.Relational.Query as HRR
import           DataSource
import qualified Entity.Page               as E
import           GHC.Int

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
