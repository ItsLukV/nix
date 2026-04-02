{ self, inputs, ... }: {

  flake.nixosModules.wslConfiguration = {config, pkgs, inputs, ... }: {
    imports = [
      self.nixosModules.git
      self.nixosModules.nvim
      self.nixosModules.tmux
    ];

    networking.hostName = "wsl";
    wsl = {
      enable = true;
      defaultUser = "lukas";
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;
    users.users.lukas = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };

    system.stateVersion = "25.05"; 
  };
}
