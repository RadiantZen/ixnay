{ config, lib, ... }:

{
  options = {
    ixnay.services.caddy = {
      enable = lib.mkEnableOption "caddy";
      reverseProxySSO = lib.mkOption { type = with lib.types; functionTo str; };
    };
  };

  config = lib.mkIf config.ixnay.services.caddy.enable {
    networking = {
      firewall = {
        allowedTCPPorts = [
          80
          443
        ];
      };
    };

    # TODO universal interface to remove state from modules
    # ex. MODULE [ services.paperless {}; ixnay.paperless.serverconfig = <caddy config> ] MODULE [ ixnay.webservice.<domain> = { <service> = config.ixnay.<service>.serverconfig } > caddy.virtualHosts ]
    services = {
      caddy = {
        enable = true;
        email = "ebert@ecmatthee.com";
        virtualHosts = {
          "ecmatthee.com" = {
            extraConfig = ''
              respond "Hello, world!"
            '';
            serverAliases = [ "www.ecmatthee.com" ];
          };
        };
      };
      cloudflare-dyndns = {
        enable = true;
        apiTokenFile = "/persist/cloud.key";
        domains = [
          "miniflux.radiantzen.net"
          "vaultwarden.radiantzen.net"
          "vikunja.radiantzen.net"
        ];
      };
    };
  };
}
