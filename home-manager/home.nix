{config, pkgs, inputs, ...}: {
  home = {
    username = "lukas";
    homeDirectory = "/home/lukas";
    stateVersion = "24.11";

    packages = with pkgs; [
      neofetch
      discord
      wofi
      prismlauncher
      pnpm
      nodejs
      waybar
      firefox
      base16-schemes
      fastfetch
    ];
  };


  nixpkgs.config.allowUnfree = true;
  
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/alacritty.nix
    ./modules/bash.nix
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/git.nix
    ./modules/vscode.nix
    ./modules/nixvim.nix
  ];
}
