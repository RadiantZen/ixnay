{ config, lib, ... }:

{
  options = {
    ixnay.services.network.base.enable = lib.mkEnableOption "network configuration";
  };

  config = lib.mkIf config.ixnay.services.network.base.enable {
    networking = {
      useNetworkd = true;
    };
  };
}
