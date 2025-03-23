{ config, lib, osConfig, ... }:

{
  config.programs.niri.settings = {
    spawn-at-startup = [
      {
        command = [ "swww-daemon" ];
      }
      {
        command = [ "waypaper --restore" ];
      }
      {
        command = [ "xwayland-satellite" ];
      }
      {
        command = [ "dunst" ];
      }
    ];
    environment = {
      # For xwayland-satellite
      DISPLAY = ":0";
    };
    input = {
      keyboard = {
        xkb = {
          options = "caps:escape";
        };
      };
    };
    outputs = lib.mkIf (osConfig.networking.hostName == "Argon") {
      "DP-1" = {
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          height = 3440;
          width = 3440;
          refresh = 99.982;
        };
        # variable-refresh-rate = true;
      };
      "DP-2" = {
        position = {
          x = 3440;
          y = 0;
        };
        mode = {
          width = 2560;
          height = 1440;
          refresh = 180.000;
        };
        variable-refresh-rate = true;
      };
    };

  };

}
