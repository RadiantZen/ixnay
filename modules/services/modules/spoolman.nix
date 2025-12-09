{ config, lib, ... }:

let
  db = "spoolman";
in
{
  options = {
    ixnay.services.spoolman.enable = lib.mkEnableOption "spoolman";
  };

  config = lib.mkIf config.ixnay.services.spoolman.enable {
    services = {
      spoolman = {
        enable = true;
        environment = {
          SPOOLMAN_DB_TYPE = "postgres";
          SPOOLMAN_DB_HOST = "/run/postgresql";
          SPOOLMAN_DB_PORT = builtins.toString config.services.postgresql.settings.port;
          SPOOLMAN_DB_NAME = db;
          SPOOLMAN_DB_USERNAME = db;
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

      # caddy = {
      #   virtualHosts = {
      #     "spoolman.radiantzen.net" = {
      #       extraConfig = ''
      #         reverse_proxy http://${builtins.toString config.services.spoolman.listen}:${builtins.toString config.services.spoolman.port}
      #       '';
      #     };
      #   };
      # };
    };
  };
}
