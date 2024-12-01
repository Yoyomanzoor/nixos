# Things I need for coding

{ pkgs, pkgsUnstable, inputs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    R
    micromamba
  ];
}
