{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.hardware.drive.enable = lib.mkEnableOption "drive";
  };

  config = lib.mkIf config.ixnay.hardware.drive.enable {
    environment = {
      systemPackages = with pkgs; [
        parted
        duf
        ncdu
        hdparm
        sdparm
        smartmontools
        nvme-cli
      ];
    };
    services = {
      smartd = {
        enable = true;
        autodetect = true;
        defaults.autodetected = "-a -o on -s (S/../.././00|L/../../7/00)";
        notifications.mail = {
          enable = false;
        };
      };
    };
  };
}
