-- Main program
-- Draw random figure given a geometry boundaries (width x height)
-- All numbers are integers. 

import System.Environment
import System.Random
import Control.Monad
import Control.Exception

import LibGeometry
import LibAlea (randomFigure)
import LibRender (renderAlea, quote)

-- given a geometry (width, height) 
-- make a svg header string
svgHeader :: Geometry -> String
svgHeader (Geometry screenWidth screenHeight) = "<svg version=\"1.1\" width=" ++ (quote screenWidth) ++ " height=" ++ (quote screenHeight) ++ " xmlns=\"http://www.w3.org/2000/svg\">\n"

svgFooter = "</svg>"

-- given a geometry and a number of figures
-- make the given number of svg figures 
-- with random integers
svgBody :: Geometry -> Int -> IO String
svgBody geometry howMany = do
   a <- (replicateM howMany (randomFigure (Geometry 1920 1080) 30 ))
   lignes <- (mapM renderAlea a)
   return (unlines lignes)
 

program = do 
    args <- getArgs
    let g = (read (args !! 0)) :: Geometry
    content <- svgBody g 4000
    let svgScript = (svgHeader g) ++ content ++ svgFooter
    putStrLn svgScript 

usage = "Usage:\n  random-picture-exe geometry\n  geometry must follow width x height format\n\nExample:\n  random-picture-exe 640x480\n"

main = catch (program) handler
    where 
        handler:: SomeException -> IO ()
        handler ex = putStrLn $ "Caught exception: " ++ (show ex) ++ "\n" ++ usage
