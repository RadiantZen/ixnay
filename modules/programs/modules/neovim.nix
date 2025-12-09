{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.neovim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf config.ixnay.programs.neovim.enable {

    environment = {
      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      systemPackages = with pkgs; [
        (pkgs.callPackage ../../../packages/neovim { })
        rlwrap
        socat
      ];
    };
  };
}
