{ config, lib, ... }:

{
  options = {
    ixnay.programs.coreutils.less.enable = lib.mkEnableOption "less";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.less.enable {
    programs = {
      less = {
        enable = true;
      };
    };
  };
}
