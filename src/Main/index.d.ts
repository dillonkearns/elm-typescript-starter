// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace Main {
    export interface App {
      ports: {
        storageStoreItem: {
          subscribe(callback: (data: { key: string; value: unknown }) => void): void
        }
        lookItemUp: {
          subscribe(callback: (data: string) => void): void
        }
        storageItemFound: {
          send(data: { key: string; value: unknown }): void
        }
        storageItemNotFound: {
          send(data: { key: string }): void
        }
        hello: {
          subscribe(callback: (data: string) => void): void
        }
        reply: {
          send(data: number): void
        }
        something: {
          subscribe(callback: (data: string) => void): void
        }
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: null;
    }): Elm.Main.App;
  }
}