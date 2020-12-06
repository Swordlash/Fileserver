module Http.Monad where

import Control.Monad.Reader
import Control.Monad.Fail

import Persistence.FilesystemState
import Servant

newtype AppM a = AppM { unAppM :: ReaderT FilesystemState Handler a }
  deriving newtype (Functor, Applicative, Monad, MonadReader FilesystemState)
