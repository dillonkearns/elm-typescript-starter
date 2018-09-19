import { Elm } from "./src/Main";
import * as moment from "moment";

document.addEventListener("DOMContentLoaded", function() {
  const app = Elm.Main.init({ flags: timeUntilElmConf() });
  const sendClockReading = () => {
    app.ports.newClockReading.send(clockReading());
  };

  app.ports.setLocale.subscribe(newLocale => {
    moment.locale(newLocale);
    sendClockReading();
  });

  setInterval(sendClockReading, 1000);
});

function timeUntilElmConf() {
  return moment("2018-09-26").fromNow();
}

moment()
  .endOf("year")
  .fromNow();

function clockReading() {
  return moment().format("LL LTS");
}
