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

randomPolygon geometry maxsize = do
    n <- randomRIO(1,16) :: IO Int
    points <- randomRegularPolygonPoints geometry n maxsize
    return (Polygon points)

randomStar geometry maxsize = do
    n <- randomRIO(1,8) :: IO Int
    points <- randomRegularPolygonPoints geometry (2 * n) maxsize
    return (Star points) 

randomRegularPolygonPoints :: Geometry -> Int -> Int -> IO [ Point ] 
randomRegularPolygonPoints geometry n maxsize = do
    p <- randomPoint geometry
    size <- randomRIO(1,maxsize) :: IO Int
    let rp = regularPolygon (fromIntegral n) (fromIntegral size)
    return (translatePoints p rp)

translatePoints anchor p = map (translatePoint anchor) p   

translatePoint (Point ax ay) (Point bx by) = Point (ax+bx) (ay+by)

regularPolygon :: Int -> Int -> [ Point ]
regularPolygon n d = map (coin d) angles where
    angles = map ((* radian) . fromIntegral) [0..(n-1)]
    radian = (2.0 * pi) / (fromIntegral n)
    

coin :: Int -> Float -> Point 
coin d angle = (Point x y) where
    x = floor $ (fromIntegral d) * (cos angle)
    y = floor $ (fromIntegral d) * (sin angle)

jump :: Point -> Int -> IO Point
jump p size = do
    let doublesize = 2 * size
    dp <- randomPoint (Geometry doublesize doublesize) 
    return (Point ((x p) + (x dp) - size) ((y p) + (y dp) - size))
    
randomFigure :: Geometry -> Int -> IO Figure
randomFigure geometry size = do
    dice <- randomRIO(0,5) :: IO Int
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
    | (x == 3) = do
      i <- randomCircle geometry size
      return (FigureCircle i)
    | (x == 4) = do
      j <- randomStar geometry size
      return (FigureStar j)
    | otherwise = do
      k <- randomPolygon geometry size
      return (FigurePolygon k)

