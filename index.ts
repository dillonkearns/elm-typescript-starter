import { Elm } from "./src/Main";

document.addEventListener("DOMContentLoaded", function() {
  let app = Elm.Main.init({
    flags: null
  });
  app.ports.hello.subscribe(name => console.log(`Hello ${name}!!`));
  app.ports.reply.send(12345);
});
