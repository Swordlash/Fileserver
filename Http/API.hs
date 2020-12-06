module Http.API
    ( app
    ) where

import Network.Wai
import Servant

import Http.Types
import Files.Types

import Path

type API = FileAPI -- :<|> MessagingAPI :<|> UserAPI :<|> TechAPI

type FileAPI =
  ListFiles
  -- :<|> UploadFile
  -- :<|> DownloadFile

type ListFiles =
  "files" :> "list" :> Get '[JSON] RespListFiles


app :: Application
app = serve (Proxy @API) server

server :: Server API
server = return . RespListFiles . FileTree $ Directory $(mkRelDir "root") Metadata
  [ File $(mkRelFile "file1") Metadata
  , File $(mkRelFile "file2") Metadata
  ]
