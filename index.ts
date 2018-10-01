import { Elm } from "./src/Main";
import * as moment from "moment";

const app = Elm.Main.init({ flags: { startTime: clockReading() } });
function showLocalizedTime() {
  console.log(clockReading());
  app.ports.timeChanged.send(clockReading());
}

app.ports.setLocale.subscribe(newLocale => {
  setLocale(newLocale);
});

function setLocale(newLocale: string) {
  moment.locale(newLocale);
  showLocalizedTime();
}

function clockReading() {
  return moment().format("LL LTS");
}

setInterval(showLocalizedTime, 1000);
