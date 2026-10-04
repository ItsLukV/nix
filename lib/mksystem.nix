{ nixpkgs, inputs }:

name:
{
  system,
  user,
  extraUsers ? [],
  wsl ? false
}:

let
  # True if this a wsl system.
  isWSL = wsl;

  # The config files for this system.
  machineConfig = ../hosts/${name}/nixos.nix;
  machineHomeConfig = ../hosts/${name}/home.nix;

  # Primary user plus any additional accounts that also get an OS user
  # entry and a Home Manager profile on this host.
  allUsers = [ user ] ++ extraUsers;

  userOSConfigs = map (u: ../nixos/${u}/nixos.nix) allUsers;
  userHMConfigs = nixpkgs.lib.genAttrs allUsers (u: {
    imports = [
      machineHomeConfig
      ../home/${u}/home-manager.nix
    ];
  });

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
  ] ++ userOSConfigs ++ [

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
        users = userHMConfigs;
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
