import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import Brightness from "./services/brightness.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";

const Workspaces = () =>
  Widget.Box({
    classNames: ["workspaces", "box"],
    connections: [
      [
        Hyprland.active.workspace,
        (self) => {
          const arr = Array.from({ length: 10 }, (_, i) => i + 1);
          self.children = arr.map((i) =>
            Widget.Button({
              onClicked: () => execAsync(`hyprctl dispatch workspace ${i}`),
              child: Widget.Label(
                `${Hyprland.active.workspace.id == i ? "" : ""}`,
              ),
              className: Hyprland.active.workspace.id == i ? "focused" : "",
            }),
          );
        },
      ],
    ],
  });

const Clock = () =>
  Widget.Label({
    classNames: ["clock", "box"],
    connections: [
      [
        1000,
        (self) =>
          execAsync(["date", "+%H:%M %b %e"])
            .then((date) => (self.label = ` ${date}`))
            .catch(console.error),
      ],
    ],
  });

const BrightnessLabel = () =>
  Widget.Label({
    classNames: ["brightness", "box"],
    binds: [
      ["label", Brightness, "screen-value", (v) => `󰃞 ${Math.round(v * 100)}`],
    ],
    connections: [
      Brightness,
      (self) => {
        self.label = `󰃞 ${Math.round(Brightness.screenValue * 100)}`;
      },
      "notify::screen-value",
    ],
  });

const BatteryLabel = () =>
  Widget.Box({
    binds: [
      [
        "classNames",
        Battery,
        "percent",
        (percent) => [
          ...["battery", "box"],
          percent > 50 ? "green" : percent > 20 ? "yellow" : "red",
        ],
      ],
    ],
    children: [
      Widget.Icon({
        connections: [
          [
            Battery,
            (self) => {
              self.icon = `battery-level-${
                Math.floor(Battery.percent / 10) * 10
              }-symbolic`;
            },
          ],
        ],
      }),
      Widget.Label({
        connections: [
          [
            Battery,
            (self) => {
              self.label = ` ${Battery.percent}%`;
            },
          ],
        ],
      }),
    ],
  });

const Left = () =>
  Widget.Box({
    children: [Workspaces()],
    className: "left",
  });

const Center = () =>
  Widget.Box({
    children: [Clock()],
    className: "center",
  });

const Right = () =>
  Widget.Box({
    className: "right",
    hpack: "end",
    children: [BrightnessLabel(), BatteryLabel()],
  });

const Bar = ({ monitor } = {}) =>
  Widget.Window({
    name: `bar-${monitor}`,
    className: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusive: true,
    child: Widget.CenterBox({
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });

export default {
  style: App.configDir + "/style.css",
  windows: [Bar()],
};
