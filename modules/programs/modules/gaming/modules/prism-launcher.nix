{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gaming.prism-launcher.enable = lib.mkEnableOption "Prism launcher";
  };

  config = lib.mkIf config.ixnay.programs.gaming.prism-launcher.enable {
    environment = {
      systemPackages = with pkgs; [ prismlauncher ];
    };
  };
}
