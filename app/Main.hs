module Main where

import Basis
import Http.Server
import Persistence.Persistence

import Network.Wai.Handler.Warp

import Options.Applicative

data Cmd = Cmd
  { acidRootDir :: FilePath
  , port        :: Int
  }

cmdParser :: ParserInfo Cmd
cmdParser =
  info (parser <**> helper)
    (fullDesc <> progDesc "Run fileserver app" <> header "Secure fileserver app")
  where
    parser = Cmd
      <$> strOption   (long "root" <> metavar "DIR" <> help "Root of the application data")
      <*> option auto (long "port" <> help "HTTP port" <> showDefault <> value 8000 <> metavar "PORT")

main :: IO ()
main = do
  Cmd{acidRootDir, port} <- execParser cmdParser
  bracket (open acidRootDir) close (run port . app)
