module LibAlea (
    randomFigure
) where

import System.Environment
import System.Random
import Control.Monad

import LibDataTypes

-- construct an array of random Rectangles

randomPoint :: (Int, Int) -> IO Point
randomPoint (maxWidth, maxHeight) = do
    x <- randomRIO(0,maxWidth) :: IO Int
    y <- randomRIO(0,maxHeight) :: IO Int
    return (Point x y)

randomRectangle :: (Int, Int) -> (Int, Int) -> IO Rectangle
randomRectangle (screenWidth, screenHeight) (maxWidth, maxHeight) = do
    p <- randomPoint (screenWidth, screenHeight)
    w <- randomRIO(0,maxWidth) :: IO Int
    h <- randomRIO(0,maxHeight) :: IO Int
    return (Rectangle p w h)

randomRectangleSimple :: (Int, Int) -> IO Rectangle
randomRectangleSimple (w, h) = 
    randomRectangle (w,h) (w,h)

randomRectangleAlea :: (Int, Int) -> IO Rectangle
randomRectangleAlea (w, h) = do
    aleaW <- randomRIO(1,(w-1)) :: IO Int
    aleaH <- randomRIO(1,(h-1)) :: IO Int
    randomRectangle (w,h) (aleaW,aleaH)


randomCircle :: (Int, Int) -> Int -> IO Circle
randomCircle geometry maxRadius = do
    p <- randomPoint geometry
    r <- randomRIO(1,maxRadius)
    return (Circle p r)

randomEllipse :: (Int, Int) -> Int -> Int -> IO Ellipse
randomEllipse geometry w h = do
    p <- randomPoint geometry
    x <- randomRIO(1,w) :: IO Int
    y <- randomRIO(1,h) :: IO Int
    return (Ellipse p x y)

randomLine :: (Int, Int) -> IO Line
randomLine geometry = do
    p <- randomPoint geometry
    q <- (jump p)
    return (Line p q) 

jump :: Point -> IO Point
jump p = do
    dp <- randomPoint (100,100) 
    return (Point ((x p) + (x dp) - 50) ((y p) + (y dp) - 50))
    
randomFigure :: (Int, Int) -> IO Figure
randomFigure geometry = do
    dice <- randomRIO(0,3) :: IO Int
    randomFigureDispatch dice geometry


randomFigureDispatch x geometry 
    | (x == 0) = do
      f <- randomRectangle geometry (20,20)
      return (FigureRectangle f)
    | (x == 1) = do
      g <- randomEllipse geometry 20 20
      return (FigureEllipse g)
    | (x == 2) = do
      h <- randomLine geometry 
      return (FigureLine h)
    | otherwise = do
      i <- randomCircle geometry 20
      return (FigureCircle i)

