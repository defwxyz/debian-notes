module LibAlea (
    randomFigure
) where

import System.Environment
import System.Random
import Control.Monad

import LibDataTypes
import LibGeometry

randomPoint :: Geometry -> IO Point
randomPoint (Geometry maxWidth maxHeight) = do
    x <- randomRIO(0,maxWidth) :: IO Int
    y <- randomRIO(0,maxHeight) :: IO Int
    return (Point x y)

randomRectangle :: Geometry -> (Int, Int) -> IO Rectangle
randomRectangle g (maxWidth, maxHeight) = do
    p <- randomPoint g 
    w <- randomRIO(0,maxWidth) :: IO Int
    h <- randomRIO(0,maxHeight) :: IO Int
    return (Rectangle p w h)

randomRectangleSimple :: Geometry -> IO Rectangle
randomRectangleSimple (Geometry w h) = 
    randomRectangle (Geometry w h) (w,h)

randomRectangleAlea :: Geometry -> IO Rectangle
randomRectangleAlea (Geometry w h) = do
    aleaW <- randomRIO(1,(w-1)) :: IO Int
    aleaH <- randomRIO(1,(h-1)) :: IO Int
    randomRectangle (Geometry w h) (aleaW,aleaH)


randomCircle :: Geometry -> Int -> IO Circle
randomCircle geometry maxRadius = do
    p <- randomPoint geometry
    r <- randomRIO(1,maxRadius)
    return (Circle p r)

randomEllipse :: Geometry -> Int -> Int -> IO Ellipse
randomEllipse geometry w h = do
    p <- randomPoint geometry
    x <- randomRIO(1,w) :: IO Int
    y <- randomRIO(1,h) :: IO Int
    return (Ellipse p x y)

randomLine :: Geometry -> Int -> IO Line
randomLine geometry size = do
    p <- randomPoint geometry
    q <- (jump p size)
    return (Line p q) 

jump :: Point -> Int -> IO Point
jump p size = do
    let doublesize = 2 * size
    dp <- randomPoint (Geometry doublesize doublesize) 
    return (Point ((x p) + (x dp) - size) ((y p) + (y dp) - size))
    
randomFigure :: Geometry -> Int -> IO Figure
randomFigure geometry size = do
    dice <- randomRIO(0,3) :: IO Int
    randomFigureDispatch dice geometry size 


randomFigureDispatch x geometry size
    | (x == 0) = do
      f <- randomRectangle geometry (size,size)
      return (FigureRectangle f)
    | (x == 1) = do
      g <- randomEllipse geometry size size 
      return (FigureEllipse g)
    | (x == 2) = do
      h <- randomLine geometry size 
      return (FigureLine h)
    | otherwise = do
      i <- randomCircle geometry size
      return (FigureCircle i)

