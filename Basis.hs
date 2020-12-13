module Basis
  ( module Protolude
  , module Path
  , module Data.SafeCopy
  , module Data.Aeson
  , bracket
  , try
  , catch
  , loop
  , Fil
  ) where

import Protolude hiding (bracket, try, catch, (<.>), option, Handler)
import UnliftIO

import Control.Monad.Extra
import Path hiding (File)
import Path.Internal (Path(..))
import qualified Path as P
import Data.SafeCopy
import Data.Aeson

type Fil = P.File

instance (Typeable a, Typeable b) => SafeCopy (Path a b) where
  putCopy = contain . safePut . toFilePath
  getCopy = contain . fmap Path $ safeGet
