import * as Elm from "./src/Main";
let app = Elm.Main.fullscreen();
app.ports.hello.subscribe(name => console.log(`Hello ${name}!!`));
app.ports.reply.send(12345);

function assertNever(x: never): never {
  throw new Error("Unexpected object: " + x);
}

app.ports.localStorageFromElm.subscribe(data => {
  if (data.kind === "StoreItem") {
    console.log("You asked me to store an item!", data);
    localStorage.setItem(data.key, JSON.stringify(data.item));
  } else if (data.kind === "ClearItem") {
    console.log("You asked me to clear an item!", data);
    localStorage.removeItem(data.key);
  } else if (data.kind === "LoadItem") {
    console.log("You asked me to load an item!", data);
    const getItemString = localStorage.getItem(data.key);
    if (getItemString) {
      app.ports.localStorageToElm.send({
        key: data.key,
        item: JSON.parse(getItemString)
      });
    }
  } else {
    assertNever(data);
  }
});

app.ports.googleAnalyticsFromElm.subscribe(data => {
  if (data.kind === "TrackPage") {
    console.log("TrackPage!", data);
    // ... some Google Analytics track page code here,
    // could look something like
    // https://github.com/dillonkearns/mobster/blob/2ad66f514579a09a9679b75b6c1b2956e7879b46/typescript/analytics.ts#L46-L48
  } else if (data.kind === "TrackEvent") {
    console.log("TrackEvent!", data);
    // ... some Google Analytics track event code here,
    // could look something like
    // https://github.com/dillonkearns/mobster/blob/2ad66f514579a09a9679b75b6c1b2956e7879b46/typescript/analytics.ts#L50-L53
  } else {
    assertNever(data);
  }
});

// And you'd probably have some Google Analytics setup code here, something like
// https://github.com/dillonkearns/mobster/blob/2ad66f514579a09a9679b75b6c1b2956e7879b46/typescript/analytics.ts#L23-L40
