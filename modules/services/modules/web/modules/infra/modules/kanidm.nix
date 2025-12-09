{
  config,
  lib,
  pkgs,
  ...
}:

let
  domain = "idm.radiantzen.net";
  certPath = "/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory";
  key = "tls.certificates/${domain}/key.pem";
  chain = "tls.certificates/${domain}/chain.pem";
in
{
  options = {
    ixnay.services.kanidm.enable = lib.mkEnableOption "Kanidm";
  };

  config = lib.mkIf config.ixnay.services.kanidm.enable {
    # sops = {
    #   secrets = {
    #     "systemService/kanidm/MAXMIND_LICENSE_KEY" = { };
    #     "systemService/kanidm/ENCRYPTION_KEY" = { };
    #   };
    #
    #   templates = {
    #     "kanidm.env" = {
    #       owner = config.services.kanidm.user;
    #       content = ''
    #         MAXMIND_LICENSE_KEY=${config.sops.placeholder."systemService/kanidm/MAXMIND_LICENSE_KEY"}
    #         ENCRYPTION_KEY=${config.sops.placeholder."systemService/kanidm/ENCRYPTION_KEY"}
    #       '';
    #     };
    #   };
    # };

    environment.etc = {
      "${chain}" = {
        enable = true;
        source = "${certPath}/${domain}/${domain}.crt";
        mode = "0600";
        user = "kanidm";
      };

      "${key}" = {
        enable = true;
        source = "${certPath}/${domain}/${domain}.key";
        mode = "0600";
        user = "kanidm";
      };
    };

    services = {
      kanidm = {
        enableClient = false;
        enablePam = false;
        enableServer = true;
        package = lib.mkForce pkgs.kanidm_1_8;
        provision = {
          enable = false;
          adminPasswordFile = /hu;
          idmAdminPasswordFile = /hu;
          groups = { };
          persons = {
            zen = {
              displayName = "RadiantZen";
              groups = [ ];
              legalName = "Ebert Matthee";
              mailAddresses = [ "zen@radiantzen.net" ];
            };
          };

          systems.oauth2 = { };
        };

        serverSettings = {
          bindaddress = "127.0.0.1:8443";
          domain = domain;
          origin = "https://${domain}";
          # ldapbindaddress = "[::1]:636";
          tls_chain = "/etc/${chain}";
          tls_key = "/etc/${key}";
          online_backup = {
            path = "/var/backup/kanidm";
            versions = 7;
          };
        };
      };

      caddy = {
        virtualHosts = {
          "${domain}" = {
            extraConfig = ''
              reverse_proxy https://${config.services.kanidm.serverSettings.bindaddress} {
                transport http {
                        tls
                        tls_server_name ${domain}
                }
              }
            '';
          };
        };
      };
    };
  };
}
