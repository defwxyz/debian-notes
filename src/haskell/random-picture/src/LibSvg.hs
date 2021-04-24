module LibSvg (
    createAleaSvg 
) where

import Numeric (showHex)
import System.Random
import Control.Monad
import LibDataTypes


randomXY :: (Int,Int) -> IO (Int,Int)
randomXY (screenWidth,screenHeight) = do
    randomX <- randomRIO(0,screenWidth) :: IO Int
    randomY <- randomRIO(0,screenHeight) :: IO Int
    return (randomX,randomY)
  

alea3 :: IO Int
alea3 = randomRIO(0,3) 

alea15 = randomRIO(0,15) 
alea100 = randomRIO(1,50) 

aleaColor :: IO String
aleaColor = do
   r <- alea15 :: IO Int
   g <- alea15 :: IO Int
   b <- alea15 :: IO Int
   return (svgColor r g b)

aleaStroke :: IO String
aleaStroke = do
   w <- randomRIO(1,4) :: IO Int
   c <- aleaColor
   return (attrStroke w c)

attrStroke :: Int -> String -> String
attrStroke aWidth aColor = " stroke-width=\"" ++ (show aWidth) ++ "\" stroke=\"" ++ aColor ++ "\" "

aleaRectangle :: (Int,Int) -> IO String
aleaRectangle geometry = do
   (x,y) <- randomXY geometry
   aWidth <- alea100 :: IO Int
   aHeight <- alea100 :: IO Int
   aColor <- aleaColor
   return (svgRect x y aWidth aHeight aColor)

aleaCircle:: (Int, Int) -> IO String
aleaCircle geometry = do
   (cx, cy) <- randomXY geometry
   r <- alea100
   aColor <- aleaColor
   return (svgCircle cx cy r aColor)

aleaEllipse:: (Int, Int) -> IO String
aleaEllipse geometry = do
   (cx,cy) <- randomXY geometry
   rx <- alea100
   ry <- alea100
   aColor <- aleaColor
   return (svgEllipse cx cy rx ry aColor)

aleaLine :: (Int, Int) -> IO String
aleaLine geometry = do
   (x1,y1) <- randomXY geometry
   dx <- randomRIO(0,100) :: IO Int
   dy <- randomRIO(0,100) :: IO Int
   let x2 = (x1 - 50) + dx
   let y2 = (y1 - 50) + dy
   w <- randomRIO(1,4) :: IO Int
   aColor <- aleaColor
   return (svgLine x1 y1 x2 y2 w aColor)

quote :: Int -> String
quote s = "\"" ++ (show s) ++ "\""

svgRect :: Int -> Int -> Int -> Int -> String -> String
svgRect x y w h c = "<rect" ++ defx ++ defy ++ defwidth ++ defheight ++ deffill ++ "/>\n" where
    defx = " x=" ++ (quote x) 
    defy = " y=" ++ (quote y)
    defwidth = " width=" ++ (quote w)
    defheight = " height=" ++ (quote h)
    deffill = " fill=\"" ++ c ++ "\" "
           
svgCircle cx cy r c = "<circle" ++ defcx ++ defcy ++ defr ++ deffill ++ "/>\n" where
    defcx = " cx=" ++ (quote cx)
    defcy = " cy=" ++ (quote cy)
    defr = " r=" ++ (quote r)
    deffill = " fill=\"" ++ c ++ "\" "
    
svgEllipse cx cy rx ry c = "<ellipse" ++ defcx ++ defcy ++ defrx ++ defry ++ deffill ++ "/>" where
    defcx = " cx=" ++ (quote cx)
    defcy = " cy=" ++ (quote cy)
    defrx = " rx=" ++ (quote rx)
    defry = " ry=" ++ (quote ry)
    deffill = " fill=\"" ++ c ++ "\" "

svgLine :: Int -> Int -> Int -> Int -> Int -> String -> String
svgLine x1 y1 x2 y2 w c = "<line" ++ defx1 ++ defy1 ++ defx2 ++ defy2 ++ defs ++ "/>" where
    defx1 = " x1=" ++ (quote x1)
    defy1 = " y1=" ++ (quote y1)
    defx2 = " x2=" ++ (quote x2)
    defy2 = " y2=" ++ (quote y2)
    defs = (attrStroke w c)

figures = [aleaRectangle, aleaCircle, aleaEllipse] :: [ (Int,Int) -> IO String ]

aleaFigure :: Int -> (Int, Int) -> IO String
aleaFigure 0 = aleaRectangle 
aleaFigure 1 = aleaCircle
aleaFigure 2 = aleaEllipse
aleaFigure 3 = aleaLine

svgColor :: Int -> Int -> Int -> String
svgColor r g b = "#" ++ (showHex r "") ++ (showHex g "") ++ (showHex b "")

svgHeader :: (Int, Int) -> String
svgHeader (screenWidth, screenHeight) = "<svg version=\"1.1\" width=" ++ (quote screenWidth) ++ " height=" ++ (quote screenHeight) ++ " xmlns=\"http://www.w3.org/2000/svg\">\n"

svgBody :: (Int, Int) -> Int -> IO String
svgBody geometry howMany = do
   aleas <- replicateM howMany alea3
   let afs = (map aleaFigure aleas)
   result <- mapM ($ geometry) afs
   return (unlines result)
    
svgFooter = "</svg>"

createAleaSvg :: (Int, Int) -> IO ()
createAleaSvg geometry = do
    b <- (svgBody geometry 1000)
    putStrLn ((svgHeader geometry) ++ b ++ svgFooter)



