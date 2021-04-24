module LibRender (
    render,
    renderAlea,
    quote 
) where

import System.Environment
import System.Random
import Control.Monad

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
   
render _ _ = ""

