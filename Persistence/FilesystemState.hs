module Persistence.FilesystemState where

import Data.Acid
import Data.Acid.Local
import Data.SafeCopy
import Files.Types

import GHC.Generics
import Path
import System.Directory


data Filesystem = Filesystem
  { state :: !(AcidState FilesystemState)
  , root  :: !(Path Abs Dir)
  }

data FilesystemState = FilesystemState
  { filesystemRoot :: !FileTree
  } deriving stock (Eq, Show, Generic)

$(deriveSafeCopy 0 'base ''FilesystemState)
$(makeAcidic ''FilesystemState [])

emptyFilesystem :: FilesystemState
emptyFilesystem = FilesystemState . FileTree $ Directory $(mkRelDir "root") Metadata []


open :: FilePath -> IO Filesystem
open filePath = do
  canonical <- canonicalizePath filePath
  root <- parseAbsDir filePath
  state <- openLocalStateFrom canonical emptyFilesystem
  return $ Filesystem {state, root}

close :: Filesystem -> IO ()
close Filesystem{state} = createCheckpointAndClose state
