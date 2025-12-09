{ config, lib, ... }:

let
  port = 8096;
in
{
  options = {
    ixnay.services.web.jellyfin.enable = lib.mkEnableOption "jellyfin";
  };

  config = lib.mkIf config.ixnay.services.web.jellyfin.enable {
    services = {
      jellyfin = {
        enable = true;
        openFirewall = true;
      };

      # caddy = {
      #   virtualHosts = {
      #     "jelly.radiantzen.net" = {
      #       # extraConfig = config.ixnay.services.caddy.reverseProxySSO "http://127.0.0.1:${builtins.toString port}";
      #       extraConfig = ''
      #         reverse_proxy http://127.0.0.1:8096
      #       '';
      #     };
      #   };
      # };
    };
  };
}
