{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jordy Alkema";
    userEmail = "6128820+jordycoding@users.noreply.github.com";
    lfs.enable = true;
    signing = {
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcC/4VsrWn7C0EgJE7wUfNtEeIaTM0Y/5eT4fl6+ZIO";
      signByDefault = true;
      signer = "${pkgs._1password-gui}/bin/op-ssh-sign";
    };
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
