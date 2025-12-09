{
  config,
  lib,
  pkgs,
  ...
}:

let
  id = 1000;
in
{
  options = {
    ixnay.users.ecm.enable = lib.mkEnableOption "User: ecm";
  };

  config = lib.mkIf config.ixnay.users.ecm.enable {
    sops = {
      secrets = {
        "user/ecm/password" = {
          neededForUsers = true;
        };
      };
    };

    users = {
      users = {
        ecm = {
          shell = pkgs.fish;
          description = "Ebert Charles Matthee";
          extraGroups = [
            "wheel"
            "scanner"
            "lp"
            "docker"
            "adbusers"
          ];
          hashedPasswordFile = config.sops.secrets."user/ecm/password".path;
          isNormalUser = true;
          uid = id;
        };
      };
    };
  };
}
