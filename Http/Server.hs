module Http.Server where

import Network.Wai
import Servant

import Http.API
import Http.Types
import Http.Monad
import Control.Monad.Reader
import Persistence.FilesystemState

app :: Filesystem -> Application
app filesystem = serve (Proxy @API) $ hoistServer (Proxy @API) (runAppM filesystem) server

server :: AppServer API
server = listFiles

listFiles :: AppM RespListFiles
listFiles = do
  filesystem <- ask
  root <- liftIO $ getRoot filesystem
  return . RespListFiles $ root
