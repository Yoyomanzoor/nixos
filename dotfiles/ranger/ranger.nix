{
  xdg.configFile = {
    "ranger/commands.py".source = ./commands.py;
    "ranger/commands_full.py".source = ./commands_full.py;
    "ranger/rc.conf".source = ./rc.conf;
    "ranger/rifle.conf".source = ./rifle.conf;
    "ranger/scope.sh".source = ./scope.sh;
    "ranger/plugins" = {
      source = ./plugins;
      recursive = true;
    };
  };
}
