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

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
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
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in {
    nixosConfigurations.wsl = mkSystem "wsl" {
      system = "x86_64-linux";
      user   = "lukas";
      wsl    = true;
    };

    nixosConfigurations.pc = mkSystem "pc" {
      system = "x86_64-linux";
      user = "lukas";
    };
  };
}
