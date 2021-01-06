{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}
module Persistence.Persistence where

import Basis
import Data.Acid
import Data.Acid.Advanced
import Data.Acid.Local
import Files.Types

import Http.Auth
import Crypto.JOSE.JWK
import Servant.Auth.Server

import System.Directory

data AppState = AppState
  { pers      :: !(AcidState Persistence)
  , root      :: !(Path Abs Dir)
  , cs        :: !CookieSettings
  , jwt       :: !JWTSettings
  }

data Persistence = Persistence
  { filesystemRoot :: !FileTree
  , users          :: ![User]
  } deriving stock (Eq, Show, Generic)

getPersistence :: Query Persistence Persistence
getPersistence = ask

addUser_ :: User -> Update Persistence ()
addUser_ user = modify (\pers -> pers{ users = user : pers.users})

$(deriveSafeCopy 0 'base ''Persistence)
$(makeAcidic ''Persistence ['getPersistence, 'addUser_])

emptyPersistence :: Persistence
emptyPersistence = Persistence (FileTree $ Directory rootPath [] [] DirMetadata) []

open :: FilePath -> IO AppState
open filePath = do
  canonical <- makeAbsolute filePath
  root <- parseAbsDir canonical
  let acidStateDir = root </> $(mkRelDir "acid")
      appFilesDir  = root </> $(mkRelDir "files")
      staticsDir   = root </> $(mkRelDir "static-files")

  createDirectoryIfMissing True (fromAbsDir acidStateDir)
  createDirectoryIfMissing True (fromAbsDir appFilesDir)
  createDirectoryIfMissing True (fromAbsDir staticsDir)

  serverKey <- generateKey

  pers <- openLocalStateFrom (fromAbsDir acidStateDir) emptyPersistence
  let cs = defaultCookieSettings { cookieIsSecure = NotSecure, cookieSameSite = SameSiteStrict, cookieXsrfSetting = Nothing}
  return $ AppState {pers, root, cs, jwt = defaultJWTSettings serverKey}

close :: AppState -> IO ()
close apps = createCheckpointAndClose apps.pers

---------------------------------------------------------------------------------------------

getRoot :: (MonadIO m, MonadReader AppState m) => m FileTree
getRoot = do
  p <- asks pers
  liftIO $ filesystemRoot <$> query' p GetPersistence

getUsers :: (MonadIO m, MonadReader AppState m) => m [User]
getUsers = do
  p <- asks pers
  liftIO $ users <$> query' p GetPersistence

addUser :: (MonadIO m, MonadReader AppState m) => User -> m ()
addUser user = do
  p <- asks pers
  liftIO $ update' p (AddUser_ user)
