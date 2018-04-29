{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Model.Book where

import           Data.Aeson.TH
import           Database.HDBC.Record
import           Database.Relational.Query as HRR
import           DataSource
import qualified Entity.Book               as E
import           GHC.Int

deriveJSON defaultOptions ''E.Books

getBooks :: IO [E.Books]
getBooks = do
  conn <- connect
  runQuery conn getBooksQuery ()

getBooksQuery :: Query () E.Books
getBooksQuery =
  relationalQuery . relation $ do
    b <- query E.books
    asc $ b ! E.title'
    return b

getBook :: Int64 -> IO (Maybe E.Books)
getBook bookId = do
  conn <- connect
  runQuery conn getBookQuery bookId >>= listToUnique

getBookQuery :: Query Int64 E.Books
getBookQuery =
  relationalQuery . relation' . placeholder $ \ph -> do
    b <- query E.books
    wheres $ b ! E.id' .=. ph
    return b
