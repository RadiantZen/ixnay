{ config, lib, ... }:

{
  options = {
    ixnay.hardware.wireless.enable = lib.mkEnableOption "wireless";
  };

  config = lib.mkIf config.ixnay.hardware.wireless.enable {
    networking = {
      wireless = {
        iwd = {
          enable = true;
          settings = {
            Network = {
              EnableIPv6 = true;
              RoutePriorityOffset = 300;
            };
            Settings = {
              AutoConnect = true;
            };
          };
        };
      };
    };
  };
}
