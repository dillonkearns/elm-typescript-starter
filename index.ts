import { Elm } from "./src/Main";

document.addEventListener("DOMContentLoaded", function() {
  (window as any)["Elm"] = Elm;

  const myNode = document.getElementsByTagName("body")[0];
  if (myNode) {
    let app = Elm.Main.init({
      node: myNode,
      flags: null
    });
    app.ports.hello.subscribe(name => console.log(`Hello ${name}!!`));
    app.ports.reply.send(12345);
  }
});
