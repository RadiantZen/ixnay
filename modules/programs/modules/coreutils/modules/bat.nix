{ config, lib, ... }:

{
  options = {
    ixnay.programs.coreutils.bat.enable = lib.mkEnableOption "bat";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.bat.enable {
    programs = {
      bat = {
        enable = true;
      };
    };
  };
}
