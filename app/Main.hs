module Main where

import Http.API
import Persistence.FilesystemState
import Data.Acid
import Data.Acid.Local

import Network.Wai.Handler.Warp

import Control.Exception
import Options.Applicative

main :: IO ()
main = bracket (open ".")
       (close)
       (\_acid -> run 8080 app)
