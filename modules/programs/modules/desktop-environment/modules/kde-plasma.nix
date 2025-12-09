{ config, lib, ... }:
{
  options = {
    ixnay.programs.desktop-environment.kde-plasma.enable = lib.mkEnableOption "KDE Plasma";
  };

  config = lib.mkIf config.ixnay.programs.desktop-environment.kde-plasma.enable {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma6 = {
        enable = true;
      };
    };
  };
}
