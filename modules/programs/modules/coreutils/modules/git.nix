{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.coreutils.git.enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf config.ixnay.programs.coreutils.git.enable {
    programs = {
      git = {
        enable = true;
        config = {
          alias = {
            aa = "add --all";
            amend = "commit --amend";
            ci = "commit --verbose";
            co = "checkout";
            cp = "cherry-pick";
            fa = "fetch --all";
            pa = "pull --all";
            pom = "push origin main";
            st = "status";
          };
          commit = {
            gpgSign = true;
          };
          core = {
            editor = "nvim";
          };
          tag = {
            gpgSign = true;
          };
          gpg = {
            format = "ssh";
            ssh.allowedSignersFile = "/home/ecm/.ssh/allowed_signers";
          };
          init = {
            defaultBranch = "main";
          };
          user = {
            # TODO Move to wrapper or user config
            email = "zen@radiantzen.net";
            name = "RadiantZen";
            signingKey = "~/.ssh/RadiantZen";
          };
        };
      };
    };
  };
}
