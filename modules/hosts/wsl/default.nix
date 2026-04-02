{ self, inputs, ... }: {
  flake.nixosConfigurations.wsl = {config, pkgs, inputs, ... }: {
    specialArgs = { inherit inputs self; };
    modules = [
      inputs.nixos-wsl.nixosModules.default
      
      inputs.nixosModules.wslConfiguration      

      # inputs.home-manager.nixosModules.home-manager
    ];
  };
}
