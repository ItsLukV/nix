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

    # Home Manager Config
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit inputs;
          inherit isWSL;
        };
        users.${user}.imports = [ userHMConfig ];
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
