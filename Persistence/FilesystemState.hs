module Persistence.FilesystemState where

import Data.Acid
import Data.Acid.Advanced
import Data.Acid.Local
import Data.SafeCopy
import Files.Types hiding (dirname)

import GHC.Generics
import Path
import System.Directory
import Control.Monad.Reader

data Filesystem = Filesystem
  { state :: !(AcidState FilesystemState)
  , root  :: !(Path Abs Dir)
  }

newtype FilesystemState = FilesystemState
  { filesystemRoot :: FileTree
  } deriving newtype (Eq, Show, Generic)

getFilesystemState :: Query FilesystemState FilesystemState
getFilesystemState = ask

$(deriveSafeCopy 0 'base ''FilesystemState)
$(makeAcidic ''FilesystemState ['getFilesystemState])

emptyFilesystem :: Path Rel Dir -> FilesystemState
emptyFilesystem dir = FilesystemState . FileTree $ Directory dir Metadata []

open :: FilePath -> IO Filesystem
open filePath = do
  canonical <- makeAbsolute filePath
  root <- parseAbsDir canonical
  let appStateDir = root </> $(mkRelDir "app-state")
      appRootDir  = root </> $(mkRelDir "root")

  createDirectoryIfMissing True (fromAbsDir appStateDir)
  createDirectoryIfMissing True (fromAbsDir appRootDir)

  state <- openLocalStateFrom (fromAbsDir appStateDir) (emptyFilesystem $ dirname appRootDir)
  return $ Filesystem {state, root}

close :: Filesystem -> IO ()
close Filesystem{state} = createCheckpointAndClose state

getRoot :: Filesystem -> IO FileTree
getRoot Filesystem{state} = filesystemRoot <$> query' state GetFilesystemState
