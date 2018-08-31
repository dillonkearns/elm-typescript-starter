module Ports.GoogleAnalytics exposing (FromElm(..))


type FromElm
    = TrackEvent { category : String, action : String, label : Maybe String, value : Maybe Int }
    | TrackPage { path : String }
