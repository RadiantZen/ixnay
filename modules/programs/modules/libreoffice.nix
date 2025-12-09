{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.libreoffice.enable = lib.mkEnableOption "libreoffice";
  };

  config = lib.mkIf config.ixnay.programs.libreoffice.enable {
    environment = {
      systemPackages = with pkgs; [
        libreoffice-qt6-fresh
        hunspell
        hunspellDicts.en-us
      ];
    };
  };
}
