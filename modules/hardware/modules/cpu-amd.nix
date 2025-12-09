{ config, lib, ... }:

{
  options = {
    ixnay.hardware.cpu-amd.enable = lib.mkEnableOption "cpu-amd";
  };

  config = lib.mkIf config.ixnay.hardware.cpu-amd.enable { hardware.cpu.amd.updateMicrocode = true; };
}
