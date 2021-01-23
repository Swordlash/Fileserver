module Http.API where

import Servant
import Text.Blaze.Html5
import Servant.HTML.Blaze

import Servant.Auth.Server

import Http.Auth
import Http.Types

type API auths = AuthAPI :<|> HtmlAPI :<|> ProtectedFileAPI auths :<|> StaticAPI

------------------------------------------------------------------------

type AuthAPI =
       Register
  :<|> Login

type Register =
  "auth" :> "register"
         :> ReqBody '[FormUrlEncoded, JSON] ReqRegister
         :> Post '[HTML] Html

type Login =
  "auth" :> "login"
         :> ReqBody '[FormUrlEncoded, JSON] ReqLogin
         :> Post '[HTML] (SetCookies Html)

------------------------------------------------------------------------

type HtmlAPI =
  HtmlIndex
  :<|> HtmlLogin
  :<|> HtmlRegister

type HtmlIndex = Get '[HTML] Html
type HtmlLogin = "login" :> Get '[HTML] Html
type HtmlRegister = "register" :> Get '[HTML] Html

------------------------------------------------------------------------

type ProtectedFileAPI auths = Auth auths User :> FileAPI

type FileAPI =
  FileListing

type StaticAPI = "static" :> Raw

type FileListing =
  "files" :> "list"
          :> ReqBody '[FormUrlEncoded, JSON] ReqGetMyFiles
          :> Get '[HTML] Html
