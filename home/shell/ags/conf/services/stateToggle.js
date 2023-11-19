import Service from "resource:///com/github/Aylur/ags/service.js";

class StateToggle extends Service {
  static {
    Service.register(
      this,
      {
        "state-changed": ["boolean"],
      },
      {
        state: ["boolean", "rw"],
      },
    );
  }

  _state = false;

  get state() {
    return this._state;
  }

  toggle() {
    this.state = !this.state;
  }

  set state(value) {
    this._state = value;
    this.emit("changed");
    this.notify("state");
  }

  constructor() {
    super();
  }
}

export default StateToggle;
