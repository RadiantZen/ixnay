{ config, lib, ... }:

{
  options = {
    ixnay.services.pocket-id.enable = lib.mkEnableOption "Pocket ID";
  };

  config = lib.mkIf config.ixnay.services.pocket-id.enable {
    sops = {
      secrets = {
        "systemService/pocket-id/MAXMIND_LICENSE_KEY" = { };
        "systemService/pocket-id/ENCRYPTION_KEY" = { };
      };

      templates = {
        "pocket-id.env" = {
          owner = config.services.pocket-id.user;
          content = ''
            MAXMIND_LICENSE_KEY=${config.sops.placeholder."systemService/pocket-id/MAXMIND_LICENSE_KEY"}
            ENCRYPTION_KEY=${config.sops.placeholder."systemService/pocket-id/ENCRYPTION_KEY"}
          '';
        };
      };
    };

    services = {
      pocket-id = {
        enable = true;
        environmentFile = config.sops.templates."pocket-id.env".path;
        settings = {
          TRUST_PROXY = true;
          APP_URL = "https://oidc.radiantzen.net";
          PORT = 1411;
          HOST = "127.0.0.1";
          KEYS_STORAGE = "database";
          UI_CONFIG_DISABLED = true;
          EMAILS_VERIFIED = true;
        };
      };

      caddy = {
        virtualHosts = {
          "oidc.radiantzen.net" = {
            extraConfig = ''
              reverse_proxy http://${builtins.toString config.services.pocket-id.settings.HOST}:${builtins.toString config.services.pocket-id.settings.PORT}
            '';
          };
        };
      };
    };
  };
}
