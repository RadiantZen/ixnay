{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.mprocs.enable = lib.mkEnableOption "mprocs";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.mprocs.enable {
    environment = {
      systemPackages = with pkgs; [ mprocs ];
    };
  };
}
