module Statics.Register where

import Basis hiding (head, link, for)
import Data.Monoid (mempty)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A hiding (label, form)

import Statics.Utils

registered :: Html
registered = docTypeHtml $ do
  H.title "Fileserver"
  defHead
  H.head $ meta ! httpEquiv "Refresh" ! content "3; URL=/login"
  body $ do
    p [qq|Successfully registered, redirecting to login...|]

register :: Html
register =
  docTypeHtml $ do
    H.title "Fileserver"
    defHead
    body ! class_ "w3-light-grey" $ do
      H.div ! class_ "w3-container" $ do
        p ! class_ "w3-text-black" $ do
          "Login to the filesystem"
          form ! action "/auth/register" ! method "post" ! enctype "application/x-www-form-urlencoded" $ do
            label ! for "username" $ "Username:"
            input ! type_ "text" ! A.id "username" ! name "username"
            label ! for "email" $ "Email:"
            input ! type_ "email" ! A.id "email" ! name "email"
            label ! for "password" $ "Password:"
            input ! type_ "password" ! A.id "password" ! name "password"
            input ! type_ "submit" ! value "Login"
