{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.emulation.wii.enable = lib.mkEnableOption "Wii emulation";
  };

  config = lib.mkIf config.ixnay.programs.emulation.wii.enable {
    environment = {
      systemPackages = with pkgs; [ dolphin-emu ];
    };
  };
}
