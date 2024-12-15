{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
	"lenovo-nanoX1-wayland" = nixpkgs.lib.nixosSystem {
	  specialArgs = {inherit inputs system;};
	  modules = [
	    ./hosts/lenovo-nanoX1/configuration.nix # hardware specific stuff
	    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-nano-gen1 # optimizations
	    ./base/laptop-base.nix # laptop tools
	    ./desktop-environments/sway.nix # sway WM
	    ./desktop-environments/gnome.nix # gnome DE
	    # ./desktop-environments/hyprland.nix
	    ./code/default.nix # basic coding tools
	    ./theme.nix # theme
	    inputs.stylix.nixosModules.stylix # theming
	    inputs.home-manager.nixosModules.home-manager # home-manager
	    {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	    }
	  ];
	};
	"lenovo-nanoX1" = nixpkgs.lib.nixosSystem { # TTY only
	  specialArgs = {inherit inputs system;};
	  modules = [
	    ./hosts/lenovo-nanoX1/configuration.nix
	    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-nano-gen1
	    ./base/laptop-base.nix
	    ./desktop-environments/bare.nix
	    ./code/default.nix
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
