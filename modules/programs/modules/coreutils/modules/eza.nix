{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.eza.enable = lib.mkEnableOption "eza";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.eza.enable {
    environment = {
      systemPackages = [
        pkgs.eza
        # config.wrapper.eza.wrapped
      ];
    };
    # wrapper = {
    #   eza = {
    #     name = "eza-custom";
    #     basePackage = pkgs.eza;
    #     wrapperFlags = {
    #       append = [
    #         "--group-directories-first"
    #         "--header"
    #         "--git"
    #         "--icons"
    #         "always"
    #       ];
    #     };
    #   };
    # };
  };
  # TODO Wrap
  # programs = {
  #   eza = {
  #     enable = true;
  #     enableZshIntegration = true;
  #     extraOptions = [
  #       "--group-directories-first"
  #       "--header"
  #     ];
  #     git = true;
  #     icons = "auto";
  #   };
  # };
}
