{
  config,
  pkgs,
  inputs,
  ...
}: {
nixpkgs.config.allowUnfree = true;
  home = {
    username = "lukas";
    homeDirectory = "/home/lukas";
    stateVersion = "24.11";

    packages = with pkgs; [
      fastfetch
      discord
      prismlauncher
      waybar
      spotify
    ];
  };

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/alacritty.nix
    ./modules/bash.nix
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/git.nix
    ./modules/vscode.nix
    ./modules/nixvim.nix
    ./modules/hyprshot.nix
		./modules/wofi.nix
  ];
}
