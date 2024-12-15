# Things I need for coding

{ pkgs, pkgsUnstable, inputs, ... }:

{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    R
    micromamba
    julia-lts
  ];

  programs.adb.enable = true;
  users.users.yoyomanzoor.extraGroups = ["adbusers"];
}
