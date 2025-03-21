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
    ];
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
      };
      "DP-2" = {
        position = {
          x = 3440;
          y = 0;
        };
      };
    };

  };

}
