{
  config,
  lib,
  pkgs,
  ...
}:

let
  id = 9000;
in
{
  options = {
    ixnay.users.zen.enable = lib.mkEnableOption "User: zen";
  };

  config = lib.mkIf config.ixnay.users.zen.enable {
    sops = {
      secrets = {
        "user/zen/password" = {
          neededForUsers = true;
        };
        "user/zen/u2f/fox" = { };
        "user/zen/u2f/pelt" = { };
      };
      templates = {
        "u2f_keys" = {
          content = ''
            zen:${config.sops.placeholder."user/zen/u2f/fox"}:${config.sops.placeholder."user/zen/u2f/pelt"}
          '';
        };
      };
    };

    users = {
      users = {
        zen = {
          shell = pkgs.fish;
          description = "RadiantZen";
          extraGroups = [ "wheel" ];
          hashedPasswordFile = config.sops.secrets."user/zen/password".path;
          isNormalUser = true;
          uid = id;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVScc9U6I0+anQkn/bGBUefk44qpS03B5mJ/8heunp+ RadiantZen"
          ];
        };
      };
    };

    security = {
      pam = {
        u2f = {
          settings = {
            authfile = "${config.sops.templates."u2f_keys".path}";
          };
        };
      };
    };
  };
}
