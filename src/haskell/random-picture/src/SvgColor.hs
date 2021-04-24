module SvgColor (
    Color
    , svgColor
    , aleaColor
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

svgColor :: Int -> Int -> Int -> String
svgColor r g b = "#" ++ (showHex r "") ++ (showHex g "") ++ (showHex b "")

