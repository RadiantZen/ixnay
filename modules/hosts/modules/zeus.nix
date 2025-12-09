{ config, lib, ... }:

{
  options = {
    ixnay.hosts.zeus.enable = lib.mkEnableOption "zeus host";
  };

  config = lib.mkIf config.ixnay.hosts.zeus.enable {
    boot = {
      zfs = {
        extraPools = [ ];
      };
    };

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/nix";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };
    };

    zramSwap = {
      writebackDevice = "/dev/disk/by-partlabel/zramwbd";
    };

    sops = {
      secrets = { };
    };

    ixnay = {
      machines = {
        hp.z440.enable = true;
      };
      programs = {
        anki.enable = true;
        bitwarden-desktop.enable = true;
        browser.enable = true;
        create.enable = true;
        emulation.enable = true;
        gaming.enable = true;
        gpodder.enable = true;
        hakuneko.enable = true;
        hyfetch.enable = true;
        desktop-environment.kde-plasma.enable = true;
        libreoffice.enable = true;
        media.enable = true;
        qalculate.enable = true;
        yt-dlp.enable = true;
        yubikey.enable = true;
      };
    };
  };
}
