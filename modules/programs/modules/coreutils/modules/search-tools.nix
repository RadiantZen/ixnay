{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.search-tools.enable = lib.mkEnableOption "search-tools";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.search-tools.enable {
    environment = {
      systemPackages = with pkgs; [
        fd
        ripgrep
      ];
    };
    programs = {
      fzf = {
        keybindings = true;
        fuzzyCompletion = true;
      };
    };
  };

  # TODO Wrap
  # programs = {
  #   search-tools = {
  #     enable = true;
  #     changeDirWidgetCommand = "fd --type d --hidden --no-follow --no-ignore";
  #     defaultCommand = "fd --type f --hidden --no-follow --no-ignore";
  #     fileWidgetCommand = "fd --type f --hidden --no-follow --no-ignore";
  #   };
  # };
}
