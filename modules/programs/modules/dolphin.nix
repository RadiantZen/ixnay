{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.dolphin.enable = lib.mkEnableOption "dolphin";
  };

  config = lib.mkIf config.ixnay.programs.dolphin.enable {
    environment = {
      systemPackages = with pkgs; [ kdePackages.dolphin ];
    };
  };
}
