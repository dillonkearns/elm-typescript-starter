// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace Main {
    export interface App {
      ports: {
        setLocale: {
          subscribe(callback: (data: string) => void): void
        }
        timeChanged: {
          send(data: string): void
        }
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: { startTime: string };
    }): Elm.Main.App;
  }
}