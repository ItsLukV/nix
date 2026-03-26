{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.pcConfiguration
      self.nixosModules.git
      inputs.nvf.nixosModules.default
      self.nixosModules.nvim
      self.nixosModules.niri
    ];
  };
}