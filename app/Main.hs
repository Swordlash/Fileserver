module Main where

import Http.API
import Persistence.FilesystemState

import Network.Wai.Handler.Warp

import Control.Exception
import Options.Applicative

main :: IO ()
main = bracket (open ".")
       (close)
       (run 8080 . app)
