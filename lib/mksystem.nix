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
  machineConfig = ../hosts/${name}/nixos.nix;
  machineHomeConfig = ../hosts/${name}/home.nix;
  userOSConfig = ../nixos/${user}/nixos.nix;
  userHMConfig = ../home/${user}/home-manager.nix;

in nixpkgs.lib.nixosSystem rec {
    #  inherit system;

  # Needed (rather than only setting config._module.args below) so that
  # `inputs` is available inside a host's `imports` list, which is
  # resolved before config._module.args can be.
  specialArgs = { inherit inputs; };

  modules = [
    # Allow unfree packages.
    { nixpkgs.config.allowUnfree = true; }

    { nixpkgs.hostPlatform = system; }

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
        users.${user}.imports = [ 
          machineHomeConfig
          userHMConfig 
        ];
      };
    }
    {
      config._module.args = {
          #     currentSystem = system;
          currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        isWSL = isWSL;
        inputs = inputs;
      };
    }
  ];
}
