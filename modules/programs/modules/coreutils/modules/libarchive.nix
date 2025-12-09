{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.libarchive.enable = lib.mkEnableOption "Libarchive";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.libarchive.enable {
    environment = {
      systemPackages = with pkgs; [ libarchive ];
    };
  };
}
