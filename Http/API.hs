module Http.API where

import Servant

import Http.Types

type API = FileAPI -- :<|> MessagingAPI :<|> UserAPI :<|> TechAPI

type FileAPI =
  ListFiles
  -- :<|> UploadFile
  -- :<|> DownloadFile

type ListFiles =
  "files" :> "list" :> Get '[JSON] RespListFiles
