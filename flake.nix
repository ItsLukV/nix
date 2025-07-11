{
  description = "My system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
		nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		nvf.url = "github:notashelf/nvf";

    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
		nvf,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    commonArgs = {inherit inputs;};
  in {
    # NixOS system configurations
    nixosConfigurations = {
      

			laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = commonArgs;
        modules = [
          ./hosts/laptop/configuration.nix
					./nixos
					nvf.nixosModules.default
          {
            networking.hostName = "laptop";
          }
        ];
      };

      pc = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = commonArgs;
        modules = [
          ./nixos/pc/configuration.nix
					./nixos
          {
            networking.hostName = "pc";
          }
        ];
      };
    };

    # Standalone Home Manager configurations
    homeConfigurations = {
      laptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = commonArgs;
        modules = [
          ./hosts/laptop/home.nix
					./home
        ];
      };

      pc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = commonArgs;
        modules = [
          ./hosts/pc/pc.nix
					./home
        ];
      };
    };
  };
}
