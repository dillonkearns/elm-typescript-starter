import * as Elm from "./src/Main";
let app = Elm.Main.fullscreen();
app.ports.hello.subscribe(name => console.log(`Hello ${name}!!`));
app.ports.reply.send(12345);
