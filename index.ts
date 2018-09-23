import { Elm } from "./src/Main";
import * as moment from "moment";

document.addEventListener("DOMContentLoaded", function() {
  const app = Elm.Main.init({ flags: clockReading() });
  function showClockReading() {
    console.log(clockReading());
    // app.ports.newClockReading.send(clockReading());
    app.ports.timeChanged.send(clockReading());
  }

  function setLocale(newLocale: string) {
    moment.locale(newLocale);
    // showClockReading();
  }

  function clockReading() {
    return moment().format("LL LTS");
  }

  setInterval(showClockReading, 1000);
});
