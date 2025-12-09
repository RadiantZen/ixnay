{ config, lib, ... }:

let
  db = "vaultwarden";
in
{
  options = {
    ixnay.services.web.vaultwarden.enable = lib.mkEnableOption "vaultwarden";
  };

  config = lib.mkIf config.ixnay.services.web.vaultwarden.enable {
    sops = {
      secrets = {
        "systemService/vaultwarden/adminPassword" = { };
        "systemService/vaultwarden/smtpPassword" = { };
      };

      templates = {
        "vaultwarden.env" = {
          owner = "vaultwarden";
          content = ''
            ADMIN_TOKEN=${config.sops.placeholder."systemService/vaultwarden/adminPassword"}
            SMTP_PASSWORD=${config.sops.placeholder."systemService/vaultwarden/smtpPassword"}
          '';
        };
      };
    };

    services = {
      vaultwarden = {
        enable = true;
        dbBackend = "postgresql";
        config = {
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
          DATABASE_URL = "postgresql://${db}@/${db}";
          DOMAIN = "https://vaultwarden.ecmatthee.com";
          SMTP_HOST = "smtp.gmail.com";
          SMTP_PORT = 465;
          SMTP_SECURITY = "force_tls";
          SMTP_USERNAME = "herald.srv@gmail.com";
          SMTP_FROM = "herald.srv@gmail.com";
          SMTP_FROM_NAME = "Vaultwarden";
          SIGNUPS_ALLOWED = false;
        };
        environmentFile = config.sops.templates."vaultwarden.env".path;
      };

      caddy = {
        virtualHosts = {
          "vaultwarden.radiantzen.net" = {
            extraConfig = ''
              reverse_proxy http://${builtins.toString config.services.vaultwarden.config.ROCKET_ADDRESS}:${builtins.toString config.services.vaultwarden.config.ROCKET_PORT}
            '';
          };

          "pass.arnivo.com" = {
            extraConfig = ''
              reverse_proxy http://${builtins.toString config.services.vaultwarden.config.ROCKET_ADDRESS}:${builtins.toString config.services.vaultwarden.config.ROCKET_PORT}
            '';
          };
        };
      };

      postgresql = {
        ensureDatabases = [ db ];
        ensureUsers = [
          {
            name = db;
            ensureDBOwnership = true;
          }
        ];
      };

      postgresqlBackup = {
        databases = [ db ];
      };
    };
  };
}
