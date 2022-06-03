{ config, pkgs, ... }:

let dotfiles = pkgs.fetchFromGitHub {
  owner = "jordycoding";
  repo = "Dotfiles-Xps";
  rev = "c4dfb8e";
  sha256 = "kgdkYOddanBYT81dE8jjD6bDPTBqe8vKr1awX8v9zE=";
}; 
nvimconfig = pkgs.fetchFromGitHub {
  owner = "jordycoding";
  repo = "neovim-lua";
  rev = "1.0.0";
  sha256 = "qFb8agBFl2ZHfgWM2IsV39UZeBjfA3ll+kvHbPZnoiU=";
}; in
{
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
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.thefuck
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    shellAliases = {
      update = "doas nixos-rebuild switch --upgrade";
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
    ];

    initExtra =  ''
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

      eval $(thefuck --alias)
      source .p10k.zsh
    '';

  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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
  };
}
