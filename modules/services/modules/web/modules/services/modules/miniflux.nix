{ config, lib, ... }:

let
  db = "miniflux";
in
{
  options = {
    ixnay.services.web.miniflux.enable = lib.mkEnableOption "miniflux";
  };

  config = lib.mkIf config.ixnay.services.web.miniflux.enable {
    sops = {
      secrets = {
        "systemService/miniflux/adminPassword" = { };
      };

      templates = {
        "miniflux.env" = {
          # owner = "miniflux";
          content = ''
            ADMIN_USERNAME=admin
            ADMIN_PASSWORD=${config.sops.placeholder."systemService/miniflux/adminPassword"}
          '';
        };
      };
    };

    security = {
      acme = {
        certs = {
          "miniflux.radiantzen.net" = { };
        };
      };
    };

    services = {
      miniflux = {
        enable = true;
        createDatabaseLocally = true;
        adminCredentialsFile = "${config.sops.templates."miniflux.env".path}";
        config = {
          BASE_URL = "https://miniflux.radiantzen.net/";
          CREATE_ADMIN = 1;
          FETCH_YOUTUBE_WATCH_TIME = 1;
          LISTEN_ADDR = "127.0.0.1:20758";
          RUN_MIGRATIONS = 1;
          WEBAUTHN = 1;
        };
      };

      postgresqlBackup = {
        databases = [ db ];
      };

      nginx = {
        virtualHosts."miniflux.radiantzen.net" = {
          useACMEHost = "miniflux.radiantzen.net";
          locations."/" = {
            proxyPass = "http://${builtins.toString config.services.miniflux.config.LISTEN_ADDR}";
          };
        };
      };

      # caddy = {
      #   virtualHosts = {
      #     "miniflux.radiantzen.net" = {
      #       extraConfig = config.ixnay.services.caddy.reverseProxySSO "http://${builtins.toString config.services.miniflux.config.LISTEN_ADDR}";
      #     };
      #   };
      # };
    };
  };
}
