{ config, lib, ... }:

{
  options = {
    ixnay.services.network.dhcp.enable = lib.mkEnableOption "network configuration";
  };

  config = lib.mkIf config.ixnay.services.network.dhcp.enable {
    systemd = {
      network = {
        enable = true;
        networks = {
          "40-wired-dhcp" = {
            matchConfig = {
              Type = "ether";
            };
            networkConfig = {
              DHCP = "yes";
            };
            dhcpV4Config = {
              UseDNS = false;
              RouteMetric = 10;
            };
            dhcpV6Config = {
              UseDNS = false;
              RouteMetric = 10;
            };
          };

          "45-wireless-dhcp" = {
            matchConfig = {
              Type = "wlan";
            };
            networkConfig = {
              DHCP = "yes";
              IgnoreCarrierLoss = "3s";
            };
            dhcpV4Config = {
              UseDNS = false;
              RouteMetric = 20;
            };
            dhcpV6Config = {
              UseDNS = false;
              RouteMetric = 20;
            };
          };
        };
      };
    };
  };
}
