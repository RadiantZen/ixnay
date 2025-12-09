{ config, lib, ... }:

{
  options = {
    ixnay.services.network.dns.enable = lib.mkEnableOption "network configuration";
  };

  config = lib.mkIf config.ixnay.services.network.dns.enable {
    networking = {
      useDHCP = false;
      dhcpcd = {
        enable = false;
      };
      nameservers = [
        "9.9.9.9"
        "2620:fe::fe"
        "1.1.1.1"
        "2606:4700:4700::1111"
      ];
    };

    services = {
      resolved = {
        enable = true;
        domains = [ "~." ];
        dnsovertls = "true";
        # extraConfig = ''
        #   MulticastDNS=false
        # '';
      };
    };
  };
}
