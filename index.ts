import { Elm } from "./src/Main";
import * as moment from "moment";
// (<any>window).moment = moment;

document.addEventListener("DOMContentLoaded", function() {
  const app = Elm.Main.init({ flags: timeUntilElmConf() });

  app.ports.setLocale.subscribe(newLocale => {
    moment.locale(newLocale);
  });

  setInterval(() => {
    console.log("sending", clockReading());
    app.ports.newClockReading.send(clockReading());
  }, 1000);
});

function timeUntilElmConf() {
  return moment("2018-09-26").fromNow();
}

moment()
  .endOf("year")
  .fromNow();

function clockReading() {
  return moment().format("LTS");
}
