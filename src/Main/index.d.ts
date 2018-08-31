// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports
export as namespace Elm;

/*
type UniversalAnalyticsFromElm
    = TrackEvent { category : String, action : String, label : Maybe String, value : Maybe Int }
    | TrackPage { path : String }
*/

export interface TrackEvent {
  kind: "TrackEvent";
  category: string;
  action: string;
  label: string | null;
  value: number | null;
}

export interface TrackPage {
  kind: "TrackPage";
  path: string;
}

export type UniversalAnalyticsFromElm = TrackEvent | TrackPage;
/*
type LocalStorageFromElm
    = StoreItem { key : String, item : Json.Encode.Value }
    | LoadItem { key : String }
    | ClearItem { key : String }

*/

export type JSON = null | object;

export interface StoreItem {
  kind: "StoreItem";
  key: string;
  item: JSON;
}

export interface LoadItem {
  kind: "LoadItem";
  key: string;
}

export interface ClearItem {
  kind: "ClearItem";
  key: string;
}

export type LocalStorageFromElm = StoreItem | LoadItem | ClearItem;

/*
type LocalStorageToElm
    = LoadedItem { key : String, item : Json.Encode.Value }
*/

export interface App {
  ports: {
    hello: {
      subscribe(callback: (data: string) => void): void;
    };
    reply: {
      send(data: number): void;
    };
    localStorageFromElm: {
      subscribe(callback: (data: LocalStorageFromElm) => void): void;
    };
    universalAnalyticsFromElm: {
      subscribe(callback: (data: UniversalAnalyticsFromElm) => void): void;
    };

    localStorageToElm: {
      send(data: { key: string; item: JSON }): void;
    };
  };
}

export namespace Main {
  export function fullscreen(): App;
  export function embed(node: HTMLElement | null): App;
}
