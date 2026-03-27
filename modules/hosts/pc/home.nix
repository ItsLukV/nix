{inputs, nixpkgs, self, ... }: {
  flake.homeModules.pcHome = {
    home.username = "lukas";
    home.homeDirectory = "/home/lukas";
    home.stateVersion = "25.05";

    imports = [
      self.homeModules.hyprland
    ];
  };
}
