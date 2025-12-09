{ config, lib, ... }:

{
  options = {
    ixnay.hardware.fwupd.enable = lib.mkEnableOption "fwupd";
  };

  config = lib.mkIf config.ixnay.hardware.fwupd.enable {
    services = {
      fwupd = {
        enable = true;
      };
    };
  };
}
