# Shared DE things

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
