{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      # "$scrPath" = "$HOME/.local/share/bin"; # set scripts path

      monitor = ",preferred,auto,auto";

      # exec-once = [
      #   # "$scrPath/resetxdgportal.sh" # reset XDPH for screenshare
      #   "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
      #   "dbus-update-activation-environment --systemd --all" # for XDPH
      #   "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # for XDPH
      #   # "$scrPath/polkitkdeauth.sh" # authentication dialogue for GUI apps
      #   # "waybar" # launch the system bar
      #   "blueman-applet" # systray app for Bluetooth
      #   "udiskie --no-automount --smart-tray" # front-end that allows to manage removable media
      #   "nm-applet --indicator" # systray app for Network/Wifi
      #   # "dunst" # start notification demon
      #   # "wl-paste --type text --watch cliphist store" # clipboard store text data
      #   "wl-paste --type image --watch cliphist store" # clipboard store image data
      #   # "$scrPath/swwwallpaper.sh" # start wallpaper daemon
      #   # "$scrPath/batterynotify.sh" # battery notification
      # ];

      env = [
        # "PATH,$PATH:$scrPath"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_SCALE,1"
      ];

      input = {
        kb_layout = "us,ara";
        follow_mouse = "1";

        touchpad = {
          natural_scroll = "no";
        };

        sensitivity = 0;
        force_no_accel = 1;
        numlock_by_default = true;
      };

      device = {
        name = "epic mouse V1";
        sensitivity = -0.5;
      };


      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
      };

      misc = {
        vrr = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      general = {
        gaps_in = 8;
        gaps_out = 14;
        border_size = 3;
        layout = "dwindle";
        resize_on_border = true;
      };


      decoration = {
        rounding = 0;
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "4 4";
        shadow_range = 0;
        shadow_render_power = 4;
        col.shadow = "0xffFFFFFF";

        blur = {
          enabled = "yes";
          size = 6;
          passes = 3;
          new_optimizations = "on";
          ignore_opacity = "on";
          xray = false;
        };
      };


      animations = {
        enabled = "yes";

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];

      };

      cursor = {
        inactive_timeout = 5;
      };

      # Main modifier
      "$mainMod" = "SUPER";

      # Assign apps
      "$term" = "kitty";
      "$editor" = "code";
      "$file" = "thunar";
      "$browser" = "vieb";

      "$moveactivewindow" = "grep -q 'true' <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive";

      bindd = "$mainMod+Alt, C, Color Picker , exec, hyprpicker -a"; # Pick color (Hex) >> clipboard# 

      bind = [
        # "$mainMod+Shift, Q, exec, $scrPath/dontkillsteam.sh" # close focused window
        # "Alt, F4, exec, $scrPath/dontkillsteam.sh" # close focused window
        "$mainMod, Delete, exit," # kill hyprland session
        "$mainMod, W, togglefloating," # toggle the window between focus and float
        "$mainMod, G, togglegroup," # toggle the window between focus and group
        "$mainMod, F, fullscreen," # toggle the window between focus and fullscreen
        # "$mainMod+Shift, F, exec, $scrPath/windowpin.sh" # toggle pin on focused window
        # "$mainMod+Shift, P, exec, $scrPath/logoutlaunch.sh" # launch logout menu
        "Ctrl+Alt, W, exec, killall waybar || waybar" # toggle waybar
        "$mainMod, Return, exec, $term" # launch terminal emulator
        "$mainMod, E, exec, kitty -e ranger" # launch file manager (ranger)
        "$mainMod+Ctrl, E, exec, $file" # launch file manager (thunar)
        "$mainMod, C, exec, kitty -e nvim" # launch text editor (neovim)
        "$mainMod+Ctrl, C, exec, code" # launch text editor (vscode)
        "$mainMod+Shift, Return, exec, $browser" # launch web browser
        # "Ctrl+Shift, Escape, exec, $scrPath/sysmonlaunch.sh" # launch system monitor (htop/btop or fallback to top)
        # "$mainMod, $mainMod_L, exec, pkill -x rofi || $scrPath/rofilaunch.sh d" # launch application launcher
        # "$mainMod, A, exec, pkill -x anyrun || anyrun" # launch application launcher
        # "$mainMod, Tab, exec, pkill -x rofi || $scrPath/rofilaunch.sh w" # launch window switcher
        # "$mainMod+Shift, E, exec, pkill -x rofi || $scrPath/rofilaunch.sh f" # launch file explorer
        "$mainMod, F11, exec, playerctl next" # media next
        "$mainMod, F10, exec, playerctl previous" # media previous
        "$mainMod+Ctrl+Alt, H, changegroupactive, b" # move to previous group
        "$mainMod+Ctrl+Alt, L, changegroupactive, f" # move to next group
        # "$mainMod, P, exec, $scrPath/screenshot.sh s" # partial screenshot capture
        # "$mainMod+Ctrl, P, exec, $scrPath/screenshot.sh sf" # partial screenshot capture (frozen screen)
        # "$mainMod+Alt, P, exec, $scrPath/screenshot.sh m" # monitor screenshot capture
        # ", Print, exec, $scrPath/screenshot.sh p" # all monitors screenshot capture
        # "$mainModShiftAlt, R, exec, $scrPath/record-script.sh --fullscreen" # record screen
        # "$mainMod+Alt, G, exec, $scrPath/gamemode.sh" # disable hypr effects for gamemode
        # "$mainMod+Alt, Right, exec, $scrPath/swwwallpaper.sh -n" # next wallpaper
        # "$mainMod+Alt, Left, exec, $scrPath/swwwallpaper.sh -p" # previous wallpaper
        # "$mainMod+Alt, Up, exec, $scrPath/wbarconfgen.sh n" # next waybar mode
        # "$mainMod+Alt, Down, exec, $scrPath/wbarconfgen.sh p" # previous waybar mode
        # "$mainMod+Shift, R, exec, pkill -x rofi || $scrPath/wallbashtoggle.sh -m" # launch wallbash mode select menu
        # "$mainMod+Shift, T, exec, pkill -x rofi || $scrPath/themeselect.sh" # launch theme select menu
        # "$mainMod+Shift, A, exec, pkill -x rofi || $scrPath/rofiselect.sh" # launch select menu
        # "$mainMod+Shift, W, exec, pkill -x rofi || $scrPath/swwwallselect.sh" # launch wallpaper select menu
        # "$mainMod, V, exec, pkill -x rofi || $scrPath/cliphist.sh c" # launch clipboard
        # "$mainMod+Shift, V, exec, pkill -x rofi || $scrPath/cliphist.sh" # launch clipboard Manager
        # "Alt, Space, exec, $scrPath/keyboardswitch.sh" # switch keyboard layout
        # "Shift+Alt, Space, exec, hyprctl switchxkblayout all next" # switch keyboard layout
        # "$mainMod, slash, exec, pkill -x rofi || $scrPath/keybinds_hint.sh c" # launch keybinds hint
        "$mainMod, Left, movefocus, l"
        "$mainMod, Right, movefocus, r"
        "$mainMod, Up, movefocus, u"
        "$mainMod, Down, movefocus, d"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "Alt, Tab, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod+Ctrl, Right, workspace, r+1"
        "$mainMod+Ctrl, L, workspace, r+1" # Go to the next workspace
        "$mainMod+Ctrl, Left, workspace, r-1"
        "$mainMod+Ctrl, H, workspace, r-1" # Go to the previous workspace
        "$mainMod+Ctrl, Down, workspace, empty "
        "$mainMod+Ctrl, J, workspace, empty" # Go to the first empty workspace
        "$mainMod+Shift, 1, movetoworkspace, 1"
        "$mainMod+Shift, 2, movetoworkspace, 2"
        "$mainMod+Shift, 3, movetoworkspace, 3"
        "$mainMod+Shift, 4, movetoworkspace, 4"
        "$mainMod+Shift, 5, movetoworkspace, 5"
        "$mainMod+Shift, 6, movetoworkspace, 6"
        "$mainMod+Shift, 7, movetoworkspace, 7"
        "$mainMod+Shift, 8, movetoworkspace, 8"
        "$mainMod+Shift, 9, movetoworkspace, 9"
        "$mainMod+Shift, 0, movetoworkspace, 10"
        "$mainMod+Ctrl+Shift, Right, movetoworkspace, r+1"
        "$mainMod+Ctrl+Shift, L, movetoworkspace, r+1" # Move active window to the workspace on the right
        "$mainMod+Ctrl+Shift, Left, movetoworkspace, r-1"
        "$mainMod+Ctrl+Shift, H, movetoworkspace, r-1" # Move active window to the workspace on the left
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod+Alt, S, movetoworkspacesilent, special"
        "$mainMod+Shift, S, movetoworkspacesilent, special"
        "$mainMod, S, togglespecialworkspace,"
        "$mainMod+Ctrl+Shift, S, togglesplit" # toggle split orientation
        "$mainMod+Alt, 1, movetoworkspacesilent, 1"
        "$mainMod+Alt, 2, movetoworkspacesilent, 2"
        "$mainMod+Alt, 3, movetoworkspacesilent, 3"
        "$mainMod+Alt, 4, movetoworkspacesilent, 4"
        "$mainMod+Alt, 5, movetoworkspacesilent, 5"
        "$mainMod+Alt, 6, movetoworkspacesilent, 6"
        "$mainMod+Alt, 7, movetoworkspacesilent, 7"
        "$mainMod+Alt, 8, movetoworkspacesilent, 8"
        "$mainMod+Alt, 9, movetoworkspacesilent, 9"
        "$mainMod+Alt, 0, movetoworkspacesilent, 10"
      ];

      "binde" = [
        "$mainMod, Minus, exec, gaps --inc_gaps" # increase gaps
        "$mainMod, Equal, exec, gaps --dec_gaps" # decrease gaps
        "$mainMod+Alt, L, resizeactive, 30 0" # Resize active window to the right
        "$mainMod+Alt, H, resizeactive, -30 0" # Resize active window to the left
        "$mainMod+Alt, K, resizeactive, 0 -30" # Resize active window to the top
        "$mainMod+Alt, J, resizeactive, 0 30" # Resize active window to the bottom
      ];

      "bindm" = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod, Z, movewindow"
        "$mainMod, X, resizewindow"
      ];

      "bindl" = [
        # ", XF86AudioMute, exec, $scrPath/volumecontrol.sh -o m" # toggle audio mute
        # ", XF86AudioMicMute, exec, $scrPath/volumecontrol.sh -i m" # toggle microphone mute
        ", XF86AudioPlay, exec, playerctl play-pause" # toggle between media play and pause
        ", XF86AudioPause, exec, playerctl play-pause" # toggle between media play and pause
        ", XF86AudioNext, exec, playerctl next" # media next
        ", XF86AudioPrev, exec, playerctl previous" # media previous
      ];

      "bindel" = [
        # ", XF86AudioLowerVolume, exec, $scrPath/volumecontrol.sh -o d" # decrease volume
        # ", XF86AudioRaiseVolume, exec, $scrPath/volumecontrol.sh -o i" # increase volume
        # ", XF86MonBrightnessUp, exec, $scrPath/brightnesscontrol.sh i" # increase brightness
        # ", XF86MonBrightnessDown, exec, $scrPath/brightnesscontrol.sh d" # decrease brightness
      ];

      "binded" = [
        "$mainMod SHIFT, left,Move activewindow to the right,exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l"
        "$mainMod SHIFT, H,Move activewindow to the right,exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l"
        "$mainMod SHIFT, right,Move activewindow to the right,exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r"
        "$mainMod SHIFT, L,Move activewindow to the right,exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r"
        "$mainMod SHIFT, up,Move activewindow to the right,exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u"
        "$mainMod SHIFT, K,Move activewindow to the right,exec, $moveactivewindow  0 -30 || hyprctl dispatch movewindow u"
        "$mainMod SHIFT, down,Move activewindow to the right,exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d"
        "$mainMod SHIFT, J,Move activewindow to the right,exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d"
      ];

      windowrulev2 = [
        "opacity 0.90 0.90,class:^(firefox)$"
        "opacity 0.90 0.90,class:^(Brave-browser)$"
        "opacity 0.80 0.80,class:^(code-oss)$"
        "opacity 0.80 0.80,class:^(Code)$"
        "opacity 0.80 0.80,class:^(code-url-handler)$"
        "opacity 0.80 0.80,class:^(code-insiders-url-handler)$"
        "opacity 0.80 0.80,class:^(kitty)$"
        "opacity 0.80 0.80,class:^(org.kde.dolphin)$"
        "opacity 0.80 0.80,class:^(org.kde.ark)$"
        "opacity 0.80 0.80,class:^(nwg-look)$"
        "opacity 0.80 0.80,class:^(qt5ct)$"
        "opacity 0.80 0.80,class:^(qt6ct)$"
        "opacity 0.80 0.80,class:^(kvantummanager)$"
        "opacity 0.80 0.70,class:^(org.pulseaudio.pavucontrol)$"
        "opacity 0.80 0.70,class:^(blueman-manager)$"
        "opacity 0.80 0.70,class:^(nm-applet)$"
        "opacity 0.80 0.70,class:^(nm-connection-editor)$"
        "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$"
        "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
        "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
        "opacity 0.70 0.70,class:^([Ss]team)$"
        "opacity 0.70 0.70,class:^(steamwebhelper)$"
        "opacity 0.70 0.70,class:^(Spotify)$"
        "opacity 0.70 0.70,initialTitle:^(Spotify Free)$"
        "opacity 0.70 0.70,initialTitle:^(Spotify Premium)$"
        "opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$" # Clapper-Gtk
        "opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$" # Flatseal-Gtk
        "opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$" # Cartridges-Gtk
        "opacity 0.80 0.80,class:^(com.obsproject.Studio)$" # Obs-Qt
        "opacity 0.80 0.80,class:^(gnome-boxes)$" # Boxes-Gtk
        "opacity 0.80 0.80,class:^(vesktop)$" # Vesktop
        "opacity 0.80 0.80,class:^(discord)$" # Discord-Electron
        "opacity 0.80 0.80,class:^(WebCord)$" # WebCord-Electron
        "opacity 0.80 0.80,class:^(ArmCord)$" # ArmCord-Electron
        "opacity 0.80 0.80,class:^(app.drey.Warp)$" # Warp-Gtk
        "opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$" # ProtonUp-Qt
        "opacity 0.80 0.80,class:^(yad)$" # Protontricks-Gtk
        "opacity 0.80 0.80,class:^(Signal)$" # Signal-Gtk
        "opacity 0.80 0.80,class:^(io.github.alainm23.planify)$" # planify-Gtk
        "opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$" # Upscaler-Gtk
        "opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$" # VideoDownloader-Gtk
        "opacity 0.80 0.80,class:^(io.gitlab.adhami3310.Impression)$" # Impression-Gtk
        "opacity 0.80 0.80,class:^(io.missioncenter.MissionCenter)$" # MissionCenter-Gtk
        "opacity 0.80 0.80,class:^(io.github.flattool.Warehouse)$" # Warehouse-Gtk
        "float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$"
        "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
        "float,title:^(About Mozilla Firefox)$"
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "float,class:^(firefox)$,title:^(Library)$"
        "float,class:^(kitty)$,title:^(top)$"
        "float,class:^(kitty)$,title:^(btop)$"
        "float,class:^(kitty)$,title:^(htop)$"
        "float,class:^(vlc)$"
        "float,class:^(kvantummanager)$"
        "float,class:^(qt5ct)$"
        "float,class:^(qt6ct)$"
        "float,class:^(nwg-look)$"
        "float,class:^(org.kde.ark)$"
        "float,class:^(org.pulseaudio.pavucontrol)$"
        "float,class:^(blueman-manager)$"
        "float,class:^(nm-applet)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float,class:^(Signal)$" # Signal-Gtk
        "float,class:^(com.github.rafostar.Clapper)$" # Clapper-Gtk
        "float,class:^(app.drey.Warp)$" # Warp-Gtk
        "float,class:^(net.davidotek.pupgui2)$" # ProtonUp-Qt
        "float,class:^(yad)$" # Protontricks-Gtk
        "float,class:^(eog)$" # Imageviewer-Gtk
        "float,class:^(io.github.alainm23.planify)$" # planify-Gtk
        "float,class:^(io.gitlab.theevilskeleton.Upscaler)$" # Upscaler-Gtk
        "float,class:^(com.github.unrud.VideoDownloader)$" # VideoDownloader-Gkk
        "float,class:^(io.gitlab.adhami3310.Impression)$" # Impression-Gtk
        "float,class:^(io.missioncenter.MissionCenter)$" # MissionCenter-Gtk
      ];

    };
  };
}
