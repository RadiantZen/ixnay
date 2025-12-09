{ config, lib, ... }:

{
  options = {
    ixnay.services.acme = {
      enable = lib.mkEnableOption "acme";
    };
  };

  config = lib.mkIf config.ixnay.services.acme.enable {
    sops = {
      secrets = {
        "systemService/acme/cloudflareEmail" = { };
        "systemService/acme/cloudflareToken" = { };
      };
    };

    security = {
      acme = {
        acceptTerms = true;
        defaults = {
          email = "web@ecmatthee.com";
          # email = "web@radiantzen.net";
          webroot = "/var/lib/acme/acme-challenge/";
          # credentialFiles = {
          #   "CF_API_EMAIL_FILE" = config.sops.secrets."systemService/acme/cloudflareEmail".path;
          #   "CF_API_KEY_FILE" = config.sops.secrets."systemService/acme/cloudflareToken".path;
          # };
          # dnsProvider = "cloudflare";
          # dnsResolver = "1.1.1.1:53";
        };
        # certs = {
        #   "vikunja.radiantzen.net" = {
        #     # extraDomainNames = [ "subdomain.example.org" ];
        #     # The LEGO DNS provider name. Depending on the provider, need different
        #     # contents in the credentialsFile below.
        #     # agenix will decrypt our secrets file (below) on the server and make it available
        #     # under /run/agenix/secrets/hetzner-dns-token (by default):
        #     # credentialsFile = "/run/agenix/secrets/hetzner-dns-token";
        #   };
        # };
      };
    };
  };
}
