{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "fzf-sesh" (builtins.readFile ./fzf-sesh))
  ];
  xdg.configFile."sesh/sesh.toml".source = ./sesh.toml;
}
