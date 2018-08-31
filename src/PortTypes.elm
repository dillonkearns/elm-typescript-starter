module PortTypes exposing
    ( LocalStorageFromElm(..)
    , LocalStorageToElm(..)
    , UniversalAnalyticsFromElm(..)
    )

import Json.Encode


type LocalStorageFromElm
    = StoreItem { key : String, item : Json.Encode.Value }
    | LoadItem { key : String }
    | ClearItem { key : String }


type LocalStorageToElm
    = LoadedItem { key : String, item : Json.Encode.Value }


type UniversalAnalyticsFromElm
    = TrackEvent { category : String, action : String, label : Maybe String, value : Maybe Int }
    | TrackPage { path : String }
