{ config, lib, ... }:

{
  options = {
    ixnay.services.web.radicale.enable = lib.mkEnableOption "radicale";
  };

  config = lib.mkIf config.ixnay.services.web.radicale.enable {
    sops = {
      secrets = {
        "systemService/radicale/username" = { };
        "systemService/radicale/password" = { };
      };

      templates = {
        "radicale.htpasswd" = {
          owner = "radicale";
          content = ''
            ${config.sops.placeholder."systemService/radicale/username"}:${
              config.sops.placeholder."systemService/radicale/password"
            }
          '';
        };
      };
    };

    services = {
      radicale = {
        enable = true;
        settings = {
          server = {
            hosts = [ "127.0.0.1:5232" ];
          };
          auth = {
            type = "htpasswd";
            htpasswd_filename = "${config.sops.templates."radicale.htpasswd".path}";
            htpasswd_encryption = "bcrypt";
          };
          storage = {
            filesystem_folder = "/var/lib/radicale/collections";
          };
        };
      };

      # caddy = {
      #   virtualHosts = {
      #     "radicale.ecmatthee.com" = {
      #       extraConfig = ''
      #         reverse_proxy http://${builtins.toString (builtins.elemAt config.services.radicale.settings.server.hosts 0)}
      #       '';
      #     };
      #   };
      # };
    };
  };
}
