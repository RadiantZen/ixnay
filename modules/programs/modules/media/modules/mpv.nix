{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.media.mpv.enable = lib.mkEnableOption "mpv";
  };

  config = lib.mkIf config.ixnay.programs.media.mpv.enable {
    environment = {
      systemPackages = with pkgs; [ mpv ];
    };
  };
}
# TODO Wrap
# {
#   programs = {
#     # TODO Profile based on hardware (High, Med, Low)
#     # https://old.reddit.com/r/mpv/comments/fykeyo/is_there_a_way_to_swap_profiles_with_a_keybind/
#     # TODO gpu-api=vulkan launches XWayland
#     mpv = {
#       enable = true;
#       config = {
#         # General
#         cursor-autohide = 1000;
#         force-seekable = true;
#
#         ## Screenshot
#         screenshot-sw = false;
#         screenshot-high-bit-depth = true;
#         screenshot-format = "png";
#         screenshot-png-compression = 9;
#         screenshot-directory = "/home/ecm/pic";
#         screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";
#
#         # Video
#         vo = "gpu-next";
#         gpu-api = "vulkan";
#         gpu-context = "waylandvk";
#         #hwdec = "vaapi";
#         #hwdec = false;
#         ##profile = "high-quality";
#
#         ## Shader
#         glsl-shader = [
#           "~/.config/mpv/shaders/ArtCNN/ArtCNN_C4F32.glsl"
#           "~/.config/mpv/shaders/CFLP/CfL_Prediction.glsl"
#         ];
#
#         ## Debanding
#         deband = true;
#         deband-iterations = 4;
#         deband-threshold = 48;
#         deband-range = 24;
#         deband-grain = 24;
#
#         ## Dither
#         dither-depth = "auto";
#         #dither = "error-diffusion";
#         #error-diffusion = "sierra-lite";
#
#         ### Downscaling
#         dscale = "hermite";
#         hidpi-window-scale = false;
#
#         ### Interpolation
#         interpolation = true;
#         video-sync = "display-resample";
#         #tscale = "oversample";
#         tscale = "sphinx";
#         tscale-blur = 0.6991556596428412;
#         tscale-radius = 1.0; #lower (e.g. 0.955) = sharper; higher (e.g. 1.005) = smoother
#         tscale-clamp = 0.0;
#
#         ### Anti-Ringing
#         #scale-antiring = 0.5;
#         ##dscale-antiring = 0.5;
#         ##cscale-antiring = 0.5;
#         ##tscale-antiring = 0.0;
#
#         ### HDR
#         target-colorspace-hint = true;
#         tone-mapping = "mobius";
#
#         # Audio
#         ao = "pipewire";
#         audio-channels = "7.1,5.1,stereo";
#
#         ## Match
#         alang= "ja,jp,jpn,Japanese,en,eng,English";
#         audio-file-auto = "fuzzy";
#
#         ## Volume
#         volume = 100;
#         volume-max = 200;
#
#         # Subtitles
#         ## Match
#         slang = "en,eng,English,enUS";
#         sub-auto = "fuzzy";
#         sub-file-paths = "ass:srt:sub:Sub:subs:Subs:subtitles:Subtitles";
#         subs-with-matching-audio = true;
#
#         ## Fixing
#         blend-subtitles = true;
#         sub-fix-timing = true;
#         sub-ass-vsfilter-blur-compat = false;
#
#         ## Styling
#         ### SRT
#         sub-font = "Noto Sans Mono";
#         sub-bold = false;
#         sub-font-size = 52;
#         sub-blur = 0.1;
#         sub-color = "1.0/1.0/1.0/1.0";
#         sub-border-color = "0.0/0.0/0.0/1.0";
#         sub-border-size = 3.4;
#         sub-margin-x = 100;
#         sub-margin-y = 50;
#         sub-shadow-color = "0.0/0.0/0.0/0.4";
#         sub-shadow-offset = 0.5;
#
#         ### VOB/PGS
#         sub-gauss = 1.0;
#         sub-gray = true;
#       };
#       bindings = {
#         h = "cycle-values deband 'yes' 'no'";
#         n = "cycle-values audio-channels 'auto-safe' 'mono'";
#       };
#     };
#   };
#
#   xdg.configFile = {
#     shaderCFLP = {
#       enable = true;
#       source = pkgs.fetchFromGitHub {
#         owner = "Artoriuz";
#         repo = "glsl-chroma-from-luma-prediction";
#         rev = "master";
#         sha256 = "sha256-sYsv6suAeS81fSdbAaabhs1v73FlxhrDLgZM245Ua9Q=";
#       };
#       target = "mpv/shaders/CFLP";
#     };
#     shaderArtCNN = {
#       enable = true;
#       source = pkgs.fetchFromGitHub {
#         owner = "Artoriuz";
#         repo = "ArtCNN";
#         rev = "master";
#         sha256 = "sha256-rXpnXo2ynN7nhLcMdGhy4201D66+Is+Uxi1RLNGWaS4=";
#       };
#       target = "mpv/shaders/ArtCNN";
#     };
#   };
# }
