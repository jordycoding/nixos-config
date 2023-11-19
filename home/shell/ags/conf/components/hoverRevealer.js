import Widget from "resource:///com/github/Aylur/ags/widget.js";

const HoverRevealer = (state, icon, label, props = {}) => {
  return Widget.EventBox({
    ...props,
    "on-hover": () => {
      state.state = true;
      setTimeout(() => {
        state.state = false;
      }, 2000);
    },
    child: Widget.Box({
      children: [
        icon,
        Widget.Revealer({
          revealChild: false,
          transitionDuration: 500,
          transition: "slide_right",
          child: label,
          connections: [[state, (self) => (self.revealChild = state.state)]],
        }),
      ],
    }),
  });
};

export default HoverRevealer;
