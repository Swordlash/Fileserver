module Http.Types where

import Data.Aeson
import GHC.Generics

import Files.Types

data RespListFiles = RespListFiles { fileTree :: !FileTree }
                  deriving stock (Eq, Show, Generic)
                  deriving anyclass (ToJSON, FromJSON)
