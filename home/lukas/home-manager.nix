{ isWSL, inputs, ... }:

{ config, lib, pkgs, ... }:
{
  home.stateVersion = "25.05";
  imports = [
#    inputs.nixvim.homeModules.nixvim
#    ./nixvim.nix
    (import ./packages.nix { inherit isWSL pkgs lib; })
    ./vscode.nix
    ./git.nix
    ./bash.nix
  ] ++ (lib.optionals (!isWSL) [
    ./alacritty.nix
    ./hyprland.nix
    ./waybar.nix
    ./hyprshot.nix
    ./wofi.nix
  ]);
}
