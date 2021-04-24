-- CreateSvg.hs

import System.Environment
import LibSvg (createAleaSvg)


main = do
    args <- getArgs
    createAleaSvg (1920,1080)
 


