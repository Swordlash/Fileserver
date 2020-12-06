module Http.API
    ( app
    ) where

import Network.Wai
import Servant

import Http.Types
import Control.Monad.IO.Class
import Persistence.FilesystemState

type API = FileAPI -- :<|> MessagingAPI :<|> UserAPI :<|> TechAPI

type FileAPI =
  ListFiles
  -- :<|> UploadFile
  -- :<|> DownloadFile

type ListFiles =
  "files" :> "list" :> Get '[JSON] RespListFiles


app :: Filesystem -> Application
app filesystem = serve (Proxy @API) (server filesystem)

server :: Filesystem -> Server API
server filesystem = do
  root <- liftIO $ getRoot filesystem
  return . RespListFiles $ root
