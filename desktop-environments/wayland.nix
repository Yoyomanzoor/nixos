# Shared wayland things

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wlogout
    fuzzel
  ];
}
