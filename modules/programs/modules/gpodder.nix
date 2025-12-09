{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gpodder.enable = lib.mkEnableOption "gpodder";
  };

  config = lib.mkIf config.ixnay.programs.gpodder.enable {
    environment = {
      systemPackages = with pkgs; [ gpodder ];
    };
  };
}
