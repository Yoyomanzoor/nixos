# Sway setup

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland.enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      dmenu
      wmenu
      grim
      slurp
      wl-clipboard
      swaynotificationcenter
      wofi
      nwg-displays
      pkgsUnstable.gtklock
      swww
      avizo
      xdotool
      wlogout
      networkmanagerapplet
    ];
  };
  programs.waybar.enable = true;
  security.pam.services.gtklock = {}; # See https://github.com/jovanlanik/gtklock/issues/50
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
