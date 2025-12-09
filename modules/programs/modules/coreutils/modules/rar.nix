{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.rar.enable = lib.mkEnableOption "Full RAR format support";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.rar.enable {
    environment = {
      systemPackages = with pkgs; [ rar ];
    };
  };
}
