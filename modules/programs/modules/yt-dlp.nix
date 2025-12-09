{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.yt-dlp.enable = lib.mkEnableOption "yt-dlp";
  };

  config = lib.mkIf config.ixnay.programs.yt-dlp.enable {
    environment = {
      systemPackages = with pkgs; [ yt-dlp ];
    };
  };
}
# TODO Wrap
# {
#   programs = {
#     yt-dlp = {
#       enable = true;
#       settings = {
#         cookies = "/home/ecm/download/yt-dlp/.auth/cookies.txt";
#         downloader = "aria2c";
#         convert-thumbnails = "png";
#         embed-metadata = true;
#         embed-thumbnail = true;
#         embed-subs = true;
#         format-sort = "lang,quality,res,fps,hdr,vcodec,channels,acodec,size,br,asr,proto,ext,hasaud,source,id";
#         merge-output-format = "mkv";
#         output = "\"%(webpage_url_domain)s/%(channel)s [%(channel_id)s]/%(title)s [%(id)s].%(ext)s\"";
#         paths = "/home/ecm/download/yt-dlp";
#         prefer-free-formats = true;
#         remux-video = "mkv";
#         sponsorblock-mark = "all";
#         sub-langs = "all,-live_chat";
#       };
#     };
#   };
# }
