{ config, lib, ... }:

{
  options = {
    ixnay.services.network.ntp.enable = lib.mkEnableOption "ntp";
  };

  config = lib.mkIf config.ixnay.services.network.ntp.enable {
    # networking = {
    #   timeServers = config.networking.timeServers ++ [];
    # };

    services = {
      chrony = {
        enable = true;
        # enableNTS = true;
      };

      timesyncd.enable = false;
    };
  };
}
