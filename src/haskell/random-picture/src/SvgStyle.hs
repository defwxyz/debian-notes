module SvgStyle (
    Style(..)
    , Color
    , aleaStyle
    , quoteColor
) where

import Numeric (showHex)
import System.Random

type Color = String

alea15 = randomRIO(0,15) 

aleaColor :: IO String
aleaColor = do
   r <- alea15 :: IO Int
   g <- alea15 :: IO Int
   b <- alea15 :: IO Int
   return (svgColor r g b)

aleaStyle :: Int -> IO Style
aleaStyle max = do
    c <- aleaColor
    strokeWidth <- randomRIO(1,max) :: IO Int
    return (Style c strokeWidth) 


quoteColor :: Color -> String
quoteColor s = "\"" ++ s ++ "\""

svgColor :: Int -> Int -> Int -> String
svgColor r g b = "#" ++ (showHex r "") ++ (showHex g "") ++ (showHex b "")


data Style = Style {
    styleColor :: Color
  , styleThickness :: Int
} deriving (Show, Eq) 

