{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      $mod = SUPER

      bind = $mod, RETURN, exec, alacritty -e tmux
      bind = $mod SHIFT, q, killactive
      #workspaces
      ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

      input {
          touchpad {
            natural_scroll = true
          }
      }

      gestures {
        workspace_swipe = true
      }
    '';
  };
}
