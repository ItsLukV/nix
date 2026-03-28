{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.pcConfiguration
      inputs.home-manager.nixosModules.home-manager
      inputs.nvf.nixosModules.default
    ];
  };
  flake.homeConfigurations."lukas" = inputs.home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = { inherit inputs self; };
    modules = [
    {
      home.username = "lukas";
      home.homeDirectory = "/home/lukas";
      home.stateVersion = "25.05";

      imports = [
        self.homeModules.hyprland
      ];
    }

      # self.nixosModules.pcHome
    ];
  };
}
