{ config, lib, ... }:

{
  options = {
    ixnay.hardware.rgb.enable = lib.mkEnableOption "rgb";
  };

  config = lib.mkIf config.ixnay.hardware.rgb.enable {
    services.hardware = {
      openrgb = {
        enable = true;
      };
    };
  };
}
