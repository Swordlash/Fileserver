module Http.Types where

import Basis

import Files.Types

data RespListFiles = RespListFiles { fileTree :: !FileTree }
                  deriving stock (Eq, Show, Generic)
                  deriving anyclass (ToJSON, FromJSON)
