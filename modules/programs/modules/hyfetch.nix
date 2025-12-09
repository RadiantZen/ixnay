{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.hyfetch.enable = lib.mkEnableOption "hyfetch";
  };

  config = lib.mkIf config.ixnay.programs.hyfetch.enable {
    environment = {
      systemPackages = with pkgs; [ hyfetch ];
    };
  };
  # TODO Wrap
  # hyfetch = {
  #   enable = true;
  #   settings = {
  #     preset = "bisexual";
  #     mode = "rgb";
  #     light-dark = "dark";
  #     lightness = 0.65;
  #     color_align = {
  #       mode = "custom";
  #       custom_colors = {
  #         "1" = 2;
  #         "2" = 0;
  #       };
  #     };
  #   };
  # };
}
