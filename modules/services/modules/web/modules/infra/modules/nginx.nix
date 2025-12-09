{ config, lib, ... }:

{
  options = {
    ixnay.services.nginx = {
      enable = lib.mkEnableOption "nginx";
    };
  };

  config = lib.mkIf config.ixnay.services.nginx.enable {
    networking = {
      firewall = {
        allowedTCPPorts = [
          80
          443
        ];
      };
    };

    users.users.nginx.extraGroups = [ "acme" ];

    services = {
      nginx = {
        enable = true;
        # enableQuicBPF = true;
        experimentalZstdSettings = true;
        statusPage = true;

        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        # virtualHosts."vikunja.radiantzen.net" = {
        #   useACMEHost = "vikunja.radiantzen.net";
        #   forceSSL = true;
        #   locations."/" = {
        #     proxyPass = "http://127.0.0.1:${builtins.toString config.services.vikunja.port}";
        #   };
        # };
      };
    };
  };
}
