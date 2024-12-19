{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    imports = [ inputs.neve.nixvimModule ];
  };
}
