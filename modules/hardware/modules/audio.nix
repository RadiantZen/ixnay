{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.hardware.audio.enable = lib.mkEnableOption "audio backend";
  };

  config = lib.mkIf config.ixnay.hardware.audio.enable {
    environment = {
      systemPackages = with pkgs; [
        libinput
        pulsemixer
      ];
    };

    # sound.enable = false;

    services = {
      pipewire = {
        enable = true;
        wireplumber = {
          enable = true;
        };
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse = {
          enable = true;
        };
        jack = {
          enable = true;
        };
      };
    };
  };
}
