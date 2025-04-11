{ config, pkgs, lib, ... }:

{
  options = {
    var.adClient = lib.mkEnableOption "Make device AD Client";
  };
  config = lib.mkIf (config.var.adClient) {
    environment.systemPackages = with pkgs; [
      adcli
      oddjob
      samba4Full
      sssd
      krb5
      realmd
    ];
    security = {
      krb5 = {
        enable = true;
        settings = {
          libdefaults = {
            udp_preference_limit = 0;
            default_realm = "AD.ALKEMA.CO";
          };
        };
      };

      pam = {
        makeHomeDir.umask = "077";
        services.login.makeHomeDir = true;
        services.sshd.makeHomeDir = true;
      };
    };

    services = {
      nscd = {
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
      sssd = {
        enable = true;
        config = ''
          [sssd]
          domains = ad.alkema.co
          config_file_version = 2
          services = nss, pam

          [domain/your_domain_lowercase]
          override_shell = /run/current-system/sw/bin/zsh
          krb5_store_password_if_offline = True
          cache_credentials = True
          krb5_realm = AD.ALKEMA.CO
          realmd_tags = manages-system joined-with-samba
          id_provider = ad
          fallback_homedir = /home/%u
          ad_domain = ad.alkema.co
          use_fully_qualified_names = false
          ldap_id_mapping = false
          auth_provider = ad
          access_provider = ad
          chpass_provider = ad
          ad_gpo_access_control = permissive
          enumerate = true
        '';
      };
    };

    systemd = {
      services.realmd = {
        desscription = "Realm discovery service";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          type = "dbus";
          BusName = "org.freekdesktop.realmd";
          ExecStart = "${pkgs.realmd}/libexec/realmd";
          User = "root";
        };
      };
    };
  };
}
