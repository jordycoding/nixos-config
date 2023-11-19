import StateToggle from "./services/stateToggle.js";

export default {
  wifi: new StateToggle(),
  volume: new StateToggle(),
  battery: new StateToggle(),
};
