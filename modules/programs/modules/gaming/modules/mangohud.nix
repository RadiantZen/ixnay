{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gaming.mangohud.enable = lib.mkEnableOption "mangohud";
  };

  config = lib.mkIf config.ixnay.programs.gaming.mangohud.enable {
    environment = {
      systemPackages = with pkgs; [ mangohud ];
    };
  };
  # TODO Wrap
  #mangohud = {
  #  enable = true;
  #  enableSessionWide = false;
  #  settings = {
  #    preset = 2;
  #    af = 16;
  #    gamemode = true;
  #    vkbasalt = true;
  #  };
  #};
}
