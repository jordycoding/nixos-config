{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.calibre)
{
  users.groups.books = { };
  users.users.calibre-web.extraGroups = [ "books" ];
  users.users.jordy.extraGroups = [ "books" ];

  services.calibre-web = {
    enable = true;
    options = {
      calibreLibrary = "/mnt/Vault/Data/Books";
      enableBookUploading = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /mnt/Vault/Data/Books 0770 calibre-web books - -"
  ];
}
