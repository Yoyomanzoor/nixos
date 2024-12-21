# bare tty setup

{ pkgs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}

