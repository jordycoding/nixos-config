{ config, pkgs, ... }:

{
  imports = [
    ./colors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      exec-once=ags
      source=~/.config/hypr/mocha.conf
      $mod = SUPER
      $left = h
      $down = j
      $right = l
      $up = k


      bind = $mod, RETURN, exec, alacritty -e tmux
      bind = $mod SHIFT, q, killactive
      bind = $mod SHIFT, e, exit

      bind = $mod, $left, movefocus, l
      bind = $mod, $down, movefocus, d
      bind = $mod, $right, movefocus, r
      bind = $mod, $up, movefocus, u

      bind = $mod, d, exec, rofi -show drun

      bind = $mod, r, submap, resize

      bind = $mod SHIFT, $left, swapwindow, l
      bind = $mod SHIFT, $down, swapwindow, d
      bind = $mod SHIFT, $right, swapwindow, r
      bind = $mod SHIFT, $up, swapwindow, u

      bind = $mod SHIFT, D, exec, hyprctl keyword general:layout "dwindle"
      bind = $mod SHIFT, M, exec, hyprctl keyword general:layout "master"

      bind = CTRL, SHIFT, exec, pkill ags && ags

      #resize
      submap=resize
      binde=,$right,resizeactive,10 0
      binde=,$left,resizeactive,-10 0
      binde=,$up,resizeactive,0 -10
      binde=,$down,resizeactive,0 10

      bind=,escape,submap,reset
      submap = reset
      
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
          kb_options=caps:escape
      }

      gestures {
        workspace_swipe = true
      }

      dwindle {
        force_split = 2
      }
    '';
  };
}
