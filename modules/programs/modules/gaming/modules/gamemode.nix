{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.gaming.gamemode.enable = lib.mkEnableOption "gamemode";
  };

  config = lib.mkIf config.ixnay.programs.gaming.gamemode.enable {
    programs = {
      gamemode = {
        enable = true;
        settings = {
          general = {
            renice = 0;
          };

          # Warning: GPU optimisations have the potential to damage hardware
          #gpu = {
          #  apply_gpu_optimisations = "accept-responsibility";
          #  gpu_device = 0;
          #  amd_performance_level = "high";
          #};

          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          };
        };
      };
    };
  };
}
