import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { exec, execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const Workspaces = () =>
  Widget.Box({
    className: "workspaces",
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

const Left = () =>
  Widget.Box({
    children: [Workspaces()],
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
    }),
  });

export default {
  style: App.configDir + "/style.css",
  windows: [Bar()],
};
