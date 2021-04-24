-- Main program
-- Draw random figure given a geometry boundaries (width x height)
-- All numbers are integers. 

import System.Environment
import System.Random
import Control.Monad

import LibDataTypes
import LibAlea
import LibRender
import SvgStyle

-- construct an array of random Rectangles

svgHeader :: (Int, Int) -> String
svgHeader (screenWidth, screenHeight) = "<svg version=\"1.1\" width=" ++ (quote screenWidth) ++ " height=" ++ (quote screenHeight) ++ " xmlns=\"http://www.w3.org/2000/svg\">\n"

svgBody :: (Int, Int) -> Int -> IO String
svgBody geometry howMany = do
   a <- (replicateM howMany (randomFigure (1920,1080) ))
   lignes <- (mapM renderAlea a)
   return (unlines lignes)
 
svgFooter = "</svg>"

main = do
    let g = (1024,768)
    putStrLn $ svgHeader g 
    b <- svgBody g 4000
    putStrLn b
    putStrLn $ svgFooter

