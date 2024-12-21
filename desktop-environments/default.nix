# Shared DE things

{ pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    pavucontrol
    libnotify
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.xserver.displayManager.gdm = {
    enable = true;
    banner = "smanzoor@umich.edu";
  };
}
