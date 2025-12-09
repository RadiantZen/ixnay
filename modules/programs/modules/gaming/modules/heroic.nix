{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gaming.heroic.enable = lib.mkEnableOption "heroic";
  };

  config = lib.mkIf config.ixnay.programs.gaming.heroic.enable {
    environment = {
      systemPackages = with pkgs; [ heroic ];
    };
  };
}
