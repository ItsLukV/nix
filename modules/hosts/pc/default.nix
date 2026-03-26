{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
     self.nixosModules.pcConfiguration
       inputs.nvf.nixosModules.default
      self.nixosModules.nvim
    ];
  };
}
