{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.freecad.enable = lib.mkEnableOption "freecad";
  };

  config = lib.mkIf config.ixnay.programs.create.freecad.enable {
    environment = {
      systemPackages = with pkgs; [ freecad ];
    };
  };
}
