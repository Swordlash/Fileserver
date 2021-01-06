module Basis
  ( module Protolude
  , module Path
  , module Data.SafeCopy
  , module Data.Aeson
  , module Text.InterpolatedString.Perl6
  , bracket
  , try
  , catch
  , finally
  , async
  , loop
  , singleton
  , (<|)
  , Fil
  , L.delete
  , JWK(..)
  ) where

import Protolude hiding (bracket, try, catch, finally, async, (<.>), option, Handler)
import UnliftIO

import Control.Monad.Extra
import Path hiding (File)
import Path.Internal (Path(..))
import qualified Path as P
import Data.SafeCopy
import Data.Aeson
import Data.List.NonEmpty

import qualified Data.List as L
import Crypto.JOSE.JWK (JWK(..))

import Text.InterpolatedString.Perl6

type Fil = P.File

instance (Typeable a, Typeable b) => SafeCopy (Path a b) where
  putCopy = contain . safePut . toFilePath
  getCopy = contain . fmap Path $ safeGet

singleton :: a -> NonEmpty a
singleton x = x :| []
