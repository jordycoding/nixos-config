import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import Brightness from "./services/brightness.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import Network from "resource:///com/github/Aylur/ags/service/network.js";
import globalState from "./globalState.js";
import HoverRevealer from "./components/hoverRevealer.js";

// const OsdTest = () =>
//   Widget.Box({
//     vertical: false,
//     classNames: ["osd"],
//     children: [
//       Widget.Label({
//         connections: [
//           [
//             Osd,
//             (self) => {
//               self.label = Osd.type;
//             },
//             "notify::type",
//           ],
//         ],
//         classNames: ["text", "mr-2"],
//         label: "test",
//       }),
//       Widget.ProgressBar({
//         vpack: "center",
//         fraction: 0.5,
//         connections: [
//           [
//             Brightness,
//             (self) => {
//               self.fraction = Brightness.screen_value;
//             },
//             "notify::screen-value",
//           ],
//         ],
//       }),
//     ],
//   });
//
// const osdMon = ({ monitor } = {}) =>
//   Widget.Window({
//     css: "background: transparent;",
//     visible: false,
//     name: "osd",
//     anchor: ["top"],
//     monitor,
//     layer: "overlay",
//     child: OsdTest(),
//     connections: [[Osd, (self) => (self.visible = Osd.visibility)]],
//   });
//
const Workspaces = () =>
  Widget.Box({
    classNames: ["workspaces", "box", "sapphire"],
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
  Widget.Box({
    children: [
      Widget.Label({
        classNames: ["green", "mr-1"],
        label: "",
      }),
      Widget.Label({
        classNames: ["mr-2"],
        connections: [
          [
            1000,
            (self) =>
              execAsync(["date", "+%H:%M"])
                .then((date) => (self.label = ` ${date}`))
                .catch(console.error),
          ],
        ],
      }),
    ],
  });

const VolumeIndicator = () =>
  HoverRevealer(
    globalState.volume,
    Widget.Icon({
      classNames: ["mr-1", "sky"],
      connections: [
        [
          Audio,
          (self) => {
            if (!Audio.speaker) return;

            const vol = Audio.speaker.volume * 100;
            const icon = [
              [101, "overamplified"],
              [67, "high"],
              [34, "medium"],
              [1, "low"],
              [0, "muted"],
            ].find(([threshold]) => threshold <= vol)[1];

            self.icon = `audio-volume-${icon}-symbolic`;
            self.tooltipText = `Volume ${Math.floor(vol)}%`;
          },
          "speaker-changed",
        ],
      ],
    }),
    Widget.Label({
      connections: [
        [
          Audio,
          (self) => {
            const vol = Audio.speaker.volume * 100;
            self.label = ` ${Math.floor(vol)} %`;
          },
          "speaker-changed",
        ],
      ],
    }),
  );

const Date = () =>
  Widget.Box({
    children: [
      Widget.Label({
        classNames: ["green", "mr-1"],
        label: "󰸗",
      }),
      Widget.Label({
        connections: [
          [
            10000,
            (self) =>
              execAsync(["date", "+%A %b %e"])
                .then((date) => (self.label = ` ${date}`))
                .catch(console.error),
          ],
        ],
      }),
    ],
  });

const Separator = () =>
  Widget.Label({
    className: "separator",
    label: "|",
  });

const DateTimeBox = () =>
  Widget.Box({
    className: "box",
    children: [Clock(), Date()],
  });

const WifiIndicator = () =>
  HoverRevealer(
    globalState.wifi,
    Widget.Icon({
      classNames: ["mr-1", "teal"],
      binds: [["icon", Network.wifi, "icon-name"]],
    }),
    Widget.Label({
      binds: [["label", Network.wifi, "ssid"]],
    }),
  );

const WiredIndicator = () =>
  Widget.Icon({
    binds: [["icon", Network.wired, "icon-name"]],
  });

const NetworkIndicator = () =>
  Widget.Stack({
    items: [
      ["wifi", WifiIndicator()],
      ["wired", WiredIndicator()],
    ],
    binds: [["shown", Network, "primary", (p) => p || "wifi"]],
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
  HoverRevealer(
    globalState.battery,
    Widget.Icon({
      className: "mr-1",
      connections: [
        [
          Battery,
          (self) => {
            self.icon = Battery.icon_name;
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
    {
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
    },
  );

const Left = () =>
  Widget.Box({
    children: [Workspaces()],
    className: "left",
  });

const Center = () =>
  Widget.Box({
    children: [],
    className: "center",
  });

const Right = () =>
  Widget.Box({
    className: "right",
    hpack: "end",
    children: [
      NetworkIndicator(),
      VolumeIndicator(),
      Separator(),
      BatteryLabel(),
      Separator(),
      DateTimeBox(),
    ],
  });

const Bar = ({ monitor } = {}) =>
  Widget.Window({
    name: `bar-${monitor}`,
    className: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusive: true,
    child: Widget.CenterBox({
      className: "panel",
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });

export default {
  style: App.configDir + "/styles/bar.css",
  windows: [Bar()],
};
