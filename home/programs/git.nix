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
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcC/4VsrWn7C0EgJE7wUfNtEeIaTM0Y/5eT4fl6+ZIO";
      gpg.format = "ssh";
      gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      commit.gpgsign = true;
    };
  };
}
