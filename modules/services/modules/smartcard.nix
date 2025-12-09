{ config, lib, ... }:

{
  options = {
    ixnay.services.smartcard.enable = lib.mkEnableOption "Smartcard support";
  };

  config = lib.mkIf config.ixnay.services.smartcard.enable {
    hardware = {
      gpgSmartcards.enable = true;
    };

    security = {
      pam = {
        u2f = {
          enable = true;
          settings = {
            cue = true;
          };
        };
      };
    };

    services = {
      pcscd.enable = true;
    };
  };
}
