import { Elm } from "./src/Main";
import * as moment from "moment";

document.addEventListener("DOMContentLoaded", function() {
  const app = Elm.Main.init({ flags: null });
  function showClockReading() {
    console.log(clockReading());
  }

  /*

    Boilerplate










  */
  function setLocale(newLocale: string) {
    moment.locale(newLocale);
    showClockReading();
  }

  function clockReading() {
    return moment().format("LL LTS");
  }

  setInterval(showClockReading, 1000);
});
