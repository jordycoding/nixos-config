import Service from "resource:///com/github/Aylur/ags/service.js";
import Brightness from "./brightness.js";

class OsdService extends Service {
  static {
    Service.register(
      this,
      {
        "visibility-changed": ["boolean"],
        "value-changed": ["int"],
        "type-changed": ["string"],
      },
      {
        visibility: ["boolean", "rw"],
        value: ["int", "rw"],
        type: ["string", "rw"],
      },
    );
  }

  _visibility = false;
  _value = 0;
  _type = "";
  _timeouts = [];

  get visibility() {
    return this._visibility;
  }

  get value() {
    return this._value;
  }

  get type() {
    return this._type;
  }

  set value(value) {
    this._timeouts.forEach((timeout) => clearTimeout(timeout));
    this._value = value;
    this._visibility = true;
    this.changed("visibility");
    this._timeouts.push(
      setTimeout(() => {
        this._visibility = false;
        this.changed("visibility");
      }, 2000),
    );
  }

  set type(type) {
    this._type = type;
    this.changed("type");
  }

  set brightness(value) {
    this._type = "";
    this.value = value;
    this.changed("type");
  }

  screen() {
    this.type = "";
    this.value = Brightness.screen_value;
  }

  constructor() {
    super();
  }
}

const service = new OsdService();
globalThis.osd = service;
export default service;
