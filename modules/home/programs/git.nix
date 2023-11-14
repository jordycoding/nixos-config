{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jordy Alkema";
    userEmail = "6128820+jordycoding@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
