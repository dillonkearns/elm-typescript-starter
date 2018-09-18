import { Elm } from "./src/Main";

document.addEventListener("DOMContentLoaded", function() {
  let app = Elm.Main.init({
    flags: null
  });
  console.log(app);

  app.ports.storageStoreItem.subscribe(thing => {
    console.log("setting to...", JSON.stringify(thing));
    localStorage.setItem(thing.key, JSON.stringify(thing.value));
  });

  app.ports.lookItemUp.subscribe(key => {
    console.log("@@@lookItemUp", key);
    const lookupResult = localStorage.getItem(key);
    if (lookupResult === null) {
      app.ports.storageItemNotFound.send({ key: key });
    } else {
      app.ports.storageItemFound.send({
        key: key,
        value: JSON.parse(lookupResult)
      });
    }
  });
});
