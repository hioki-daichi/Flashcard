{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Model.Book
  ( getBooks
  , getBook
  , postBook
  ) where

import           Data.Aeson.TH             (defaultOptions, deriveJSON)
import           Data.Time.LocalTime       (LocalTime)
import           Database.HDBC.Record      (listToUnique, runInsert, runQuery)
import           Database.HDBC.Session     (withConnectionCommit)
import           Database.Relational.Query (Insert, Query, asc, derivedInsertValue, placeholder, query, relation,
                                            relation', relationalQuery, unitPlaceHolder, value, wheres, (!), (.=.),
                                            (<-#))
import           DataSource                (connect)
import qualified Entity.Book               as E (Books, books, createdAt', id', title', updatedAt', userId')
import           GHC.Int                   (Int64)
import           Util                      (currentUtcTime)

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

postBook :: Int64 -> String -> IO Integer
postBook userId title =
  withConnectionCommit connect $ \conn -> do
    utcTime <- currentUtcTime
    runInsert conn (postBookQuery userId title utcTime) ()

postBookQuery :: Int64 -> String -> LocalTime -> Insert ()
postBookQuery userId title time =
  derivedInsertValue $ do
    E.userId' <-# value userId
    E.title' <-# value title
    E.createdAt' <-# value time
    E.updatedAt' <-# value time
    return unitPlaceHolder
