{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.media.zathura.enable = lib.mkEnableOption "zathura";
  };

  config = lib.mkIf config.ixnay.programs.media.zathura.enable {
    environment = {
      systemPackages = with pkgs; [ zathura ];
    };
  };
}
# TODO Wrap
# {
#   programs = {
#     zathura = {
#       enable = true;
#       #extraConfig = "";
#       #mappings = {
#       #  "<Right>" = "navigate next";
#       #  D = "toggle_page_mode";
#       #  "[fullscreen] <C-i>" = "zoom in";
#       #};
#       #options = {
#       #  default-bg = "#000000";
#       #  default-fg = "#FFFFFF";
#       #};
#     };
#   };
# }
