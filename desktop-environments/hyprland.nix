# Sway setup

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
    ./wayland.nix
  ];

  programs = {
    hyprland = {
      enable = true;
      # withUWSM = true;
    };
    hyprlock.enable = true;
  };

  security.pam.services.hyprlock = {}; # See https://github.com/jovanlanik/gtklock/issues/50
}
