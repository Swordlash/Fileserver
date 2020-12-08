module Http.Monad where

import Control.Monad.Reader

import Persistence.FilesystemState
import Servant

type AppServer api = ServerT api AppM

newtype AppM a = AppM { unAppM :: ReaderT Filesystem Handler a }
  deriving newtype (Functor, Applicative, Monad, MonadReader Filesystem, MonadIO)


runAppM :: forall a. Filesystem -> AppM a -> Handler a
runAppM filesystem = flip runReaderT filesystem . unAppM
