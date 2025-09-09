{ nixpkgs, inputs }:

name:
{
  system,
  user,
  wsl ? false
}:

let
  # True if this a wsl system.
  isWSL = wsl;

  # The config files for this system.
  machineConfig = ../hosts/${name}/configuration.nix;
  userOSConfig = ../nixos/nixos.nix;
  userHMConfig = ../home/${user}/home-manager.nix;

  home-manager = inputs.home-manager.nixosModules;
in nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    # Allow unfree packages.
    { nixpkgs.config.allowUnfree = true; }

    inputs.nvf.nixosModules.default

    # Bring in WSL if this is a WSL build
    (if isWSL then inputs.nixos-wsl.nixosModules.wsl else {}) 

    machineConfig 
    userOSConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import userHMConfig {
        isWSL = isWSL;
        inputs = inputs;
      };
    }
    {
      config._module.args = {
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        isWSL = isWSL;
        inputs = inputs;
      };
    }
  ];
}
