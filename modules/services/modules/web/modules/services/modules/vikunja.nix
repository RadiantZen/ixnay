{ config, lib, ... }:

let
  db = "vikunja";
in
{
  options = {
    ixnay.services.web.vikunja.enable = lib.mkEnableOption "vikunja";
  };

  config = lib.mkIf config.ixnay.services.web.vikunja.enable {
    services = {
      vikunja = {
        enable = true;
        port = 3456;
        database = {
          user = db;
          database = db;
          host = "/run/postgresql";
          type = "postgres";
        };
        frontendScheme = "https";
        # frontendHostname = "vikunja.ecmatthee.com";
        frontendHostname = "todo.arnivo.com";
        settings = {
          publicurl = "${config.services.vikunja.frontendScheme}://${config.services.vikunja.frontendHostname}/";
          enableregistration = false;
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

      caddy = {
        virtualHosts = {
          "vikunja.radiantzen.net" = {
            extraConfig = ''
              reverse_proxy http://127.0.0.1:${builtins.toString config.services.vikunja.port}
            '';
          };

          "todo.arnivo.com" = {
            extraConfig = ''
              reverse_proxy http://127.0.0.1:${builtins.toString config.services.vikunja.port}
            '';
          };
        };
      };
    };
  };
}
