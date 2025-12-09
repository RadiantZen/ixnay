{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.keepassxc.enable = lib.mkEnableOption "keepassxc";
  };

  config = lib.mkIf config.ixnay.programs.keepassxc.enable {
    environment = {
      systemPackages = with pkgs; [
        keepassxc
        libsecret
      ];
    };
  };
}
