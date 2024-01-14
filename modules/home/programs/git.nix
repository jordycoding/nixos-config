{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jordy Alkema";
    userEmail = "6128820+jordycoding@users.noreply.github.com";
    lfs.enable = true;
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
