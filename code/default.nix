# Things I need for coding

{
  pkgs,
  pkgsUnstable,
  inputs,
  ...
}:

{
  imports = [
  ];

  # don't really need this, just make a nix-shell or use nix develop in folder wherever
  environment.systemPackages = with pkgs; [
    # R
    # # micromamba
    # julia-lts
  ];

  programs.adb.enable = true;
  users.users.yoyomanzoor.extraGroups = [ "adbusers" ];
}
