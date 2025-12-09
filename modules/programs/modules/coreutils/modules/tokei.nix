{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.tokei.enable = lib.mkEnableOption "tokei";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.tokei.enable {
    environment = {
      systemPackages = with pkgs; [ tokei ];
    };
  };
}
