{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.imagemagick.enable = lib.mkEnableOption "imagemagick";
  };

  config = lib.mkIf config.ixnay.programs.create.imagemagick.enable {
    environment = {
      systemPackages = with pkgs; [ imagemagick ];
    };
  };
}
