{ config, ... }:

{
  programs.niri.settings.window-rules = [
    {
      matches = [
        {
          app-id = "^org\.wezfurlong\.wezterm$";
        }
      ];
      default-column-width = { };
    }
    {
      focus-ring = {
        active.color = "#89dceb";
        inactive.color = "#fab387";
        width = 2;
      };
      geometry-corner-radius = let radius = 16.0; in {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };
    }
  ];
}
