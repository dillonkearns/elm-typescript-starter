module Ports.LocalStorage exposing
    ( FromElm(..)
    , ToElm(..)
    )

import Json.Encode


type FromElm
    = StoreItem { key : String, item : Json.Encode.Value }
    | LoadItem { key : String }
    | ClearItem { key : String }


type ToElm
    = LoadedItem { key : String, item : Json.Encode.Value }
