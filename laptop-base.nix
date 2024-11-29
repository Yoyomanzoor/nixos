# Laptop packages, for things like power profiles

{ config, lib, ... }:

{
  imports = [
    ./base.nix
  ];

  services.power-profiles-daemon.enable = true;
}
