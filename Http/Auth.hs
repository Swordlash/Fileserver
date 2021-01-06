{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}
module Http.Auth where

import Basis
import Servant.Auth.Server

data User = User
  { username :: !Text
  , email    :: !Text
  , password :: !Text
  } deriving stock (Eq, Ord, Show, Generic)
    deriving anyclass (ToJSON, FromJSON, ToJWT, FromJWT)

data LoginForm = LoginForm
  { username :: !Text
  , password :: !Text
  } deriving stock (Eq, Ord, Show, Generic)
    deriving anyclass (ToJSON, FromJSON)

$(deriveSafeCopy 0 'base ''User)
