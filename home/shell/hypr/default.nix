{ config, pkgs, ... }:

{
  imports = [
    ./colors.nix
  ];

  home.packages = with pkgs; [
    hyprpaper
    brightnessctl
    mako
    slurp
    libnotify
    grim
    xdg-desktop-portal-gtk
    wl-clipboard
    kitty
    swayidle
    swaylock
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
        exec-once=hyprpaper
        exec-once=ags
        exec-once=mako
        exec-once=swayosd
        exec-once=~/.config/hypr/scripts/lock.sh

        source=~/.config/hypr/mocha.conf
        $mod = SUPER
        $left = h
        $down = j
        $right = l
        $up = k

        bezier=easeoutquint,0.22,1,0.36,1
        bezier=easeinoutquint,0.83,0,0.17,1
        bezier=overshot,0.05,0.9,0.1,1.1

        bind = $mod, RETURN, exec, kitty
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

        bind = $mod, PRINT, exec, grim - | wl-copy && notify-send "  Screenshot taken" "Copied to clipboard"
        bind = $mod SHIFT, PRINT, exec, grim -g "$(slurp -d)" - | wl-copy && notify-send "  Screenshot taken" "Copied to clipboard"
      bind = $mod CTRL, PRINT, exec, grim "$HOME/Pictures/Screenshots/$(date +%F_%T).png" && notify-send "  Screenshot taken" "Saved to ~/Pictures/Screenshots"

        bind = $mod, L, exec, swaylock -f -c 000000

        binde =  , XF86MonBrightnessUp, exec, swayosd --brightness raise
        binde =  , XF86MonBrightnessDown, exec, swayosd --brightness lower
        binde =  , XF86AudioRaiseVolume, exec, swayosd --output-volume raise
        binde =  , XF86AudioLowerVolume, exec, swayosd --output-volume lower
        binde =  , XF86AudioMute, exec, swayosd --output-volume mute-togle

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

        general {
          col.active_border = $lavender
          col.inactive_border = $overlay0
          gaps_out = 10
        }

        decoration {
          rounding = 12
          blur {
              passes = 2
              noise = 0.0125
              brightness = 0.780
          }
        }

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

        misc {
          animate_manual_resizes = true
        }

        animation=windows,1,4,default,slide
        windowrulev2 = opacity 0.88 0.95,class:(kitty)
    '';
  };

  home.file.".config/hypr/hyprpaper.conf" = {
    text = ''
      preload = ~/Pictures/Wallpapers/wallhaven-6de766.jpg
      wallpaper = eDP-1,~/Pictures/Wallpapers/wallhaven-6de766.jpg
    '';
  };

  home.file.".config/hypr/scripts/lock.sh" = {
    text = ''
      swayidle -w timeout 300 'swaylock -f -c 000000' \
        before-sleep 'swaylock -f -c 000000'&
    '';
    executable = true;
  };
}
