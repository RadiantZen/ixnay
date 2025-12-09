{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.emulation.switch.enable = lib.mkEnableOption "Switch emulation";
  };

  config = lib.mkIf config.ixnay.programs.emulation.switch.enable {
    environment = {
      systemPackages = with pkgs; [ ryubing ];
    };
  };
}
