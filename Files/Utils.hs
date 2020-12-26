{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}

module Files.Utils
  ( splitPath
  , createDir
  , updateDir
  , createFile
  ) where

import Basis
import Files.Types
import qualified Data.List.NonEmpty as NE

splitPath :: Path Abs Dir -> NonEmpty (Path Rel Dir)
splitPath = NE.reverse . loop split . (, singleton rootPath)
  where
    split (path, dirs) =
      if parent path == path then Right dirs
      else Left (parent path, dirname path <| dirs)

-- TODO: check if exists
createFile :: Path Abs Dir -> File -> FileTree -> FileTree
createFile path file = updateDir path f
  where f dir = dir{ files = file : dir.files }

createEmptyDir :: Path Rel Dir -> Directory
createEmptyDir name = Directory name [] [] DirMetadata

createEmptyDirs :: NonEmpty (Path Rel Dir) -> Directory
createEmptyDirs dirs = case NE.uncons dirs of
  (dir, Nothing) -> createEmptyDir dir
  (dir, Just rest) -> Directory dir [createEmptyDirs rest] [] DirMetadata

-- | Updates a directory. If it does not exist, applies the function to the empty directory
updateDir :: Path Abs Dir -> (Directory -> Directory) -> FileTree -> FileTree
updateDir path f (FileTree dir) = FileTree $ updateDir' paths f dir
  where paths             = splitPath path

updateDir' :: NonEmpty (Path Rel Dir) -> (Directory -> Directory) -> Directory -> Directory
updateDir' dirs f dir = case NE.uncons dirs of
  (name, Nothing) -> case find ((== name) . dirName) dir.subDirs of
    Nothing -> dir{ subDirs = f (createEmptyDir name) : dir.subDirs }
    Just dir' -> dir { subDirs = f dir' : delete dir' dir.subDirs }

createDir :: Path Abs Dir -> FileTree -> (FileTree, Bool)
createDir path (FileTree dir) = first FileTree (createDir' paths dir)
  where paths = splitPath path

createDir' :: NonEmpty (Path Rel Dir) -> Directory -> (Directory, Bool)
createDir' (name :| rest) dir =
  if any ((== name) . dirName) dir.subDirs then (dir, False)
  else (dir{ subDirs = Directory name subDirs' [] DirMetadata : dir.subDirs }, True)
  where
    subDirs' = maybeToList . fmap createEmptyDirs . nonEmpty $ rest
