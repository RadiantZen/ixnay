{ config, lib, ... }:

{
  options = {
    ixnay.programs.coreutils.yazi.enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.yazi.enable {
    programs = {
      yazi = {
        enable = true;
        # TODO Config
      };
    };
  };
}
