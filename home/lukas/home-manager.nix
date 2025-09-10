{ config, lib, pkgs, isWSL, inputs, ... }:
{
  home.stateVersion = "25.05";
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  imports = [
#    inputs.nixvim.homeModules.nixvim
#    ./nixvim.nix
    ./packages.nix
    ./git.nix
    ./bash.nix
  ] ++ (lib.optionals (!isWSL) [
    ./vscode.nix
    ./alacritty.nix
    ./hyprland.nix
    ./waybar.nix
    ./hyprshot.nix
    ./wofi.nix
  ]);
}
