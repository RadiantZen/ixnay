{ config, lib, ... }:

{
  options = {
    ixnay.services.printer.avahi.enable = lib.mkEnableOption "avahi";
  };

  config = lib.mkIf config.ixnay.services.printer.avahi.enable {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
