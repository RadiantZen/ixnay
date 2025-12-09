{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.signal.enable = lib.mkEnableOption "signal";
  };

  config = lib.mkIf config.ixnay.programs.signal.enable {
    environment = {
      systemPackages = with pkgs; [ signal-desktop ];
    };
  };
}
