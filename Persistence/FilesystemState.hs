{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}
module Persistence.FilesystemState where

import Basis
import Data.Acid
import Data.Acid.Advanced
import Data.Acid.Local
import Files.Types

import System.Directory

data Filesystem = Filesystem
  { fsState :: !(AcidState FilesystemState)
  , root  :: !(Path Abs Dir)
  }

newtype FilesystemState = FilesystemState
  { filesystemRoot :: FileTree
  } deriving newtype (Eq, Show, Generic)

getFilesystemState :: Query FilesystemState FilesystemState
getFilesystemState = ask

$(deriveSafeCopy 0 'base ''FilesystemState)
$(makeAcidic ''FilesystemState ['getFilesystemState])

emptyFilesystem :: FilesystemState
emptyFilesystem = FilesystemState . FileTree $ Directory rootPath [] [] DirMetadata

open :: FilePath -> IO Filesystem
open filePath = do
  canonical <- makeAbsolute filePath
  root <- parseAbsDir canonical
  let appStateDir = root </> $(mkRelDir "app-state")
      appObjDir   = root </> $(mkRelDir "objects")

  createDirectoryIfMissing True (fromAbsDir appStateDir)
  createDirectoryIfMissing True (fromAbsDir appObjDir)

  fsState <- openLocalStateFrom (fromAbsDir appStateDir) emptyFilesystem
  return $ Filesystem {fsState, root}

close :: Filesystem -> IO ()
close fs = createCheckpointAndClose fs.fsState

getRoot :: Filesystem -> IO FileTree
getRoot fs = filesystemRoot <$> query' fs.fsState GetFilesystemState
