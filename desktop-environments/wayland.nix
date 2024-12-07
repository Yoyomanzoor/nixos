# Shared wayland things

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
    ./default.nix
  ];

  environment.systemPackages = with pkgs; [
    wlogout
    fuzzel # for calling emoji picker
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    configPackages = [ pkgs.gnome.gnome-session ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.xserver.displayManager.gdm = {
    enable = true;
    banner = "smanzoor@umich.edu";
  };
}
