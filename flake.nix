{
	description = "My system configuration";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";
		
	 	split-monitor-workspaces = {
      			url = "github:Duckonaut/split-monitor-workspaces";
     			inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    		};
	};

	outputs = { self, nixpkgs, home-manager, ...}@inputs: 
		let
			system = "x86_64-linux";
		in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit inputs; };
			modules = [ ./nixos/configuration.nix ];
		};

		homeConfigurations.lukas = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			extraSpecialArgs = { inherit inputs; };
			modules = [ 
				./home-manager/home.nix 
			];
		};
	};
}
