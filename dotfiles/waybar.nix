{ config, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        bar_id = "bar-0";
        ipc = true;
        layer = "top";
        position = "top";
        height = 24;
        modules-left = [
          "sway/workspaces"
          "sway/scratchpad"
          "sway/mode"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "battery"
          "tray"
          "clock"
        ];

        "sway/workspaces" = {
          disable-scroll = false;
          all-outputs = true;
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
          };
          format = "{icon}";
          format-icons = {
            focused = "";
          };
        };

        "sway/mode" = {
          format = "<span style='italic'>{}</span>";
        };

        "sway/scratchpad" = {
          format = " {icon} {count}";
          show-empty = false;
          format-icons = [
            ""
            ""
          ];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = " {:%A %B %d   %I:%M %p}";
          # format-alt = "{: %A %B %d  %I:%M %p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        cpu = {
          format = "{usage}% ";
        };

        memory = {
          format = "{}% ";
        };

        battery = {
          bat = "BAT0";
          states = {
            good = 75;
            warning = 25;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected = "Disconnected ⚠";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

      }
    ];
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Ubuntu Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #${config.lib.stylix.colors.base00};
      }

      #window {
        font-weight: bold;
        font-family: "FiraMono";
      }

      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #${config.lib.stylix.colors.base08};
        border-top: 2px solid transparent;
      }

      #workspaces button.focused {
        color: #${config.lib.stylix.colors.base08};
      }

      #workspaces button.empty {
        color: #${config.lib.stylix.colors.base05};
      }

      #mode {
        background: #${config.lib.stylix.colors.base00};
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
        padding: 0 3px;
        margin: 0 2px;
      }

      #clock {
        font-weight: bold;
      }

      #battery icon {
        color: #${config.lib.stylix.colors.base05};
      }

      #battery.charging {
        color: green;
      }


      #battery.warning:not(.charging) {
        color: red;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      network.disconnected {
        background: #${config.lib.stylix.colors.base08};
      }
    '';
  };
}
