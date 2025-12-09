{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.minisign.enable = lib.mkEnableOption "minisign";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.minisign.enable {
    environment = {
      systemPackages = with pkgs; [ minisign ];
    };
  };
}
