module Http.Monad where

import Basis

import Persistence.Persistence
import Servant

type AppServer api = ServerT api AppM

newtype AppM a = AppM { unAppM :: ReaderT AppState Handler a }
  deriving newtype (Functor, Applicative, Monad, MonadReader AppState, MonadIO, MonadError ServerError)

runAppM :: forall a. AppState -> AppM a -> Handler a
runAppM apps = flip runReaderT apps . unAppM
