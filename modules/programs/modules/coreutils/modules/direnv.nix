{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.direnv.enable = lib.mkEnableOption "direnv";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.direnv.enable {
    programs = {
      direnv = {
        enable = true;
        enableFishIntegration = true;
        nix-direnv = {
          enable = true;
        };
      };
    };
  };
}
