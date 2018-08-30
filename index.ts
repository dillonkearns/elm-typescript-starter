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
