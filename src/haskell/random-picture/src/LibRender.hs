module LibRender (
    render,
    renderAlea,
    renderPoints,
    quote
) where

import System.Environment
import System.Random
import Control.Monad
import Data.List
import LibDataTypes
import SvgStyle


quote :: Int -> String
quote s = "\"" ++ (show s) ++ "\""

renderAlea f = do
    s <- aleaStyle 5
    return (render s f)

render s (FigureRectangle (Rectangle (Point x y) w h)) =
    "<rect x=" ++ (quote x)
      ++ " y=" ++ (quote y) 
      ++ " width=" ++ (quote w)  
      ++ " height=" ++ (quote h) 
      ++ " fill=" ++ (quoteColor (styleColor s))
      ++ " />"
render s (FigureCircle (Circle (Point cx cy) r)) =
    "<circle cx=" ++ (quote cx)
        ++ " cy=" ++ (quote cy)
        ++ " r=" ++ (quote r)
        ++ " fill=" ++ (quoteColor (styleColor s))
        ++ " />"
render s (FigureEllipse (Ellipse (Point cx cy) w h)) =
    "<ellipse cx=" ++ (quote cx)
         ++ " cy=" ++ (quote cy)
         ++ " rx=" ++ (quote w)
         ++ " ry=" ++ (quote h)
         ++ " fill=" ++ (quoteColor (styleColor s))
         ++ " />"
render s (FigureLine (Line (Point x1 y1) (Point x2 y2))) =
    "<line x1=" ++ (quote x1)
         ++ " y1=" ++ (quote y1)
         ++ " x2=" ++ (quote x2)
         ++ " y2=" ++ (quote y2)
         ++ " stroke-width=" ++ (quote (styleThickness s))
         ++ " stroke=" ++ (quoteColor (styleColor s))
         ++ " />"

render s (FigurePolygon (Polygon points)) = 
     "<polygon points=\""
         ++ (renderPoints points)
         ++ "\"" 
         ++ " fill=" ++ (quoteColor (styleColor s))
         ++ " stroke-width=" ++ (quote (styleThickness s))
         ++ " />"

render s (FigureStar (Star points)) = renderPolygon1 ++ renderPolygon2 where
     renderPolygon1 = render s (FigurePolygon (Polygon polygon1))
     renderPolygon2 = render s (FigurePolygon (Polygon polygon2))
     (polygon1,polygon2) = evenOddSplit points

evenOddSplit [] = ([], [])
evenOddSplit (x:xs) = (x:o, e)
    where (e,o) = evenOddSplit xs

renderPoints p  = intercalate " " $ fmap renderPoint p
renderPoint (Point x y) = (show x) ++ ',':(show y)
-- render _ _ = ""

