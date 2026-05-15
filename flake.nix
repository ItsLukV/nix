{
  description = "My system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    /*
		nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
		nvf.url = "github:notashelf/nvf";

    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    ...
  } @ inputs: let
    mkSystem = import ./lib/mksystem.nix {
      inherit inputs;
    };
  in {
    nixosConfigurations.wsl = mkSystem "wsl" {
      system = "x86_64-linux";
      user   = "lukas";
      wsl    = true;
      home-manager = inputs.home-manager;
    };

    nixosConfigurations.pc = mkSystem "pc" {
      system = "x86_64-linux";
      user = "lukas";
      nixpkgs = inputs.nixpkgs;
      home-manager = inputs.home-manager;
    };

    nixosConfigurations.laptop = mkSystem "laptop" {
      system = "x86_64-linux";
      user = "lukas";
      nixpkgs = inputs.nixpkgs-stable;
      home-manager = inputs.home-manager-stable;
    };

  };
}
