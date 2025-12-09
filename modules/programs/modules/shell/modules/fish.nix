{ config, lib, ... }:

{
  options = {
    ixnay.programs.shell.fish.enable = lib.mkEnableOption "Fish shell";
  };

  config = lib.mkIf config.ixnay.programs.shell.fish.enable {
    programs = {
      fish = {
        enable = true;
        useBabelfish = true;
      };
    };
  };
}
