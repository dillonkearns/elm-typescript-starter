import { Elm } from "./src/Main";
import * as moment from "moment";

const app = Elm.Main.init({ flags: null });
function showLocalizedTime() {
  console.log(clockReading());
}

function setLocale(newLocale: string) {
  moment.locale(newLocale);
  showLocalizedTime();
}

function clockReading() {
  return moment().format("LL LTS");
}

setInterval(showLocalizedTime, 1000);
