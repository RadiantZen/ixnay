{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.zps.enable = lib.mkEnableOption "zps";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.zps.enable {
    environment = {
      systemPackages = with pkgs; [ zps ];
    };
  };
}
