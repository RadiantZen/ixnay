{ config, lib, ... }:

let
  db = "immich";
in
{
  options = {
    ixnay.services.web.immich.enable = lib.mkEnableOption "immich";
  };

  config = lib.mkIf config.ixnay.services.web.immich.enable {
    services = {
      immich = {
        enable = true;
        host = "127.0.0.1";
        port = 3001; # 3003 is used by machine learninig
        user = db;
        group = db;
        database = {
          name = db;
          user = db;
          createDB = true; # Handles Postgres Setup
        };
        openFirewall = false;
        mediaLocation = "/var/lib/immich";
      };

      # caddy = {
      #   virtualHosts = {
      #     "immich.ecmatthee.com" = {
      #       extraConfig = ''
      #         reverse_proxy http://${builtins.toString config.services.immich.host}:${builtins.toString config.services.immich.port}
      #       '';
      #     };
      #   };
      # };

      postgresqlBackup = {
        databases = [ db ];
      };
    };
  };
}
