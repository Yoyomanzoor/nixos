# Sway setup

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
    ./wayland.nix
  ];

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
      networkmanagerapplet
      brightnessctl
    ];
    extraSessionCommands = ''
      # SDL:
      export SDL_VIDEODRIVER=wayland
    '';
  };

  programs.waybar.enable = true;
  security.pam.services.gtklock = {}; # See https://github.com/jovanlanik/gtklock/issues/50
  security.polkit.enable = true; # https://nixos.wiki/wiki/Sway
}
