{ config, pkgs, lib, generated, ... }:

with lib;
let
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in
{
  imports = [
    ./gtk.nix
  ];
  home.file = {
    ".p10k.zsh" = {
      source = "${generated.dotfiles.src}/p10k/.p10k.zsh";
    };

    ".config/nvim" = {
      source = "${generated.neovim.src}";
      recursive = true;
    };

    ".config/sway" = {
      source = "${generated.dotfiles.src}/sway/.config/sway";
      recursive = true;
    };

    ".config/sway/scripts" = {
      source = "${generated.dotfiles.src}/swaycripts/.config/sway/scripts";
      recursive = true;
    };

    ".config/waybar" = {
      source = "${generated.dotfiles.src}/waybar/.config/waybar";
      recursive = true;
    };

    ".tmux.conf" = {
      source = "${generated.dotfiles.src}/tmux/.tmux.conf";
    };

    ".config/alacritty" = {
      source = "${generated.dotfiles.src}/alacritty/.config/alacritty";
      recursive = true;
    };

    ".config/alacritty/catppuccin-mocha.toml" = {
      source = "${generated.alacrittycatppuccin.src}";
    };

    ".config/btop" = {
      source = "${generated.dotfiles.src}/btop/.config/btop";
      recursive = true;
    };

    ".config/scripts" = {
      source = "${generated.dotfiles.src}/scripts/.config/scripts";
      recursive = true;
    };

    ".npmrc" = {
      text = "prefix = \${HOME}/.npm-packages";
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
      source = "${generated.kittycatppuccin.src}/themes";
      recursive = true;
    };
  };
}
