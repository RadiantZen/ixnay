{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gaming.itch.enable = lib.mkEnableOption "itch";
  };

  config = lib.mkIf config.ixnay.programs.gaming.itch.enable {
    environment = {
      systemPackages = with pkgs; [ itch ];
    };
  };
}
