{ config, lib, ... }:

{
  options = {
    ixnay.services.web.ollama.enable = lib.mkEnableOption "ollama";
  };

  config = lib.mkIf config.ixnay.services.web.ollama.enable {
    services = {
      ollama = {
        enable = true;
        rocmOverrideGfx = "10.3.0";
      };

      # caddy = {
      #   virtualHosts = {
      #     "jelly.ecmatthee.com" = {
      #       extraConfig = ''
      #         reverse_proxy http://127.0.0.1:8096
      #       '';
      #     };
      #   };
      # };
    };
  };
}
