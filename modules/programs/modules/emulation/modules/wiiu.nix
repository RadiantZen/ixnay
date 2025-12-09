{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.emulation.wiiu.enable = lib.mkEnableOption "WiiU emulation";
  };

  config = lib.mkIf config.ixnay.programs.emulation.wiiu.enable {
    environment = {
      systemPackages = with pkgs; [ cemu ];
    };
  };
}
