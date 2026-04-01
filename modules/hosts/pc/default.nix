{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.pcConfiguration
      inputs.home-manager.nixosModules.home-manager
      inputs.nvf.nixosModules.default
    ];
  };
}
