{ config, lib, ... }:

{
  options = {
    ixnay.hardware.cpu-intel.enable = lib.mkEnableOption "cpu-intel";
  };

  config = lib.mkIf config.ixnay.hardware.cpu-intel.enable {
    hardware.cpu.intel.updateMicrocode = true;
  };
}
