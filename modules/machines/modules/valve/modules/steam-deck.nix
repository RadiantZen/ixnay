{ config, lib, ... }:

{
  options = {
    ixnay.machines.valve.steam-deck.enable = lib.mkEnableOption "Steam deck config";
  };

  config = lib.mkIf config.ixnay.machines.valve.steam-deck.enable {
    ixnay = {
      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        cpu-amd.enable = true;
        drive.enable = true;
        fwupd.enable = true;
        gpu-amd.enable = true;
        gpu-universal.enable = true;
        zram.enable = true;
      };
    };
  };
}
