{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.anki.enable = lib.mkEnableOption "anki";
  };

  config = lib.mkIf config.ixnay.programs.anki.enable {
    environment = {
      systemPackages = with pkgs; [ anki-bin ];
    };
  };
}
