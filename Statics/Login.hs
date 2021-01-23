module Statics.Login where

import Basis hiding (head, link, for)
import Data.Monoid (mempty)
import Text.Blaze.Html5
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes hiding (form, label)
import qualified Text.Blaze.Html5.Attributes as A

import Http.Auth

import Statics.Utils

loggedIn :: User -> Html
loggedIn User{username} = docTypeHtml $ do
  H.title "Fileserver"
  defHead
  H.head $ meta ! httpEquiv "Refresh" ! content "3; URL=/shared"
  body $ do
    p [qq|Successfully logged in as $username, redirecting to files...|]

login :: Html
login =
  docTypeHtml $ do
    H.title "Fileserver"
    defHead
    body ! class_ "w3-light-grey" $ do
      H.div ! class_ "w3-container" $ do
        p ! class_ "w3-text-black" $ do
          "Login to the filesystem"
          form ! action "/auth/login" ! method "post" ! enctype "application/x-www-form-urlencoded" $ do
            label ! for "username" $ "Username:"
            input ! type_ "text" ! A.id "username" ! name "username"
            label ! for "password" $ "Password:"
            input ! type_ "password" ! A.id "password" ! name "password"
            input ! type_ "submit" ! value "Login"
