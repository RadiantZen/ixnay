{ config, lib, ... }:

{
  options = {
    ixnay.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf config.ixnay.hardware.bluetooth.enable {
    hardware = {
      bluetooth = {
        enable = true;
      };
    };
  };
}
