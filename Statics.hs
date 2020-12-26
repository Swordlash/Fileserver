module Statics where

import Basis hiding (head, link)

import Text.Blaze.Html4.Strict
import Text.Blaze.Html4.Strict.Attributes hiding (title)

hello :: Html
hello = html $ do
  head $ do
    title "Welcome page"
    link ! rel "icon" ! href "static/favicon.ico"
  body $ "Witam serdecznie."
