module QuoteString (
    quote
) where

quote :: Int -> String
quote s = "\"" ++ (show s) ++ "\""

