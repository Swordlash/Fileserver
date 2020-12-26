module Http.API where

import Servant
import Text.Blaze.Html4.Strict
import Servant.HTML.Blaze

import Http.Types

type API = HtmlAPI :<|> FileAPI :<|> StaticAPI

type HtmlAPI = Get '[HTML] Html

type FileAPI =
  ListFiles

type StaticAPI = "static" :> Raw

type ListFiles =
  "files" :> "list" :> Get '[JSON] RespListFiles
