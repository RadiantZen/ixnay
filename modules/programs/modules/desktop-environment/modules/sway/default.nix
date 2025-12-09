{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    ixnay.programs.desktop-environment.sway.enable = lib.mkEnableOption "sway";
  };

  config = lib.mkIf config.ixnay.programs.desktop-environment.sway.enable {
    programs = {
      sway = {
        enable = true;
        wrapperFeatures = {
          gtk = true;
        };
        extraOptions = [
          "--config"
          "${./assets/config}"
        ];
        extraPackages = with pkgs; [
          fnott
          fuzzel
          grim
          libnotify
          slurp
          swaylock
          swayidle
          swww
          wl-clipboard
          yambar
        ];
      };
    };

    environment.variables = {
      "_JAVA_AWT_WM_NONREPARENTING" = 1;
    };

    security = {
      pam.services.swaylock.text = ''
        # PAM configuration file for the swaylock screen locker. By default, it includes
        # the 'login' configuration file (see /etc/pam.d/login)
        auth include login
      '';
    };
  };
}
# services = {
#   swayidle = {
#     enable = true;
#     systemdTarget = "sway-session.target";
#     timeouts = [
#       {
#         timeout = 295;
#         command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
#       }
#       {
#         timeout = 300;
#         command = "${pkgs.swaylock}/bin/swaylock";
#       }
#       {
#         timeout = 360;
#         command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
#         resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
#       }
#     ];
#     events = [
#       {
#         event = "before-sleep";
#         command = "${pkgs.swaylock}/bin/swaylock";
#       }
#     ];
#   };
# };

# programs = {
#   swaylock = {
#     enable = true;
#     settings = {
#       daemonize = true;
#       ignore-empty-password = true;
#       font-size = 24;
#       indicator-idle-visible = false;
#       indicator-radius = 100;
#       show-failed-attempts = true;
#     };
#   };
# };

#   wayland.windowManager.sway = {
#     enable = true;
#     config = {
#       modifier = "Mod4";
#       terminal = "footclient";
#       #menu = "";
#       #defaultWorkspace = "1";
#
#       bars = [];
#
#       bindkeysToCode = false;
#
#       floating = {
#         border = 2;
#         #titlebar = true;
#         criteria = [
#           {
#             title = "Steam - Update News";
#           }
#           {
#             title = "KeePassXC - Browser Access Request";
#           }
#           {
#             title = "KeePassXC - Passkey credentials";
#           }
#         ];
#       };
#
#       focus = {
#         followMouse = "yes";
#         mouseWarping = true;
#         newWindow = "smart";
#         wrapping = "no";
#       };
#
#       gaps = {
#         horizontal = null;
#         vertical = null;
#         inner = null;
#         outer = null;
#         right = null;
#         left = null;
#         top = null;
#         bottom = null;
#         smartBorders = "off";
#         smartGaps = false;
#       };
#
#       #input = {
#       #  xkb_numlock = "enabled";
#       #};
#
#       keybindings = let
#         modifier = config.wayland.windowManager.sway.config.modifier;
#       in lib.mkOptionDefault {
#         # Workspace Navigation
#         "${modifier}+1" = "workspace number 1";
#         "${modifier}+2" = "workspace number 2";
#         "${modifier}+3" = "workspace number 3";
#         "${modifier}+4" = "workspace number 4";
#         "${modifier}+5" = "workspace number 5";
#         "${modifier}+6" = "workspace number 6";
#         "${modifier}+7" = "workspace number 7";
#         "${modifier}+8" = "workspace number 8";
#         "${modifier}+9" = "workspace number 9";
#         "${modifier}+0" = "workspace number 10";
#         "${modifier}+Shift+1" = "move container to workspace number 1";
#         "${modifier}+Shift+2" = "move container to workspace number 2";
#         "${modifier}+Shift+3" = "move container to workspace number 3";
#         "${modifier}+Shift+4" = "move container to workspace number 4";
#         "${modifier}+Shift+5" = "move container to workspace number 5";
#         "${modifier}+Shift+6" = "move container to workspace number 6";
#         "${modifier}+Shift+7" = "move container to workspace number 7";
#         "${modifier}+Shift+8" = "move container to workspace number 8";
#         "${modifier}+Shift+9" = "move container to workspace number 9";
#         "${modifier}+Shift+0" = "move container to workspace number 10";
#         "${modifier}+r" = "mode resize";
#         "${modifier}+p" = "mode screenshot";
#         "${modifier}+Return" = "exec ${pkgs.foot}/bin/footclient";
#         "${modifier}+d" = "exec rofi -show combi";
#         "${modifier}+Shift+q" = "kill";
#         "${modifier}+Shift+x" = "exec ${pkgs.swaylock}/bin/swaylock";
#         "${modifier}+Shift+o" = "exec ${pkgs.sway}/bin/swaymsg 'output * dpms off'";
#         "${modifier}+o" = "exec ${pkgs.sway}/bin/swaymsg 'output * dpms on'";
#       };
#
#       modes = {
#         resize = {
#           Escape = "mode default";
#           Return = "mode default";
#           Up = "resize grow height 10 px";
#           Down = "resize shrink height 10 px";
#           Left = "resize shrink width 10 px";
#           Right = "resize grow width 10 px";
#           h = "resize shrink width 10 px";
#           j = "resize grow height 10 px";
#           k = "resize shrink height 10 px";
#           l = "resize grow width 10 px";
#         };
#         screenshot = {
#           Escape = "mode default";
#           Return = "mode default";
#           f = "exec grim - | wl-copy -t image/png && notify-send -t 2000 'screenshot taken'";
#           s = "exec grim -g \"$(slurp -d)\" - | wl-copy -t image/png && notify-send -t 2000 'screenshot taken'";
#           o = "exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | wl-copy -t image/png && notify-send -t 2000 'screenshot taken'";
#           w = "exec swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused).rect | \"\\(.x),\\(.y) \\(.width)x\\(.height)\"' | grim -g - - | wl-copy -t image/png && notify-send -t 2000 'screenshot taken'";
#         };
#       };
#
#       output = {
#         #DP-3 = {
#         #  bg = "~/path/to/background.png fill";
#         #};
#         HDMI-A-1 = {
#           disable = "";
#         };
#       };
#
#       seat = {
#         "*" = {
#           hide_cursor = "when-typing enable";
#         };
#       };
#
#       startup = [
#         {command = "foot --server";}
#         #{command = "waybar"; always = true;}
#         #{command = "firefox";}
#       ];
#
#       window = {
#         border = 2;
#         hideEdgeBorders = "none";
#         titlebar = false;
#         commands = [];
#       };
#
#       workspaceAutoBackAndForth = true;
#
#       workspaceLayout = "default";
#
#       workspaceOutputAssign = [
#         {
#           output = "DP-3";
#           workspace = "1";
#         }
#       ];
#     };
#
#     #extraConfig = "";
#     #extraConfigEarly = "";
#     #extraOptions = "";
#     #extraSessionCommands = "";
#
#     swaynag = {
#       enable = true;
#     };
#
#     systemd = {
#       enable = true;
#       xdgAutostart = false;
#     };
#   };
# }
