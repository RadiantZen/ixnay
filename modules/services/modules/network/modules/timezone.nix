{ config, lib, ... }:

{
  options = {
    ixnay.services.network.timezone.enable = lib.mkEnableOption "timezone management";
  };

  config = lib.mkIf config.ixnay.services.network.timezone.enable {
    services = {
      automatic-timezoned = {
        enable = true;
      };
    };
  };
}
