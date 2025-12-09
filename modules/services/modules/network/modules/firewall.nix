{ config, lib, ... }:

{
  options = {
    ixnay.services.network.firewall.enable = lib.mkEnableOption "network configuration";
  };

  config = lib.mkIf config.ixnay.services.network.firewall.enable {
    networking = {
      firewall = {
        enable = true;
      };
    };
  };
}
