module Files.Types where

import Data.Aeson
import Data.SafeCopy

import GHC.Generics
import Data.Typeable

import Path
import Path.Internal

data Metadata = Metadata
  deriving stock (Eq, Show, Generic)
  deriving anyclass (ToJSON, FromJSON)

data FileTreeNode
  = File
    { filename :: !(Path Rel File)
    , metadata :: !Metadata
    }
  | Directory
    { dirname :: !(Path Rel Dir)
    , metadata :: !Metadata
    , entries  :: ![FileTreeNode]
    }
  deriving stock (Eq, Show, Generic)
  deriving anyclass (ToJSON, FromJSON)

newtype FileTree = FileTree FileTreeNode
  deriving newtype (Eq, Show, ToJSON, FromJSON)


instance (Typeable a, Typeable b) => SafeCopy (Path a b) where
  putCopy (Path path) = contain $ safePut path
  getCopy = contain $ Path <$> safeGet

$(deriveSafeCopy 0 'base ''Metadata)
$(deriveSafeCopy 0 'base ''FileTreeNode)
$(deriveSafeCopy 0 'base ''FileTree)
