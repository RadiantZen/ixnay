{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.emulation.mame.enable = lib.mkEnableOption "MAME emulation";
  };

  config = lib.mkIf config.ixnay.programs.emulation.mame.enable {
    environment = {
      systemPackages = with pkgs; [ mame ];
    };
  };
}
