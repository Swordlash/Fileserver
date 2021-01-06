{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}
module Http.Server where

import Basis hiding ((</>))
import Network.Wai
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.HTTP.Types.Status
import Servant
import Servant.Auth.Server
import Text.Blaze.Html5

import Http.API
import Http.Auth
import Http.Types
import Http.Monad
import Persistence.Persistence

import System.FilePath ((</>))

import Statics.Index
import Statics.Login
import Statics.Register

app :: AppState -> Application
app apps =
  let api = Proxy @(API '[JWT, Cookie])
      context = Proxy @('[CookieSettings, JWTSettings])
      cfg = apps.cs :. apps.jwt :. EmptyContext
  in debug $ logStdoutDev $ serveWithContext api cfg $ hoistServerWithContext api context (runAppM apps) (server apps.root apps.cs apps.jwt)

debug :: Middleware
debug app req resp = do
  putText "Request headers:"
  print (requestHeaders req)
  app req resp

server :: Path Abs Dir -> CookieSettings -> JWTSettings -> AppServer (API auths)
server root cs jwts =
  authServer cs jwts
  :<|> htmlServer
  :<|> filesServer root
  :<|> staticServer root

-----------------------------------------------------------------

authServer :: CookieSettings -> JWTSettings -> AppServer AuthAPI
authServer cs jwts =
  registerHandler :<|> loginHandler cs jwts

registerHandler :: ReqRegister -> AppM Html
registerHandler ReqRegister{username, email, password} = do
  appState <- ask
  addUser User{..}
  return registered

loginHandler :: CookieSettings -> JWTSettings -> ReqLogin -> AppM (SetCookies Html)
loginHandler cs jwt ReqLogin{username, password} = do
  users <- getUsers
  case find (\usr -> usr.username == username && usr.password == password) users of
    Nothing -> throwError err401
    Just usr -> do
      mApplyCookies <- liftIO $ acceptLogin cs jwt usr
      case mApplyCookies of
        Nothing           -> throwError err500
        Just applyCookies -> pure $ applyCookies (loggedIn usr)

-----------------------------------------------------------------

htmlServer :: AppServer HtmlAPI
htmlServer = htmlIndex :<|> htmlLogin :<|> htmlRegister

htmlIndex :: AppM Html
htmlIndex = pure index

htmlLogin :: AppM Html
htmlLogin = pure login

htmlRegister :: AppM Html
htmlRegister = pure register

-----------------------------------------------------------------

filesServer :: Path Abs Dir -> AppServer (ProtectedFileAPI auths)
filesServer root = filesListing root

filesListing :: Path Abs Dir -> AuthResult User -> Tagged AppM Application
filesListing root auth = case auth of
  Authenticated usr -> serveDirectoryFileServer (toFilePath root </> "shared-files" </> toS usr.username)
  _ -> Tagged $ \_req resp -> do
                    putText [qq|AuthResult: $auth|]
                    resp $ responseLBS status401 [] "User not authenticated"

-----------------------------------------------------------------

staticServer :: Path Abs Dir -> AppServer StaticAPI
staticServer root = serveDirectoryWebApp (toFilePath root </> "static-files")
