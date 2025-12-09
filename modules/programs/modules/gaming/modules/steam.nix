{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gaming.steam.enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf config.ixnay.programs.gaming.steam.enable {
    programs = {
      steam = {
        enable = true;
        protontricks = {
          enable = true;
        };
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession = {
          enable = true;
          # env = {};
          # args = [];
        };
        package = pkgs.steam.override {
          extraPkgs =
            pkgs: with pkgs; [
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              libkrb5
              keyutils
            ];
        };
      };
    };

    hardware = {
      steam-hardware.enable = true;
    };
  };
}
