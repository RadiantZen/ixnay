{ config, lib, ... }:

{
  options = {
    ixnay.services.lldap.enable = lib.mkEnableOption "Pocket ID";
  };

  config = lib.mkIf config.ixnay.services.lldap.enable {
    sops = {
      secrets = {
        "systemService/lldap/MAXMIND_LICENSE_KEY" = { };
        "systemService/lldap/ENCRYPTION_KEY" = { };
      };

      templates = {
        "lldap.env" = {
          owner = config.services.lldap.user;
          content = ''
            MAXMIND_LICENSE_KEY=${config.sops.placeholder."systemService/lldap/MAXMIND_LICENSE_KEY"}
            ENCRYPTION_KEY=${config.sops.placeholder."systemService/lldap/ENCRYPTION_KEY"}
          '';
        };
      };
    };

    services = {
      lldap = {
        enable = true;
        settings = {
          ldap_port = 3890;

        };
      };

      caddy = {
        virtualHosts = {
          "lldap.radiantzen.net" = {
            extraConfig = ''
              reverse_proxy http://${builtins.toString config.services.lldap.settings.HOST}:${builtins.toString config.services.lldap.settings.PORT}
            '';
          };
        };
      };
    };
  };
}
