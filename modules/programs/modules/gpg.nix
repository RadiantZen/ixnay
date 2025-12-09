{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gpg.enable = lib.mkEnableOption "gpg support";
  };

  config = lib.mkIf config.ixnay.programs.gpg.enable {
    programs = {
      gnupg = {
        agent = {
          enable = true;
          pinentryPackage = pkgs.pinentry-qt;
        };
      };
    };
  };
}
