{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };
}
