{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Model.Book
  ( getBooks
  , getBook
  ) where

import           Data.Aeson.TH             (defaultOptions, deriveJSON)
import           Database.HDBC.Record      (listToUnique, runQuery)
import           Database.Relational.Query (Query, asc, placeholder, query, relation, relation', relationalQuery,
                                            wheres, (!), (.=.))
import           DataSource                (connect)
import qualified Entity.Book               as E (Books, books, id', title')
import           GHC.Int                   (Int64)

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
