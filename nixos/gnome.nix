# GNOME setup

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.rounded-corners
    gnomeExtensions.transparent-top-bar
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.just-perfection
    gnomeExtensions.tiling-assistant
    gnomeExtensions.gsconnect
    gnomeExtensions.gamemode-indicator-in-system-settings
    gnomeExtensions.open-bar
    gnome.gnome-terminal
  ];
}
