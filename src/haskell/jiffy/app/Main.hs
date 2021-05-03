module Main where

import Data.Int
import System.IO
import Data.Time.Clock.System
import Control.Monad
import Control.Monad.Loops
import Data.List
import Text.Printf
import Data.Maybe

data Measure = Measure {
   start :: Int64,
   laps :: Int64
} deriving (Eq, Show)


stillSameSecond :: Int64 -> Int64 -> IO Bool
stillSameSecond start _ = do
  now <- liftM systemSeconds getSystemTime
  return (start /= now)

jiffy _ = do 
    startSecond <- liftM systemSeconds getSystemTime 
    result <- firstM (stillSameSecond startSecond) [1..]
    let out = (Measure startSecond (fromJust result))
    putStrLn (show out)
    return out


bogoMips :: [ Int64 ] -> Double
bogoMips measures = mSum / (mN * 500.0) where
    mSum = fromIntegral (sum measures)
    mN = fromIntegral (length measures)

main = do
   jiffy 0  -- calibrate
   r <- mapM jiffy [1..20]
   printf "ok - %.2f BogoMIPS\n" (bogoMips (map laps r)) 
