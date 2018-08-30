module PortTypes exposing
    ( MsgFromBrowserStorage(..)
    , MsgToBrowserStorage(..)
    )

import Json.Encode


type MsgToBrowserStorage
    = StoreItem { key : String, item : Json.Encode.Value }
    | LoadItem { key : String }
    | ClearItem { key : String }


type MsgFromBrowserStorage
    = LoadedItem { key : String, item : Json.Encode.Value }
