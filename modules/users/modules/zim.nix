{
  config,
  lib,
  pkgs,
  ...
}:

let
  id = 8255;
in
{
  options = {
    ixnay.users.zim.enable = lib.mkEnableOption "User: rz";
  };

  config = lib.mkIf config.ixnay.users.zim.enable {
    sops = {
      secrets = {
        "user/zim/password" = {
          neededForUsers = true;
        };
      };
    };

    users = {
      users = {
        zim = {
          shell = pkgs.fish;
          description = "Aryn Matthee";
          extraGroups = [ "wheel" ];
          hashedPasswordFile = config.sops.secrets."user/zim/password".path;
          isNormalUser = true;
          uid = id;
        };
      };
    };
  };
}
