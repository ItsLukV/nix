{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
     self.nixosModules.pcConfiguration
       inputs.nvf.nixosModules.default
      self.nixosModules.nvim
    ];
  };
}
