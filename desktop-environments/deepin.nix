{
  imports = [
    ./x11.nix
  ];

  services.xserver.desktopManager.deepin = {
    enable = true;
  };

  services.deepin = {
    dde-daemon.enable = true;
    dde-api.enable = true;
    deepin-anything.enable = true;
    app-services.enable = true;
  };
}
