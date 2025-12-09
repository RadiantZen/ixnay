{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.yubikey.enable = lib.mkEnableOption "Yubikey";
  };

  config = lib.mkIf config.ixnay.programs.yubikey.enable {
    ixnay.services.smartcard.enable = lib.mkDefault true;

    programs = {
      yubikey-touch-detector = {
        enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs; [
        yubikey-manager
        yubioath-flutter
      ];
    };
  };
}
