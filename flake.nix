{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
	  ];
	};
	"lenovo-yoga-sway" = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs;};
	  modules = [
	    ./hosts/lenovo-yoga/configuration.nix
	    ./base/laptop-base.nix
	    ./desktop-environments/sway.nix
	    inputs.stylix.nixosModules.stylix
	    inputs.home-manager.nixosModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	    }
	  ];
	};
	"lenovo-yoga-gnome" = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs;};
	  modules = [
	    ./hosts/lenovo-yoga/configuration.nix
	    inputs.stylix.nixosModules.stylix
	    ./base/laptop-base.nix
	    ./desktop-environments/gnome.nix
	    inputs.home-manager.nixosModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      # home-manager.users.yoyomanzoor = import ./home.nix;

	      # Optionally, use home-manager.extraSpecialArgs to pass
	      # arguments to home.nix
	    }
	  ];
	};
	"lenovo-nanoX1-sway" = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs system;};
	  modules = [
	    ./hosts/lenovo-nanoX1/configuration.nix
	    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-nano-gen1
	    ./base/laptop-base.nix
	    ./desktop-environments/sway.nix
	    inputs.stylix.nixosModules.stylix
	    inputs.home-manager.nixosModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	    }
	  ];
	};
	"lenovo-nanoX1-gnome" = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs system;};
	  modules = [
	    ./hosts/lenovo-nanoX1/configuration.nix
	    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-nano-gen1
	    ./base/laptop-base.nix
	    ./desktop-environments/gnome.nix
	    inputs.stylix.nixosModules.stylix
	    inputs.home-manager.nixosModules.home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	    }
	  ];
	};
      };

    };
}
