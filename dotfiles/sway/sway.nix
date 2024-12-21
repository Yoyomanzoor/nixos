{
  config,
  pkgs,
  lib,
  ...
}:

let
  mod = config.wayland.windowManager.sway.config.modifier;
  gtklock-screen = pkgs.writeShellScriptBin "gtklock-screen" (builtins.readFile ./gtklock-screen);
in
{
  # xdg.configFile = {
  #   "sway/config".source = ./dotfiles/sway/config;
  # };

  home.packages = with pkgs; [
    gtklock-screen
    # (writeShellScriptBin "gtklock-screen" (builtins.readFile ./gtklock-screen))
    (writeShellScriptBin "swayworkspace" (builtins.readFile ./swayworkspace))
    (writeShellScriptBin "wofi-emoji" (builtins.readFile ./wofi-emoji))
  ];

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 1740;
        command = "${pkgs.libnotify}/bin/notify-send 'lock in 1 minute'";
      }
      {
        timeout = 1800;
        command = "${gtklock-screen}";
      }
      {
        timeout = 3600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
    extraArgs = [
      "before-sleep 'playerctl pause'"
      "before-sleep '${gtklock-screen}'"
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      down = "j";
      left = "h";
      right = "l";
      up = "k";
      gaps = {
        inner = 20;
        outer = 0;
        smartGaps = true;
        smartBorders = "on";
      };
      floating = {
        border = 5;
      };
      window = {
        titlebar = false;
        border = 5;
        hideEdgeBorders = "smart";
      };
      focus = {
        followMouse = "yes";
        mouseWarping = "container";
      };
      workspaceAutoBackAndForth = true;
      bars = [
        {
          command = "waybar";
          position = "top";
        }
      ];
      input = {
        "type:keyboard" = {
          xkb_layout = "us,ara";
          xkb_options = "grp:alt_space_toggle,caps:escape";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      output = {
        eDP-1 = {
          res = "2160x1350";
          scale = "1";
        };
      };
      seat = {
        "*" = {
          hide_cursor = "5000";
          # hide_cursor = "when-typing enable";
        };
      };
      modes = {
        resize = {
          Escape = "mode default";
          Return = "mode default";
          "${mod}+r" = "mode default";
          Left = "resize shrink width 10 px";
          Down = "resize grow height 10 px";
          Up = "resize shrink height 10 px";
          Right = "resize grow width 10 px";
          h = "resize shrink width 10 px";
          j = "resize grow height 10 px";
          k = "resize shrink height 10 px";
          l = "resize grow width 10 px";
        };
      };
      keybindings = lib.mkOptionDefault {
        # https://github.com/nix-community/home-manager/issues/5804
        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+a" = "focus parent";
        "${mod}+z" = "focus child";
        "${mod}+Shift+t" = "focus mode_toggle";
        # Navigation
        "${mod}+Ctrl+l" = "exec swayworkspace navigate next";
        "${mod}+Ctrl+h" = "exec swayworkspace navigate previous";
        "${mod}+Ctrl+Shift+l" = "exec swayworkspace move next";
        "${mod}+Ctrl+Shift+h" = "exec swayworkspace move previous";
        "${mod}+Ctrl+Right" = "exec swayworkspace navigate next";
        "${mod}+Ctrl+Left" = "exec swayworkspace navigate previous";
        "${mod}+Ctrl+Shift+Right" = "exec swayworkspace move next";
        "${mod}+Ctrl+Shift+Left" = "exec swayworkspace move previous";
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        # Window position
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        # Containing workspace
        # "${mod}+Ctrl+Shift+h" = lib.mkAfter "move workspace to output left";
        # "${mod}+Ctrl+Shift+j" = lib.mkAfter "move workspace to output down";
        # "${mod}+Ctrl+Shift+k" = lib.mkAfter "move workspace to output up";
        # "${mod}+Ctrl+Shift+l" = lib.mkAfter "move workspace to output right";
        # "${mod}+Ctrl+Shift+Left" = "move workspace to output left";
        # "${mod}+Ctrl+Shift+Down" = "move workspace to output down";
        # "${mod}+Ctrl+Shift+Up" = "move workspace to output up";
        # "${mod}+Ctrl+Shift+Right" = "move workspace to output right";
        "${mod}+Ctrl+Shift+1" = "move container to workspace number 1; workspace number 1";
        "${mod}+Ctrl+Shift+2" = "move container to workspace number 2; workspace number 2";
        "${mod}+Ctrl+Shift+3" = "move container to workspace number 3; workspace number 3";
        "${mod}+Ctrl+Shift+4" = "move container to workspace number 4; workspace number 4";
        "${mod}+Ctrl+Shift+5" = "move container to workspace number 5; workspace number 5";
        "${mod}+Ctrl+Shift+6" = "move container to workspace number 6; workspace number 6";
        "${mod}+Ctrl+Shift+7" = "move container to workspace number 7; workspace number 7";
        "${mod}+Ctrl+Shift+8" = "move container to workspace number 8; workspace number 8";
        # Window orientation
        "${mod}+v" = "split vertical";
        "${mod}+g" = "split horizontal";
        "${mod}+BackSpace" = "split toggle";
        # Fullscreen
        "${mod}+f" = "fullscreen toggle";
        # Floating
        "${mod}+Shift+f" = "floating toggle";
        # Scratchpad
        "${mod}+s" = "scratchpad show";
        "${mod}+Shift+s" = "move to scratchpad";
        # Layout toggle
        "${mod}+t" = "toggle tabbed splith splitv";
        # Resize mode
        "${mod}+r" = "mode 'resize'";
        # Gaps
        "${mod}+minus" = "gaps inner current minus 10";
        "${mod}+equal" = "gaps inner current plus 10";
        # Notifications
        "${mod}+n" = "exec --no-startup-id swaync-client -t";
        # Syskeys
        "XF86AudioRaiseVolume" = "exec volumectl up 5";
        "XF86AudioLowerVolume" = "exec volumectl down 5";
        "XF86AudioPause" = "exec playerctl pause";
        "XF86AudioPlay" = "exec playerctl play";
        "XF86MonBrightnessUp" = "exec brightnessctl s +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
        "XF86Display" = "exec --no-startup-id nwg-displays";
        # Exit app
        "${mod}+Shift+q" = "kill";
        # Reload sway
        "${mod}+Shift+c" = "exec $send_reload_pending_tick && swaymsg reload";
        # Power down
        "${mod}+Shift+p" = "exec killall wlogout || wlogout";
        # Applications
        "${mod}+space" = "exec --no-startup-id killall wofi || wofi --show drun -I";
        "${mod}+Return" = "exec kitty -e tmux";
        "${mod}+c" = "exec kitty -e nvim";
        "${mod}+e" = "exec kitty -e ranger";
        "${mod}+Shift+Return" = "exec --no-startup-id vieb";
        "${mod}+Ctrl+s" = "exec grim -g '$(slurp -d)' - | wl-copy -t image/png";
        # Emojis
        "${mod}+period" = "exec wofi-emoji";
      };
      keycodebindings = {
        "172" = "exec playerctl play-pause";
        "208" = "exec playerctl play";
      };
      startup = [
        { command = "nm-applet"; }
        { command = "blueman-applet"; }
        { command = "avizo-service"; }
        { command = "playerctld daemon"; }
        { command = "sway-auto-idle-inhibit"; }
      ];
    };
    extraConfig = ''
      workspace 1 output eDP-1
      workspace 2 output eDP-1
      workspace 3 output eDP-1
      workspace 4 output eDP-1
      workspace 5 output HDMI-A-1
      workspace 6 output HDMI-A-1
      workspace 7 output HDMI-A-1
      workspace 8 output HDMI-A-1
      workspace 5 output DP-3
      workspace 6 output DP-3
      workspace 7 output DP-3
      workspace 8 output DP-3
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
      popup_during_fullscreen smart
    '';
  };

}
