{ config, lib, pkgs, isWSL, inputs, ... }:
{
  home.stateVersion = "25.05";
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  imports = [
#    inputs.nixvim.homeModules.nixvim
#    ./nixvim.nix
    ./packages.nix
    ./git.nix
    ./bash.nix
  ] ++ (lib.optionals (!isWSL) [
    # Walker
    inputs.walker.homeManagerModules.default
    ./walker.nix
    # Hyprland
    ./hyprland.nix
    ./waybar/waybar.nix
    ./hyprshot.nix
    ./screenShare/screenShare.nix
    # ./wofi.nix

    # Misc
    ./nh.nix
    ./vscode.nix
    ./jetbrains.nix
    ./alacritty.nix
    ./wofi.nix
    ./obs.nix
    ./tmux.nix
  ]);
}
