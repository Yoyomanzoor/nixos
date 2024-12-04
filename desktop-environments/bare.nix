# bare tty setup

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}

