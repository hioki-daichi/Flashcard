module Util
  ( currentUtcTime
  ) where

import qualified Data.Time.Clock     as TM (getCurrentTime)
import qualified Data.Time.LocalTime as TM (LocalTime, utc, utcToLocalTime)

currentUtcTime :: IO TM.LocalTime
currentUtcTime = TM.utcToLocalTime TM.utc <$> TM.getCurrentTime
