// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports
export as namespace Elm;

/*
type MsgToBrowserStorage
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

export type MsgToBrowserStorage = StoreItem | LoadItem | ClearItem;

/*
type MsgFromBrowserStorage
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
      subscribe(callback: (data: MsgToBrowserStorage) => void): void;
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
