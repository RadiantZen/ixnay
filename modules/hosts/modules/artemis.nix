{ config, lib, ... }:

{
  options = {
    ixnay.hosts.artemis.enable = lib.mkEnableOption "Artemis host";
  };

  config = lib.mkIf config.ixnay.hosts.artemis.enable {
    boot = {
      zfs = {
        extraPools = [
          "pi"
          "mosaic"
          # "hoard"
        ];
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
      #writebackDevice = "/dev/disk/by-partlabel/zramwbd";
    };

    ixnay = {
      services = {
        printer.enable = true;
        postgresql.enable = true;
        qbittorrent.enable = true;
        caddy.enable = true;
        web = {
          jellyfin.enable = true;
          radicale.enable = true;
          vaultwarden.enable = true;
          vikunja.enable = true;
          miniflux.enable = true;
        };
      };
      machines = {
        custom.dragon.enable = true;
      };
      programs = {
        anki.enable = true;
        browser.enable = true;
        create.enable = true;
        emulation.enable = true;
        foot.enable = true;
        gaming.enable = true;
        gpodder.enable = true;
        hakuneko.enable = true;
        hyfetch.enable = true;
        keepassxc.enable = true;
        ledger-live.enable = true;
        libreoffice.enable = true;
        media.enable = true;
        qalculate.enable = true;
        desktop-environment.sway.enable = true;
        yt-dlp.enable = true;
        yubikey.enable = true;
        zotero.enable = true;
      };
    };
  };
}
