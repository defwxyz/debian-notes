module LibGeometry (
    Geometry(..)
) where

import Data.List.Split

data Geometry = Geometry {
    width :: Int
  , height ::  Int 
} deriving (Eq)

instance Show Geometry where
    show (Geometry w h) = (show w) ++ "x" ++ (show h)

instance Read Geometry where
    -- readsPrec :: Int -> String -> [(Geometry, String)]
    readsPrec _ input = 
        [( (Geometry w h), [] )]
        where raw = (splitOn "x" input)
              w = read (raw !! 0) :: Int
              h = read (raw !! 1) :: Int
        
