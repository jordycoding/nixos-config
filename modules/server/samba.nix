{ config, pkgs, lib, ... }:
with lib;

lib.mkIf (config.homelab.samba)
{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "tungsten";
        "netbios name" = "tungsten";
        "security" = "user";
        #use sendfile = yes
        #max protocol = smb2
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = [ "192.168.1." "127.0.0.1" "localhost" ];
        "hosts deny" = [ "0.0.0.0/0" ];
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "series" = {
        "path" = "/mnt/Media/Series";
        "browseable" = "yes";
        "guest ok" = "no";
        "create mask" = "0774";
        "directory mask" = "0770";
        "force group" = "media";
        "valid users" = "@media";
        "read only" = "no";
      };
      "movies" = {
        "path" = "/mnt/Media/Movies";
        "browseable" = "yes";
        "guest ok" = "no";
        "create mask" = "0774";
        "directory mask" = "0770";
        "force group" = "media";
        "valid users" = "@media";
        "read only" = "no";
      };
      "anime" = {
        "path" = "/mnt/Media/Anime";
        "browseable" = "yes";
        "guest ok" = "no";
        "create mask" = "0774";
        "directory mask" = "0770";
        "force group" = "media";
        "valid users" = "@media";
        "read only" = "no";
      };
      "software" = {
        "path" = "/mnt/Vault/Data/Software";
        "browseable" = "yes";
        "guest ok" = "yes";
        "create mask" = "0775";
        "directory mask" = "0775";
        "read only" = "yes";
        "write list" = "@pubwrite";
      };
      "homes" = {
        "browseable" = "yes";
        "read only" = "no";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
