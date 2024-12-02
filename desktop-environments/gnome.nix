# GNOME setup
# Inspired from https://github.com/lucasfabre/nixos-config/blob/main/system/gnome.nix

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
    ./wayland.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Change brightness and stuff. Using brightnessctl for sway, so moved this guy here.
  programs.light.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    configPackages = [ pkgs.gnome.gnome-session ];
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # nixpkgs.overlays = [ (final: prev: {
  #   gnome-backgrounds = final.gnome.gnome-backgrounds;
  # }) ]; # Cause there's some issue with this thing in current nix version
  # # environment.gnome.excludePackages = [ pkgs.gnome.gnome-backgrounds ];

  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    wl-clipboard
    grim
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.rounded-corners
    gnomeExtensions.transparent-top-bar
    # gnomeExtensions.rounded-window-corners
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.just-perfection
    gnomeExtensions.tiling-assistant
    gnomeExtensions.gsconnect
    gnomeExtensions.gamemode-indicator-in-system-settings
    gnomeExtensions.open-bar
    gnomeExtensions.paperwm
    gnome.gnome-terminal
  ];
}
