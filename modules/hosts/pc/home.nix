{inputs, nixpkgs, self, ... }: {
  flake.homeConfigurations."lukas" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    extraSpecialArgs = { inherit inputs self; };
    modules = [
      self.homeModules.pcHome
    ];
  };

  flake.homeModules.pcHome = {
    home.username = "lukas";
    home.homeDirectory = "/home/lukas";
    home.stateVersion = "25.05";

    imports = [
      self.homeModules.hyprland
      self.homeModules.waybar
    ];
  };
}
