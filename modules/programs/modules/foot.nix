{ config, lib, ... }:
{
  options = {
    ixnay.programs.foot.enable = lib.mkEnableOption "foot";
  };

  config = lib.mkIf config.ixnay.programs.foot.enable {
    programs = {
      foot = {
        enable = true;
        settings = { };
      };
    };
  };
}
