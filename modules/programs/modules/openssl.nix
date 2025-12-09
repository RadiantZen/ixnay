{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.openssl.enable = lib.mkEnableOption "openssl";
  };

  config = lib.mkIf config.ixnay.programs.openssl.enable {
    environment = {
      systemPackages = with pkgs; [ openssl ];
    };
  };
}
