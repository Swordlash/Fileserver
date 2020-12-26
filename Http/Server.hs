{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}
module Http.Server where

import Basis
import Network.Wai
import Servant

import Http.API
import Http.Types
import Http.Monad
import Persistence.FilesystemState

import Statics

app :: Filesystem -> Application
app filesystem = serve (Proxy @API) $ hoistServer (Proxy @API) (runAppM filesystem) (server filesystem.root)

server :: Path Abs Dir -> AppServer API
server root =
  htmlServer
  :<|> filesServer
  :<|> staticServer
  where
    htmlServer = pure hello
    filesServer = listFiles
    staticServer = serveDirectoryWebApp (toFilePath $ root </> $(mkRelDir "static-files"))

listFiles :: AppM RespListFiles
listFiles = do
  filesystem <- ask
  root <- liftIO $ getRoot filesystem
  return . RespListFiles $ root
