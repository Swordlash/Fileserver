{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}

module Files.Utils
  ( splitPath
  , createDir
  ) where

import Basis
import Files.Types

splitPath :: Path Abs Dir -> [Path Rel Dir]
splitPath = reverse . loop split . (,[])
  where
    split (path, dirs) =
      if parent path == path then Right dirs
      else Left (parent path, dirname path : dirs)

createDir :: Path Abs Dir -> FileTree -> (FileTree, Bool)
createDir path (FileTree dir) = undefined
