{ config, lib, ... }:

{
  options = {
    ixnay.services.web.stirling-pdf.enable = lib.mkEnableOption "stirling-pdf";
  };

  config = lib.mkIf config.ixnay.services.web.stirling-pdf.enable {
    services = {
      stirling-pdf = {
        enable = false;
        environment = {
          SERVER_PORT = 17834;
          SERVER_ADDRESS = "127.0.0.1";
        };
      };

      # caddy = {
      #   virtualHosts = {
      #     "pdf.ecmatthee.com" = {
      #       extraConfig = ''
      #         reverse_proxy http://${builtins.toString config.services.stirling-pdf.environment.SERVER_ADDRESS}:${builtins.toString config.services.stirling-pdf.environment.SERVER_PORT}
      #       '';
      #     };
      #   };
      # };
    };
  };
}
