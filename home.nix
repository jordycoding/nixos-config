{ config, pkgs, lib, ... }:

with lib;

let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "Dotfiles-Xps";
    rev = "40ad2f0";
    sha256 = "10sr3nq5wp2sxqmr6cx14zvhp3l2h50lf9swwp15wr8vzv55hj4j";
  };
  laptopDotfiles = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "Dotfiles-Xps";
    rev = "8cd557a";
    sha256 = "0dawiq73dzh87xqaw98m282s9kcarpcgzmwdp6aa2q5wx22i47zc";
  };
  nvimconfig = pkgs.fetchFromGitHub {
    owner = "jordycoding";
    repo = "neovim-lua";
    rev = "5267a90";
    sha256 = "0g4ayzjy34lbiy1z6qxv9mjah7mdda0z45w32fdnf1qz4aw1w10k";
  };
in
{
  options.dotfiles = {
    isLaptop = mkEnableOption "Use laptop dotfiles";
  };

  config = mkMerge [
    (mkIf config.dotfiles.isLaptop {
      home.file = {
        ".p10k.zsh" = {
          source = "${laptopDotfiles}/p10k/.p10k.zsh";
        };

        ".config/nvim" = {
          source = "${nvimconfig}";
          recursive = true;
        };

        ".config/sway" = {
          source = "${laptopDotfiles}/sway/.config/sway";
          recursive = true;
        };

        ".config/sway/scripts" = {
          source = "${laptopDotfiles}/swaycripts/.config/sway/scripts";
          recursive = true;
        };

        ".config/waybar" = {
          source = "${laptopDotfiles}/waybar/.config/waybar";
          recursive = true;
        };

        ".tmux.conf" = {
          source = "${laptopDotfiles}/tmux/.tmux.conf";
        };

        ".config/alacritty" = {
          source = "${laptopDotfiles}/alacritty/.config/alacritty";
          recursive = true;
        };

        ".config/btop" = {
          source = "${laptopDotfiles}/btop/.config/btop";
          recursive = true;
        };

        ".config/mako" = {
          source = "${laptopDotfiles}/mako/.config/mako";
          recursive = true;
        };

        ".config/scripts" = {
          source = "${laptopDotfiles}/scripts/.config/scripts";
          recursive = true;
        };
      };
    })
    (mkIf (!config.dotfiles.isLaptop) {
      home.file = {
        ".p10k.zsh" = {
          source = "${dotfiles}/p10k/.p10k.zsh";
        };

        ".config/nvim" = {
          source = "${nvimconfig}";
          recursive = true;
        };

        ".config/sway" = {
          source = "${dotfiles}/sway/.config/sway";
          recursive = true;
        };

        ".config/sway/scripts" = {
          source = "${dotfiles}/swaycripts/.config/sway/scripts";
          recursive = true;
        };

        ".config/waybar" = {
          source = "${dotfiles}/waybar/.config/waybar";
          recursive = true;
        };

        ".tmux.conf" = {
          source = "${dotfiles}/tmux/.tmux.conf";
        };

        ".config/alacritty" = {
          source = "${dotfiles}/alacritty/.config/alacritty";
          recursive = true;
        };

        ".config/btop" = {
          source = "${dotfiles}/btop/.config/btop";
          recursive = true;
        };

        ".config/mako" = {
          source = "${dotfiles}/mako/.config/mako";
          recursive = true;
        };

        ".config/scripts" = {
          source = "${dotfiles}/scripts/.config/scripts";
          recursive = true;
        };
      };
    })
    {
      home.file = {
        ".npmrc" = {
          text = "prefix = \${HOME}/.npm-packages";
        };
      };
      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      home.username = "jordy";
      home.homeDirectory = "/home/jordy";

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "21.11";

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;


      home.packages = [
        pkgs.gh
        pkgs.neovim
        pkgs.rofi
        pkgs.sway
        pkgs.thefuck
        pkgs.alacritty
        pkgs.mako
        pkgs.swayidle
        pkgs.swaylock
        pkgs.waybar
        pkgs.grim
        pkgs.slurp
        pkgs.alacritty
        pkgs.wlogout
        pkgs.playerctl
        pkgs.pulseaudio
        pkgs.wl-clipboard
        pkgs.gnome.zenity
        pkgs.pavucontrol
        pkgs.xdg-utils
        pkgs.xdg-user-dirs
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-wlr
        pkgs.rnix-lsp
        pkgs.jdt-language-server
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      programs.zsh = {
        enable = true;
        autocd = true;
        enableAutosuggestions = true;
        enableCompletion = true;

        shellAliases = {
          update = "doas nixos-rebuild switch --upgrade";
          ll = "exa -al --icons";
          ls = "exa";
          vim = "nvim";
          vi = "nvim";
          v = "nvim";
          gs = "git status";
          ga = "git add";
          gc = "git commit -m";
          gch = "git checkout";
          gcb = "git checkout -b";
          gp = "git push";
          gpl = "git pull";
          gst = "git stash";
          gsp = "git stash pop";
          dup = "docker-compose up";
          ddown = "docker-compose down";
          sudo = "doas";
          cat = "bat";
          top = "btop";
          gl = "git log --graph --pretty=oneline --abbrev-commit";
        };

        history = {
          size = 10000;
          path = "${config.xdg.dataHome}/zsh/history";
        };

        sessionVariables = {
          EDITOR = "nvim";
        };

        plugins = [
          {
            name = "zsh-completions";
            src = pkgs.zsh-completions;
          }
          {
            file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            name = "zsh-autosuggestions";
            src = pkgs.zsh-autosuggestions;
          }
          {
            file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
            name = "zsh-history-substring-search";
            src = pkgs.zsh-history-substring-search;
          }
          {
            file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
            name = "zsh-syntax-highlighting";
            src = pkgs.zsh-syntax-highlighting;
          }
          {
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            src = pkgs.zsh-powerlevel10k;
            name = "powerlevel10k";
          }
          {
            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            src = pkgs.zsh-vi-mode;
            name = "zsh-vi-mode";
          }
        ];

        initExtra = ''
          setopt hist_ignore_all_dups
          setopt hist_reduce_blanks
          setopt inc_append_history
          setopt share_history

          setopt correct_all
          setopt auto_list
          setopt auto_menu
          setopt always_to_end

          zstyle ':completion:*' menu
          zstyle ':completion:*' menu select
          zstyle ':completion:*' group-name ""
          zstyle ':completion:::::' completer _expand _complete _ignored _approximate

          bindkey '^[[A' history-substring-search-up
          bindkey '^[OA' history-substring-search-up
          bindkey '^[[B' history-substring-search-down
          bindkey '^[OB' history-substring-search-down

          export PATH=~/.npm-packages/bin:$PATH

          eval $(thefuck --alias)
          source ~/.p10k.zsh
          # Checks if tmux is available
          if [ -x $(command -v tmux) ]; then
            # Only runs pfetch when current pane is the only pane in the windows
            if [[ $(tmux list-panes | wc -l) = "1" ]]; then
              pfetch
            fi
          else
           pfetch
          fi
        '';

      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.git = {
        enable = true;
        userName = "Jordy Alkema";
        userEmail = "6128820+jordycoding@users.noreply.github.com";
        extraConfig = {
          pull.rebase = true;
        };
      };

      dconf.settings = {
        "org/gnome/desktop/input-sources" = {
          "xkb-options" = [ "caps:escape" ];
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          "tap-to-click" = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          "button-layout" = "appmenu:minimize,maximize,close";
        };
      };

      gtk.theme.name = "Adw-gtk3";
    }
  ];
}
