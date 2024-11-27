{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = if builtins ? currentSystem
        then builtins.currentSystem
	else "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
	modules = [
	  ./hosts/default/configuration.nix
	  inputs.stylix.nixosModules.stylix
	  # inputs.home-manager.nixosModules.default
	];
      };
    };

  };
}
