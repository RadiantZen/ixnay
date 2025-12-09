{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.emulation.psp.enable = lib.mkEnableOption "PSP emulation";
  };

  config = lib.mkIf config.ixnay.programs.emulation.psp.enable {
    environment = {
      systemPackages = with pkgs; [ ppsspp-sdl ];
    };
  };
}
