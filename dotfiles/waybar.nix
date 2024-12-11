{ config, pkgs, lib, ... }:

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
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" "clock" ];

        "sway/workspaces" = {
          disable-scroll = false;
          all-outputs = true;
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
          };
          format = "{icon}";
          format-icons = {
            focused = "";
          };
        };

        "sway/mode" = {
          format = "<span style='italic'>{}</span>";
        };

        tray = {
          spacing = 10;
        };

        clock = {
          format = "{:%I:%m %p}";
          format-alt = "{:%Y-%m-%d}";
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
          format-icons = [ "" "" "" "" "" ];
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
            default = [ "" "" ];
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

      #window {
        font-weight: bold;
        font-family: "FiraMono";
      }


      #workspaces button {
        padding: 0 5px;
        background: transparent;
        border-top: 2px solid transparent;
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
        padding: 0 3px;
        margin: 0 2px;
      }
      
      #clock {
        font-weight: bold;
      }
      
      #battery.warning:not(.charging) {
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    '';
  };
}
