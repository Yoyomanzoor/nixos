{ config, pkgs, lib, ... }:

{
  xdg.configFile."wlogout/icons" = {
    source = ./icons;
    recursive = true;
  };
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "gtklock-screen";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
* {
	background-image: none;
	box-shadow: none;
}

window {
	background-color: rgba(12, 12, 12, 0.9);
}

button {
    border-radius: 0;
    border-color: #${config.lib.stylix.colors.base0A};
	text-decoration-color: #${config.lib.stylix.colors.base06};
    color: #${config.lib.stylix.colors.base06};
	background-color: #${config.lib.stylix.colors.base00};
	border-style: solid;
	border-width: 1px;
	background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;
}

button:focus, button:active, button:hover {
	background-color: #${config.lib.stylix.colors.base0B};
	outline-style: none;
}

#lock {
    background-image: image(url("./icons/lock.png"), url("./icons/lock.png"));
}

#logout {
    background-image: image(url("./icons/logout.png"), url("./icons/logout.png"));
}

#suspend {
    background-image: image(url("./icons/suspend.png"), url("./icons/suspend.png"));
}

#hibernate {
    background-image: image(url("./icons/hibernate.png"), url("./icons/hibernate.png"));
}

#shutdown {
    background-image: image(url("./icons/shutdown.png"), url("./icons/shutdown.png"));
}

#reboot {
    background-image: image(url("./icons/reboot.png"), url("./icons/reboot.png"));
}
    '';
  };
}
