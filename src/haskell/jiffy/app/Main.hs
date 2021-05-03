module Main where

import System.IO
import Data.Time.Clock.System
import Control.Monad
import Control.Monad.Loops
import Data.List
import Text.Printf
import Data.Maybe

data Measure = Measure {
   start :: Integer,
   laps :: Integer
} deriving (Eq, Show)


stillSameSecond start _ = do
  now <- liftM systemSeconds getSystemTime
  return (start /= now)

jiffy _ = do 
    startSecond <- liftM systemSeconds getSystemTime 
    result <- firstM (stillSameSecond startSecond) [1..]
    let out = (Measure (fromIntegral startSecond) (fromJust result))
    putStrLn (show out)
    return out


bogoMips :: [ Measure ] -> Double
bogoMips measures = (mSum / mN) / 500 where
    mSum = fromIntegral (sum (map laps measures))
    mN = fromIntegral (length measures)

main = do
   jiffy 0  -- calibrate
   r <- mapM jiffy [1..20]
   printf "ok - %.2f BogoMIPS\n" (bogoMips r) 
