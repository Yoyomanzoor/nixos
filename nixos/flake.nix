{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

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
      nixConfig = {
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.optimise.automatic = true;
	nix.gc = {
	  automatic = true;
	  dates = "weekly";
	  options = "--delete-older-than 30d";
	};
      };
      nixosConfigurations = {
	default = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs;};
	  modules = [
	    ./hosts/default/configuration.nix
	    inputs.stylix.nixosModules.stylix
	    # inputs.home-manager.nixosModules.default
	  ];
	};
	"lenovo-yoga-sway" = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs;};
	  modules = [
	    ./hosts/lenovo-yoga/configuration.nix
	    ./base.nix
	    ./sway.nix
	    inputs.stylix.nixosModules.stylix
	  ];
	};
	"lenovo-yoga-gnome" = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs;};
	  modules = [
	    ./hosts/lenovo-yoga/configuration.nix
	    inputs.stylix.nixosModules.stylix
	    ./base.nix
	    ./gnome.nix
	  ];
	};
      };

    };
}
