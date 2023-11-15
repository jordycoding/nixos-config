{ config, pkgs, lib, ... }:

with lib;
let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "Dotfiles-Xps";
    rev = "f82a2d6";
    sha256 = "1lidaayajfg3a4lwcbgghrgxlr338bfn2gav0rs6yy2h0filpbqb";
  };
  laptopDotfiles = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "Dotfiles-Xps";
    rev = "f7dc4de";
    sha256 = "18nhazsbh8734mqja788anbbrkwnqgzbs4f822mjkcra8vv3vmwa";
  };
  nvimconfig = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "neovim-lua";
    rev = "cedc533";
    sha256 = "128is7q206lv4igdssl1x0kzcb6pzi3jfd63rwvl5ik7cf57l85l";
  };
  roficatppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "rofi";
    rev = "5350da41a11814f950c3354f090b90d4674a95ce";
    sha256 = "15phrl9qlbzjxmp29hak3a5k015x60w2hxjif90q82vp55zjpnhc";
  };
  dotdir = if config.dotfiles.isLaptop then laptopDotfiles else dotfiles;
in
{
  home.file = {
    ".p10k.zsh" = {
      source = "${dotdir}/p10k/.p10k.zsh";
    };

    ".config/nvim" = {
      source = "${nvimconfig}";
      recursive = true;
    };

    ".config/sway" = {
      source = "${dotdir}/sway/.config/sway";
      recursive = true;
    };

    ".config/sway/scripts" = {
      source = "${dotdir}/swaycripts/.config/sway/scripts";
      recursive = true;
    };

    ".config/waybar" = {
      source = "${dotdir}/waybar/.config/waybar";
      recursive = true;
    };

    ".tmux.conf" = {
      source = "${dotdir}/tmux/.tmux.conf";
    };

    ".config/alacritty" = {
      source = "${dotdir}/alacritty/.config/alacritty";
      recursive = true;
    };

    ".config/btop" = {
      source = "${dotdir}/btop/.config/btop";
      recursive = true;
    };

    ".config/mako" = {
      source = "${dotdir}/mako/.config/mako";
      recursive = true;
    };

    ".config/scripts" = {
      source = "${dotdir}/scripts/.config/scripts";
      recursive = true;
    };

    ".npmrc" = {
      text = "prefix = \${HOME}/.npm-packages";
    };

    ".config/rofi/config.rasi" = {
      text = ''
        configuration{
            modi: "run,drun,window";
            font: "JetBrainsMono Nerd Font Mono 12";
            icon-theme: "Oranchelo";
            show-icons: true;
            terminal: "alacritty";
            drun-display-format: "{icon} {name}";
            location: 0;
            disable-history: false;
            hide-scrollbar: true;
            display-drun: "   Apps ";
            display-run: "   Run ";
            display-window: " 﩯  Window";
            display-Network: " 󰤨  Network";
            sidebar-mode: true;
        }

        @theme "catppuccin-mocha"
      '';
    };

    ".local/share/rofi/themes" = {
      source = "${roficatppuccin}/basic/.local/share/rofi/themes";
      recursive = true;
    };
  };
}
