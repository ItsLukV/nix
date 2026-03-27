{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.pcConfiguration
      inputs.home-manager.flakeModules.home-manager
    ];
  };
  flake.homeConfigurations."lukas" = inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.pcHome
    ];
  };
}
