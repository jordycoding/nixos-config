{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    shellAliases = {
      update = "(cd /etc/nixos; doas nix flake update) && doas nixos-rebuild switch --upgrade --flake /etc/nixos";
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
      dcu = "doas docker compose up";
      dcd = "doas docker compose down";
      dcp = "doas docker compose stop";
      dcub = "doas docker compose up --build";
      dcud = "doas docker compose up -d";
      dubd = "doas docker compose up --build -d";
      sudo = "doas";
      cat = "bat";
      top = "btop";
      gl = "git log --graph --pretty=oneline --abbrev-commit";
      bdinstall = "nix run nixpkgs#betterdiscordctl install";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    sessionVariables = {
      EDITOR = "nvim";
      DOTNET_ROOT = pkgs.dotnet-sdk_8.outPath;
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
      {
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
        src = pkgs.zsh-you-should-use;
        name = "zsh-you-should-use";
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

      export GEM_HOME="$HOME/gems"
      export PATH=~/.local/share/coursier/bin:~/.dotnet/tools:~/.npm-packages/bin:~/.config/composer/vendor/bin:$HOME/gems/bin:$PATH

      eval $(thefuck --alias)
      eval "$(direnv hook zsh)"
      source ~/.p10k.zsh
      # Checks if tmux is available
      if [ -x $(command -v tmux) ]; then
        # Only runs pfetch when current pane is the only pane in the windows
        if [[ $(tmux list-panes &> /dev/null | wc -l) = "1" ]]; then
          pfetch
        fi
      else
       pfetch
      fi
    '';

  };
}
