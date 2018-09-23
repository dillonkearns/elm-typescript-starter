module Locale exposing (Locale(..), toString)


type Locale
    = English
    | Es
    | Norwegian
    | Bengali
    | Farsi


toString : Locale -> String
toString locale =
    case locale of
        English ->
            "en-us"

        Es ->
            "es"

        Norwegian ->
            "nb"

        Bengali ->
            "bn"

        Farsi ->
            "fa"
