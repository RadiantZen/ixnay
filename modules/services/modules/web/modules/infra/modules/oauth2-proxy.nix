{ config, lib, ... }:

{
  options = {
    ixnay.services.oauth2-proxy = {
      enable = lib.mkEnableOption "oauth2-proxy";
      user = lib.mkOption { type = lib.types.str; };
      port = lib.mkOption { type = lib.types.int; };
    };
  };

  config = lib.mkIf config.ixnay.services.oauth2-proxy.enable {
    sops = {
      secrets = {
        "systemService/oauth2-proxy/client-id" = { };
        "systemService/oauth2-proxy/client-secret" = { };
        "systemService/oauth2-proxy/cookie-secret" = { };
      };

      templates = {
        "oauth2-proxy.env" = {
          owner = config.ixnay.services.oauth2-proxy.user;
          content = ''
            OAUTH2_PROXY_CLIENT_ID=${config.sops.placeholder."systemService/oauth2-proxy/client-id"}
            OAUTH2_PROXY_CLIENT_SECRET=${config.sops.placeholder."systemService/oauth2-proxy/client-secret"}
            OAUTH2_PROXY_COOKIE_SECRET=${config.sops.placeholder."systemService/oauth2-proxy/cookie-secret"}
          '';
        };
      };
    };

    ixnay.services = {
      caddy = {
        reverseProxySSO = proxyBind: ''
          handle /oauth2/* {
             reverse_proxy 127.0.0.1:${builtins.toString config.ixnay.services.oauth2-proxy.port} {
               header_up X-Real-IP {remote_host}
               header_up X-Forwarded-Uri {uri}
             }
          }

          handle {
            forward_auth 127.0.0.1:${builtins.toString config.ixnay.services.oauth2-proxy.port} {
              uri /oauth2/auth
              header_up X-Real-IP {remote_host}
              @error status 401
              handle_response @error {
                  redir * /oauth2/sign_in?rd={scheme}://{host}{uri}
              }
            }

            reverse_proxy ${proxyBind}
          }
        '';
      };

      oauth2-proxy = {
        # TODO PR add port settings to oauth2-proxy upstream nixpkgs
        port = 4180;
        # TODO PR add user & group settings to oauth2-proxy upstream nixpkgs
        user = "oauth2-proxy";
      };
    };

    services = {
      oauth2-proxy = {
        enable = true;
        keyFile = config.sops.templates."oauth2-proxy.env".path;
        cookie = {
          domain = ".radiantzen.net";
        };
        email = {
          domains = [ "*" ];
        };
        oidcIssuerUrl = "https://oidc.radiantzen.net";
        provider = "oidc";
        reverseProxy = true;
        scope = "openid email profile groups";
      };
    };
  };
}
