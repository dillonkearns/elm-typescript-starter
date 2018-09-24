module View exposing (view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, style, value)
import Html.Events exposing (onClick)
import Locale exposing (Locale)


view :
    (Locale -> msg)
    -> { model | localizedTime : String }
    -> Browser.Document msg
view setLocaleMsg model =
    { body =
        [ div [ class "text-center" ]
            [ localeButtons setLocaleMsg
            , h1 [] [ text model.localizedTime ]
            ]
        ]
    , title = "elm-typescript-interop demo"
    }


localeButtons setLocaleMsg =
    div []
        ([ Locale.English
         , Locale.Norwegian
         , Locale.Bengali
         , Locale.Farsi
         ]
            |> List.map (localeButton setLocaleMsg)
        )


localeButton : (Locale -> msg) -> Locale -> Html msg
localeButton setLocaleMsg locale =
    button
        [ class "btn-lg btn-primary"
        , style "margin-top" "20px"
        , style "margin-bottom" "20px"
        , Html.Events.onClick (setLocaleMsg locale)
        ]
        [ locale |> Debug.toString |> text ]
