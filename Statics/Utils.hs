module Statics.Utils where

import Basis hiding (head, link)
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A

defHead :: Html
defHead = do
  meta ! charset "UTF-8"
  meta ! name "viewport" ! content "width=device-width, initial-scale=1"
  link ! rel "icon" ! href "static/favicon.ico"
  link ! rel "stylesheet" ! href "static/styles.css"
  link ! rel "stylesheet" ! href "https://fonts.googleapis.com/css?family=Roboto"
  link ! rel "stylesheet" ! href "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
  H.style "html, body, h1, h2, h3, h4, h5, h6 {\n        font-family: \"Roboto\", sans-serif\n    }"
