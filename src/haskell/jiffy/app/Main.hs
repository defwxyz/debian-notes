module Main where

import System.IO
import Data.Time.Clock.POSIX
import Control.Monad
import Control.Monad.Loops
import Data.List
import Text.Printf
import Data.Maybe

data Measure = Measure {
   start :: POSIXTime,
   laps :: Int
} deriving (Eq, Show)


still :: Int -> Int -> IO Bool
still start _ = do
  now <- getPOSIXTime
  return (start /= (floor now)) 

isOneSecondLater start = do
    endloop <- firstM (still start) [1 .. 1000000]  
    return (fromJust endloop)

jiffy _ = do
    start <- getPOSIXTime
    result <- isOneSecondLater (floor start) 
    let out = (Measure start result)
    return out

bogoMips :: [ Measure ] -> Double
bogoMips measures = (mSum / mN) / 500 where
    mSum = fromIntegral (sum (map laps measures))
    mN = fromIntegral (length measures)

main = do
   jiffy 0  -- calibrate
   r <- mapM jiffy [1..10]
   printf "ok - %.2f BogoMIPS\n" (bogoMips r) 
