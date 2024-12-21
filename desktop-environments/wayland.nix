# Shared wayland things

{ pkgs, ... }:

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
    configPackages = [ pkgs.gnome-session ];
  };
}
