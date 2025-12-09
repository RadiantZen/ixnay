let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };

  listNixModules =
    path:
    builtins.map (f: path + f) (
      builtins.map (f: "/" + f) (
        builtins.attrNames (
          pkgs.lib.filterAttrs (n: v: pkgs.lib.hasSuffix ".nix" n || v == "directory") (builtins.readDir path)
        )
      )
    );
in
{
  meta = {
    nixpkgs = pkgs;
  };

  defaults =
    { config, lib, ... }:
    {
      imports = listNixModules ./modules;

      system = {
        stateVersion = "${config.system.nixos.release}";
      };

      nix = {
        settings = {
          auto-optimise-store = true;
          sandbox = true;
          # experimental-features = [
          #   "nix-command"
          #   "flakes"
          # ];
        };

        gc = {
          automatic = true;
          dates = "weekly";
          persistent = true;
        };
      };

      nixpkgs = {
        config = {
          allowUnfree = true;
        };

        overlays = [ (import ./overlays) ];
      };

      hardware = {
        enableAllFirmware = true;
      };

      boot.initrd = {
        systemd = {
          enable = true;
        };
      };

      environment = {
        systemPackages = with pkgs; [
          npins
          colmena
        ];
      };

      ixnay = {
        services = {
          core.enable = lib.mkDefault true;
          stylix.enable = lib.mkDefault true;
          network.enable = lib.mkDefault true;
          zfs.enable = lib.mkDefault true;
        };

        programs = {
          coreutils.enable = lib.mkDefault true;
          shell.enable = lib.mkDefault true;
          neovim.enable = lib.mkDefault true;
        };
      };
    };

  artemis =
    { name, nodes, ... }:
    {
      deployment = {
        allowLocalDeployment = true;
        targetHost = null;
      };

      networking = {
        hostName = name;
        hostId = "b80dff01";
      };

      ixnay = {
        hosts = {
          artemis.enable = true;
        };
        users = {
          ecm.enable = true;
        };
      };
    };

  stonewall =
    { name, nodes, ... }:
    {
      deployment = {
        # targetHost = null;
        # targetUser = "root";
        tags = [ "server" ];
      };

      networking = {
        hostName = name;
        hostId = "9d14c145";
      };

      ixnay = {
        hosts = {
          stonewall.enable = true;
        };
        users = {
          zen.enable = true;
        };
      };
    };

  iso =
    { name, nodes, ... }:
    {
      deployment = {
        targetHost = null;
        tags = [ "iso" ];
      };

      networking = {
        hostName = name;
        hostId = "0b610686";
      };

      ixnay = {
        hosts = {
          stonewall.enable = true;
        };
        users = {
          zen.enable = true;
        };
      };
    };
}
