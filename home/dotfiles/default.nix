{ config, pkgs, lib, ... }:

with lib;
let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "Dotfiles-Xps";
    rev = "17f288db11205d8fbdda18ae8ab533ac5ca251a6";
    sha256 = "1ib91nrvc4f5js3nbh1g3fr4i81dqn9nmhpw5051qxmxsbw8mkmf";
  };
  laptopDotfiles = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "Dotfiles-Xps";
    rev = "74d70eb";
    sha256 = "1ajj9kyf6i23nlv271diyprdifbrsr9q93zfrv9kkd7cfi42ldg1";
  };
  nvimconfig = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "neovim-lua";
    rev = "c80fd6f";
    sha256 = "18s3kf9xbn2kp395w15ihzjyp4jlf9xzikm9am9zljjc9psi8wxj";
  };
  roficatppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "rofi";
    rev = "5350da41a11814f950c3354f090b90d4674a95ce";
    sha256 = "15phrl9qlbzjxmp29hak3a5k015x60w2hxjif90q82vp55zjpnhc";
  };
  makocatppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "mako";
    rev = "9dd088aa5f4529a3dd4d9760415e340664cb86df";
    sha256 = "097x9jrkzvml6ngnhxwkzzl1l2awwv73yli1mhmpw83c0n8xck4x";
  };
  kittycatppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "kitty";
    rev = "4820b3ef3f4968cf3084b2239ce7d1e99ea04dda";
    sha256 = "11gp5j3jgvy681d3x369312k2vpc5bgmnvgiwzznywdkzgwv355r";
  };
  alacrittycatppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-mocha.toml";
    sha256 = "sha256-/N3rwIZ0SJBiE7TiBs4pEjhzM1f2hr26WXM3ifUzzOY=";
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

    ".config/alacritty/catppuccin-mocha.toml" = {
      source = "${alacrittycatppuccin}";
    };

    ".config/btop" = {
      source = "${dotdir}/btop/.config/btop";
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

    ".config/mako/config" = {
      text = ''

        default-timeout=5000
      '' + (builtins.readFile "${makocatppuccin}/src/mocha");
    };

    ".config/kitty/kitty.conf" = {
      text = ''       
        # BEGIN_KITTY_THEME
        # Catppuccin Kitty Mocha
        include themes/mocha.conf
        # END_KITTY_THEME
        font_family JetBrains Mono
        font_size 12.0

        tab_bar_min_tabs            1
        tab_bar_edge                bottom
        tab_bar_style               powerline
        tab_powerline_style         slanted
        tab_title_template          {title}{' :{}:'.format(num_windows) if num_windows > 1 else /'/'}
     '';
    };

    ".config/kitty/themes" = {
      source = "${kittycatppuccin}/themes";
      recursive = true;
    };
  };
}
