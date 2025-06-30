{
	description = "My system configuration";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { nixpkgs, home-manager, ...}@inputs: 
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
