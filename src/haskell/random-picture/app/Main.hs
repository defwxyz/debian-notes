-- Main program
-- Draw random figure given a geometry boundaries (width x height)
-- All numbers are integers. 

import System.Environment
import System.Random
import Control.Monad

import LibAlea (randomFigure)
import LibRender (renderAlea, quote)

-- given a geometry (width, height) 
-- make a svg header string
svgHeader :: (Int, Int) -> String
svgHeader (screenWidth, screenHeight) = "<svg version=\"1.1\" width=" ++ (quote screenWidth) ++ " height=" ++ (quote screenHeight) ++ " xmlns=\"http://www.w3.org/2000/svg\">\n"

svgFooter = "</svg>"

-- given a geometry and a number of figures
-- make the given number of svg figures 
-- with random integers
svgBody :: (Int, Int) -> Int -> IO String
svgBody geometry howMany = do
   a <- (replicateM howMany (randomFigure (1920,1080) ))
   lignes <- (mapM renderAlea a)
   return (unlines lignes)
 

main = do
    let g = (1024,768)
    content <- svgBody g 4000
    let svgScript = (svgHeader g) ++ content ++ svgFooter
    putStrLn svgScript 

