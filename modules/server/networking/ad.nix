{ config, lib, pkgs, ... }:

{
  options.homelab.ad = lib.mkEnableOption "Enable Active Directory integration";
  config = lib.mkIf config.homelab.ad {
    environment.systemPackages = with pkgs;[
      adcli
      samba4Full
      krb5
      realmd
      oddjob
      sssd
    ];
    security = {
      krb5 = {
        enable = true;
        settings = {
          libdefaults = {
            udp_preference_limit = 0;
            default_realm = "AD.ALKEMA.CO";
            dns_lookup_realm = false;
            dns_lookup_kdc = true;
            rnds = false;
          };
        };
      };
      pam.krb5.enable = false;
    };
    services.nscd = {
      enable = true;
      config = ''
        server-user nscd
        enable-cache hosts yes
        positive-time-to-live hosts 0
        negative-time-to-live hosts 0
        shared hosts yes
        enable-cache passwd no
        enable-cache group no
        enable-cache netgroup no
        enable-cache services no
      '';
    };
    systemd = {
      services.realmd = {
        description = "Realm Discovery Service";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          Type = "dbus";
          BusName = "org.freedesktop.realmd";
          ExecStart = "${pkgs.realmd}/libexec/realmd";
          User = "root";
        };
      };
    };
    system.nssDatabases = {
      passwd = [ "winbind" ];
      group = [ "winbind" ];
    };
    networking = {
      nameservers = lib.mkForce [
        "192.168.1.75"
        "127.0.0.1"
      ];
    };
  };
}
