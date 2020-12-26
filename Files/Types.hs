{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}
module Files.Types
  ( Hash(..)
  , FileMetadata(..)
  , DirMetadata (..)
  , File (..)
  , Directory (..)
  , FileTree (..)
  , rootPath
  ) where

import Basis

rootPath :: Path Rel Dir
rootPath = $(mkRelDir "root")

data FileMetadata = FileMetadata
  { -- fileHash :: !Hash
  } deriving stock (Eq, Show, Generic)
    deriving anyclass (ToJSON, FromJSON)

data DirMetadata = DirMetadata
  { -- dirHash :: !Hash
  } deriving stock (Eq, Show, Generic)
    deriving anyclass (ToJSON, FromJSON)

newtype Hash = Hash { sha256 :: [Char] }
  deriving newtype (Eq, Show, Ord, ToJSON, FromJSON)

data File = File
  { fileName :: !(Path Rel Fil)
  , metadata :: !FileMetadata
  } deriving stock (Eq, Show, Generic)
    deriving anyclass (ToJSON, FromJSON)

data Directory = Directory
  { dirName   :: !(Path Rel Dir)
  , subDirs   :: ![Directory]
  , files     :: ![File]
  , metadata  :: !DirMetadata
  } deriving stock (Eq, Show, Generic)
    deriving anyclass (ToJSON, FromJSON)

newtype FileTree = FileTree Directory
  deriving newtype (Eq, Show, ToJSON, FromJSON, Generic)

$(deriveSafeCopy 0 'base ''Hash)
$(deriveSafeCopy 0 'base ''DirMetadata)
$(deriveSafeCopy 0 'base ''FileMetadata)
$(deriveSafeCopy 0 'base ''File)
$(deriveSafeCopy 0 'base ''Directory)
$(deriveSafeCopy 0 'base ''FileTree)
