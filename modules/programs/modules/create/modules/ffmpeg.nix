{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.create.ffmpeg.enable = lib.mkEnableOption "ffmpeg";
  };

  config = lib.mkIf config.ixnay.programs.create.ffmpeg.enable {
    environment = {
      systemPackages = with pkgs; [
        ffmpeg-full
        #flac
        #subtitlecomposer
        #subtitleedit
        #mediainfo
        #mkvtoolnix
        #vapoursynth
        #vapoursynth-bestsource
      ];
    };
  };
}
