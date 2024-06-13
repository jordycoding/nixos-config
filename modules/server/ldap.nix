{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.ldap)
{
  users.groups.ldap = { };
  users.users.ldap = {
    group = "ldap";
    isSystemUser = true;
  };

  age.secrets.ldapRootPass = {
    file = ../../secrets/ldapRootPass.age;
    owner = "ldap";
    group = "root";
    mode = "770";
  };

  services.openldap = {
    enable = true;
    urlList = [ "ldap:///" ];
    user = "ldap";
    settings = {
      attrs = {
        olcLogLevel = "conns config";
      };
      children = {
        "cn=schema".includes = [
          "${pkgs.openldap}/etc/schema/core.ldif"
          "${pkgs.openldap}/etc/schema/cosine.ldif"
          "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
        ];

        "olcDatabase={1}mdb".attrs = {
          objectClass = [ "olcDatabaseConfig" "olcMdbConfig" ];

          olcDatabase = "{1}mdb";
          olcDbDirectory = "/var/lib/openldap/data";

          olcSuffix = "dc=alkema,dc=co";

          /* your admin account, do not use writeText on a production system */
          olcRootDN = "cn=admin,dc=alkema,dc=co";
          olcRootPW.path = "/run/agenix/ldapRootPass";

          olcAccess = [
            /* custom access rules for userPassword attributes */
            ''{0}to attrs=userPassword
                by self write
                by anonymous auth
                by * none''

            /* allow read on anything else */
            ''{1}to *
                by * read''
          ];
        };
      };
    };
  };
}
