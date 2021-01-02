module Statics.Index where

import Basis hiding (head, link)
import Data.Monoid (mempty)
import Text.Blaze.Html5
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5.Attributes as A

index :: Html
index = do
  docTypeHtml $ do
    H.title "Homepage of Mateusz Goślinowski"
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
      H.div ! class_ "w3-content w3-margin-top" ! A.style "max-width:1400px;" $ do
        H.div ! class_ "w3-row-padding" $ do
          H.div ! class_ "w3-third" $ do
            H.div ! class_ "w3-white w3-text-grey w3-card-4" $ do
              H.div ! class_ "w3-display-container" $ img ! src "static/fb.jpg" ! A.style "width:100%" ! alt "Avatar"
              H.div ! class_ "w3-container" ! A.id "info" $ do
                p $ h3 ! class_ "w3-text-black" $ "Mateusz Goślinowski"
                p $ do
                  i ! class_ "fa fa-graduation-cap fa-fw w3-margin-right w3-large w3-text-dark-gray" $ mempty
                  "Mathematics, Computer Science"
                p $ do
                  i ! class_ "fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-dark-grey" $ mempty
                  "Haskell Developer"
                p $ do
                  i ! class_ "fa fa-home fa-fw w3-margin-right w3-large w3-text-dark-gray" $ mempty
                  "Warsaw, PL"
                p $ do
                  i ! class_ "fa fa-envelope fa-fw w3-margin-right w3-large w3-text-dark-gray" $ mempty
                  a ! href "mailto:mateusz.goslinowski@gmail.com" ! target "_top" $ "mateusz.goslinowski@gmail.com"
                hr
                p ! class_ "w3-large" $
                  b $ do
                    i ! class_ "fa fa-flask fa-fw w3-margin-right w3-text-dark-gray" $ mempty
                    "Fields of\n                        interest:"
                ul $ do
                  li $ p "Functional Programming (Haskell)"
                  li $ p "Mathematical foundations of quantum theory and relativity"
                  li $ p "Partial differential equations"
            br
          H.div ! class_ "w3-hide-small w3-twothird" $
            H.div ! class_ "w3-display-container w3-card w3-white w3-bar w3-margin-bottom" $ do
              a ! href "#" ! class_ "w3-bar-item w3-button w3-padding-large w3-hover-light-grey" $ do
                i ! class_ "fa fa-user w3-xxlarge w3-text-dark-gray" $ mempty
                p "INFORMATION"
              a ! href "#articles" ! class_ "w3-bar-item w3-right w3-button w3-padding-large w3-hover-light-grey" $ do
                i ! class_ "fa fa-file-pdf-o w3-xxlarge w3-text-dark-gray" $ mempty
                p "ARTICLES"
              a ! href "#books" ! class_ "w3-bar-item w3-right w3-button w3-padding-large w3-hover-light-grey" $ do
                i ! class_ "fa fa-book w3-xxlarge w3-text-dark-gray" $ mempty
                p "BOOKS"
              a ! href "#teaching" ! class_ "w3-bar-item w3-right w3-button w3-padding-large w3-hover-light-grey" $ do
                i ! class_ "fa fa-magic w3-xxlarge w3-text-dark-gray" $ mempty
                p "TEACHING"
              a ! href "#education" ! class_ "w3-bar-item w3-right w3-button w3-padding-large w3-hover-light-grey" $ do
                i ! class_ "fa fa-university w3-xxlarge w3-text-dark-gray" $ mempty
                p "EDUCATION"
          H.div ! class_ "w3-twothird" ! A.id "education" $
            H.div ! class_ "w3-container w3-card w3-white w3-margin-bottom" $ do
              h2 ! class_ "w3-text-grey w3-padding-16" $ do
                i ! class_ "fa fa-university fa-fw w3-margin-right w3-xxlarge w3-text-dark-gray" $ mempty
                "Education"
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ b "Warsaw University of Technology"
                h6 ! class_ "w3-opacity" $ b "The Faculty of Electronics and Information Technology"
                h6 ! class_ "w3-text-dark-gray" $ do
                  H.span ! A.style "width:66%;" $ do
                    i ! class_ "fa fa-calendar fa-fw w3-margin-right" $ mempty
                    "2020 - current"
                  H.span ! A.style "width:33%; padding-left: 3em" $ "Computer Science (MEng)"

                h5 ! class_ "w3-opacity" $ b "University of Warsaw"
                h6 ! class_ "w3-opacity" $ b "College of Inter-Faculty Individual Studies in Mathematics and Natural Sciences"
                h6 ! class_ "w3-text-dark-gray" $ do
                  H.span ! A.style "width:66%;" $ do
                    i ! class_ "fa fa-calendar fa-fw w3-margin-right" $ mempty
                    "2016 - 2020"
                  H.span ! A.style "width:33%; padding-left: 3em" $ "Mathematics"
                h6 ! class_ "w3-text-dark-gray" $ do
                  H.span ! A.style "width:66%;" $ do
                    i ! class_ "fa fa-calendar fa-fw w3-margin-right" $ mempty
                    "2016 - 2019"
                  H.span ! A.style "width:33%; padding-left: 3em" $ "Computer Science"
                hr
          H.div ! class_ "w3-twothird" ! A.id "teaching" $
            H.div ! class_ "w3-container w3-card w3-white w3-margin-bottom" $ do
              h2 ! class_ "w3-text-grey w3-padding-16" $ do
                i ! class_ "fa fa-magic fa-fw w3-margin-right w3-xxlarge w3-text-dark-gray" $ mempty
                "Exercise & lecture materials"
              H.div ! class_ "w3-container" $ do
                h4 ! class_ "w3-text-grey" $ do
                  i ! class_ "fa fa-mortar-board fa-fw w3-margin-right w3-large w3-text-dark-gray" $ mempty
                  "Mathematical Analysis I.1 2019/20"
                h6 ! class_ "w3-text-grey" ! A.style "padding-left:2.5em;" $ "Lecture: Paweł Goldstein, Classes: Marcin Moszyński"
                ul $ do
                  li $ a ! href "static/docs/2019-20zim_seria01.pdf" $ "Homework I, due date 29 X 2019 - solutions"
                  li $ a ! href "static/docs/2019-20zim_seria02.pdf" $ "Homework II, due date 07 XI 2019 - solutions, comments"
                  li $ a ! href "static/docs/2019-20zim_seria03.pdf" $ "Homework III, due date 19 XI 2019 - solutions"
                  li $ a ! href "static/docs/2019-20zim_seria04.pdf" $ "Homework IV, due date 10 XII 2019 - solutions"
                  li $ a ! href "static/docs/2019-20zim_seria05.pdf" $ "Homework V, due date 20 XII 2019 - solutions"
                  li $ a ! href "static/docs/2019-20zim_seria06.pdf" $ "Homework VI, due date 14 I 2020"
              H.div ! class_ "w3-container" $ do
                h4 ! class_ "w3-text-grey" $ do
                  i ! class_ "fa fa-mortar-board fa-fw w3-margin-right w3-large w3-text-dark-gray" $ mempty
                  "2019 Physics Camp - Sarbinowo"
                ul $ do
                  li $ a ! href "static/docs/wyk1.pdf" $ "Lecture I - Least Action Principle"
                  li $ a ! href "static/docs/wyk2.pdf" $ "Lecture II - Conservation laws and Noether theorem"
                  li $ a ! href "static/docs/wyk3.pdf" $ "Lecture III - Gravity, Binet's formula, planetary orbits and relativistic correction to Newton's law"
          H.div ! class_ "w3-twothird" ! A.id "books" $
            H.div ! class_ "w3-container w3-card w3-white w3-margin-bottom" $ do
              h2 ! class_ "w3-text-grey w3-padding-16" $ do
                i ! class_ "fa fa-book fa-fw w3-margin-right w3-xxlarge w3-text-dark-gray" $ mempty
                "Books"
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ do
                  "B. Bogdańska, M. Goślinowski, A. Neugebauer -"
                  b $ i $ a ! href "http://www.ws-omega.com.pl/matematyka-olimpijska-rownania-nierownosci-p-916.html" $ "Olympic Mathematics - Equations and Inequalities"
                h6 ! class_ "w3-text-dark-gray" $ do
                  i ! class_ "fa fa-calendar fa-fw w3-margin-right" $ mempty
                  "08.2020 - preprint"
                p "IVth part of Olympic Mathematics series. Covers basics of real analysis, linear algebra,\n                        inequalities,\n                        functional equations and their applications to olympic problems."
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ b $ a ! href "static/docs/pmf.pdf" $ i "Mathematical foundations of physics"
                h6 ! class_ "w3-text-dark-gray" $ do
                  i ! class_ "fa fa-calendar fa-fw w3-margin-right" $ mempty
                  "Writing in progress"
                p $ do
                  "The main principle of the book is to describe various physical phenomena, taught in high school level physics classes,\n                        as well as introduce some other mathematical laws and structures, which have fundamental implications on physical theories."
                  br
                  br
                  "The lecture requires knowledge of some fundamental notions of real analysis, such as those of a derivative or Riemann integral,\n                        supported with basic insight into vector spaces."
          H.div ! class_ "w3-twothird" ! A.id "articles" $ do
            H.div ! class_ "w3-container w3-card w3-white w3-margin-bottom" $ do
              h2 ! class_ "w3-text-grey w3-padding-16" $ do
                i ! class_ "fa fa-file-pdf-o fa-fw w3-margin-right w3-xxlarge w3-text-dark-gray" $ mempty
                "Articles and scripts"
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ do
                  "M. Goślinowski -"
                  b $ a ! href "static/docs/matlic.pdf" $ i "Weyl asymptotics and Polya hypothesis"
                p "The thesis concentrates on fundamentals of spectral theory of Laplace operator, especially on the eigenvalue asymptotics of this operator.\n                        A concept of a heat kernel has been introduced and a few of its properties have been proven. Using this concept and a Karamata tauberian theorem,\n                        a fundamental theorem of spectral asymptotics, Weyl theorem, has been proven. Polya hypothesis has been introduced and proven in a special case,\n                        and also in the general case with a worse constant. In the last chapter a connection between spectral theory and non-relativistic quantum mechanics\n                        has been discussed. Basic difficulties with treating quantum world in a classical way have been presented and a semiclassical approximation has been\n                        briefly introduced as a way of transition between classical and quantum mechanics. In particular, a connection between a semiclassical approximation\n                        and a Weyl asymptotics has been shown and it has been discussed how Lieb-Thirring inequalities, emerging from those considerations,\n                        generalise Polya hypothesis."
                hr
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ do
                  "W. Ciszewski, M. Goślinowski, T. Madej, R. Waśko -"
                  b $ a ! href "static/docs/inflic.pdf" $ i "TensorFlow binding for Luna visual programming language"
                p "In this thesis the TensorFlow C interface has been integrated with Luna visual programming language and a machine learning library based on that\n                        interface has been created. This library allows creating, training and running neural network models easily, using both graphical and textual\n                        representation of programs in Luna. (Computer Science bachelors thesis)"
                hr
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ b $ a ! href "static/docs/article.pdf" $ i "General Relativity and gravitational collapse of dying stars"
                p "In this article, written in a popular-scientific manner, I outline a whirlwind history of a General\n                        Relativity, introducing the reader to the main concepts of this theory. I discuss how the physics explains\n                        the birth of the Universe, and why we cannot yet fully understand what was before and why did the Universe\n                        develop in a way we see it now. I also discuss briefly the evolution and death of stars."
                hr
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ b $ a ! href "static/docs/riemann.pdf" $ i "Trigonometric functions and Riemann zeta"
                p "This article reveals an interesting link between hyperbolic and trigonometric functions\n                        and their Laurent series coefficients. This in turn yields a recurrence relation\n                        between values of Riemann zeta in positive even integers."
                hr
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ b $ a ! href "static/docs/ineq.pdf" $ i "Olympic inequalities"
                p "Chapter of my book \"Equations and Inequalities\". Early draft, may contain minor mistakes."
                hr
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ b $ a ! href "static/docs/pnt.pdf" $ i "Prime Number Theorem - Statistical\n                        Approach"
                p "In this article I discuss a famous Prime Number Theorem, a hypothesis which remained unproven\n                        for nearly 100 years. I outline results of mathematicians like Chebyshev and provide\n                        an unrigorous - asymptotic \"proof\" of the Theorem. Those are my notes from the lecture I have\n                        given on inter-school\n                        mathematical olympic camp in Cetniewo, Poland."
                hr
              H.div ! class_ "w3-container" $ do
                h5 ! class_ "w3-opacity" $ b $ a ! href "static/docs/basel.pdf" $ i "Basel Problem"
                p $ do
                  "In this article I outlined one of the modern solutions of Basel Problem, a great\n                        mathematical\n                        problem of the XVII century. Those are my notes from the lecture I have given on Junior\n                        Mathematical\n                        Conference TriMAT in Gdynia, Poland."
                  br
                  br
      footer ! class_ "w3-container w3-white w3-text-grey w3-center w3-margin-top" $ do
        p "Powered by w3.css, servant and servant-blaze"
