{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.inkscape.enable = lib.mkEnableOption "inkscape";
  };

  config = lib.mkIf config.ixnay.programs.create.inkscape.enable {
    environment = {
      systemPackages = with pkgs; [ inkscape-with-extensions ];
    };
  };
}
