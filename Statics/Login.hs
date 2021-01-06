module Statics.Login where

import Basis hiding (head, link, for)
import Data.Monoid (mempty)
import Text.Blaze.Html5
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes hiding (form, label)
import qualified Text.Blaze.Html5.Attributes as A

import Http.Auth

loggedIn :: User -> Html
loggedIn User{username} = docTypeHtml $ do
  H.title "Fileserver"
  link ! rel "icon" ! href "static/favicon.ico"
  H.head $ meta ! httpEquiv "Refresh" ! content "3; URL=/shared"
  body $ do
    p [qq|Successfully logged in as $username, redirecting to files...|]

login :: Html
login =
  docTypeHtml $ do
    H.title "Fileserver"
    meta ! charset "UTF-8"
    meta ! name "viewport" ! content "width=device-width, initial-scale=1"
    link ! rel "icon" ! href "static/favicon.ico"
    link ! rel "stylesheet" ! href "static/styles.css"
    link ! rel "stylesheet" ! href "https://fonts.googleapis.com/css?family=Roboto"
    link ! rel "stylesheet" ! href "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    H.style "html, body, h1, h2, h3, h4, h5, h6 {\n        font-family: \"Roboto\", sans-serif\n    }"
    H.head $ do
      script ! type_ "application/ld+json" $ "{\n          \"@context\": \"http://schema.org\",\n          \"@type\": \"Person\",\n          \"email\": \"mailto:mateusz.goslinowski@gmail.pl\",\n          \"image\": \"static/photo.jpg\",\n          \"jobTitle\": \"Haskell Developer\",\n          \"name\": \"Mateusz Goślinowski\",\n          \"url\": \"http://mgoslinowski.ngrok.io\",\n        }"
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
