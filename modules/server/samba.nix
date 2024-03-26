{ config, pkgs, lib, ... }:
with lib;

lib.mkIf (config.homelab.samba)
{
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = tungsten
      netbios name = tungsten
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      shows = {
        path = "/mnt/Multimedia/TV\ Shows";
        browseable = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0760";
        "force group" = "media";
        "valid users" = "@media";
      };
      movies = {
        path = "/mnt/Multimedia/Movies";
        browseable = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0760";
        "force group" = "media";
        "valid users" = "@media";
      };
      anime = {
        path = "/mnt/Multimedia/Anime";
        browseable = "yes";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0760";
        "force group" = "media";
        "valid users" = "@media";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
