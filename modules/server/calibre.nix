{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.calibre)
{
  users.groups.books = { };
  users.users.calibre-web.extraGroups = [ "books" ];
  users.users.jordy.extraGroups = [ "books" ];

  services.calibre-web = {
    enable = true;
    options = {
      calibreLibrary = "/mnt/Ssd/Data/Books";
      enableBookUploading = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /mnt/Ssd/Data/Books 0770 calibre-web books - -"
  ];
}
