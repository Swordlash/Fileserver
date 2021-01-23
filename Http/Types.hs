module Http.Types where

import Basis
import Servant
import Servant.Auth.Server
import Http.Auth
import Web.Internal.FormUrlEncoded

data ReqRegister = ReqRegister { username :: !Text, email :: !Text, password :: !Text }
                 deriving stock (Eq, Show, Generic)
                 deriving anyclass (ToJSON, FromJSON, ToForm, FromForm)

data ReqLogin = ReqLogin { username :: !Text, password :: !Text }
               deriving stock (Eq, Show, Generic)
               deriving anyclass (ToJSON, FromJSON, ToForm, FromForm)

type SetCookies a = Headers '[ Header "Set-Cookie" SetCookie, Header "Set-Cookie" SetCookie] a

data ReqGetMyFiles = ReqGetMyFiles { filePath :: !FilePath }
                   deriving stock (Eq, Show, Generic)
                   deriving anyclass (ToJSON, FromJSON, ToForm, FromForm)
