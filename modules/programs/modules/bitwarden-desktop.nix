{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.bitwarden-desktop.enable = lib.mkEnableOption "bitwarden-desktop";
  };

  config = lib.mkIf config.ixnay.programs.bitwarden-desktop.enable {
    environment = {
      systemPackages = with pkgs; [ bitwarden-desktop ];
    };
  };
}
