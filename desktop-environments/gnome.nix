# GNOME setup
# Inspired from https://github.com/lucasfabre/nixos-config/blob/main/system/gnome.nix

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
    ./wayland.nix
  ];

  # Change brightness and stuff.
  programs.light.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;

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
