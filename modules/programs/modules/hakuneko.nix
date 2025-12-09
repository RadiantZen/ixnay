{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.hakuneko.enable = lib.mkEnableOption "hakuneko";
  };

  config = lib.mkIf config.ixnay.programs.hakuneko.enable {
    environment = {
      systemPackages = with pkgs; [ hakuneko ];
    };
  };
}
