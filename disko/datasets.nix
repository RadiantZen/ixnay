{
  muse = {
    "muse" = {
      blankSnapshot = true;
      props = {
        recordsize = "1M";
        encryption = "on";
        keyformat = "hex";
        keylocation = "file:///run/keys/zfs/muse";
      };
    };
    "muse/film" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/book" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/music" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/podcast" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/adobe.flash.flashpoint" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/apple.ios" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/atari.2600" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/atari.5200" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/atari.7800" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/atari.jaguar" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/atari.jaguar.cd" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/atari.lynx" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/google.android" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/microsoft.windows" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/microsoft.xbox" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/microsoft.xbox_360" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.3ds" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.ds" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.gb" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.gbc" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.gba" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.gba.e-reader" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.gba.multi" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.gba.video" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.gamecube" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.n64" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.n64.64dd" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.nes.headered" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.nes.headerless" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.snes" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.switch" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.wii" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.wii.wiiware" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/nintendo.wii_u" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sega.dreamcast" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sega.master_system" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sega.mega_cd" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sega.mega_drive" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sega.saturn" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sega.game_gear" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sega.32x" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sony.psx" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sony.ps2" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sony.ps3" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sony.ps4" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sony.ps5" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sony.psp" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/sony.psvita" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/mame.arcade.chd" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/mame.arcade.rom" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/mame.extra" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/mame.multimedia" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/mame.software.chd" = {
      blankSnapshot = true;
      props = { };
    };
    "muse/game/mame.software.rom" = {
      blankSnapshot = true;
      props = { };
    };
  };

  stonewall = {
    "stonewall" = {
      blankSnapshot = true;
      props = {
        encryption = "on";
        keyformat = "hex";
        keylocation = "file:///run/keys/zfs/stonewall";
      };
    };
    "stonewall/etc" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/home" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/nix" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/persist" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/tmp" = {
      blankSnapshot = true;
      props = {
        "com.sun:auto-snapshot" = "false";
      };
    };
    "stonewall/var" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/backup" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/cache" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/nixos" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/chrony" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/immich" = {
      blankSnapshot = true;
      props = {
        recordsize = "1M";
      };
    };
    "stonewall/var/lib/jellyfin" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/paperless" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/postgresql" = {
      blankSnapshot = true;
      props = {
        recordsize = "16k";
      };
    };
    "stonewall/var/lib/private" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/private/spoolman" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/private/stirling-pdf" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/private/vikunja" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/qBittorrent" = {
      blankSnapshot = true;
      props = {
        recordsize = "1M";
      };
    };
    "stonewall/var/lib/vaultwarden" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/lib/radicale" = {
      blankSnapshot = true;
      props = {
        recordsize = "8K";
      };
    };
    "stonewall/var/lib/systemd" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/log" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/log/journal" = {
      blankSnapshot = true;
      props = { };
    };
    "stonewall/var/tmp" = {
      blankSnapshot = true;
      props = {
        "com.sun:auto-snapshot" = "false";
      };
    };
  };
}
