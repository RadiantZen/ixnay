{ config, lib, ... }:

{
  options = {
    ixnay.machines.hp.z440.enable = lib.mkEnableOption "HP z440 (modified)";
  };

  config = lib.mkIf config.ixnay.machines.hp.z440.enable {
    ixnay = {
      hardware = {
        audio.enable = true;
        cpu-intel.enable = true;
        drive.enable = true;
        fwupd.enable = true;
        gpu-amd.enable = true;
        gpu-universal.enable = true;
        zram.enable = true;
      };
    };
  };
}
