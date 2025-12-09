{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.media.imv.enable = lib.mkEnableOption "imv";
  };

  config = lib.mkIf config.ixnay.programs.media.imv.enable {
    environment = {
      systemPackages = with pkgs; [ imv ];
    };
  };
  # TODO Wrap
  # imv = {
  #   enable = true;
  #   settings = {
  #     options.background = "ffffff";
  #     aliases.x = "close";
  #   };
  # };
}
