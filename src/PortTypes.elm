module PortTypes exposing
    ( LocalStorageFromElm(..)
    , LocalStorageToElm(..)
    )

import Json.Encode


type LocalStorageFromElm
    = StoreItem { key : String, item : Json.Encode.Value }
    | LoadItem { key : String }
    | ClearItem { key : String }


type LocalStorageToElm
    = LoadedItem { key : String, item : Json.Encode.Value }
