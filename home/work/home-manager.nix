{ config, lib, pkgs, isWSL, inputs, ... }:
{
  home.stateVersion = "25.05";
  home.username = "work";
  home.homeDirectory = "/home/work";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  imports = [
    ../lukas/packages.nix
    ../lukas/git.nix
    ../lukas/bash.nix
    ./micromamba.nix
    ./apps.nix
  ] ++ (lib.optionals (!isWSL) [
    ../lukas/gnome.nix
    ../lukas/nh.nix
    ../lukas/vscode.nix
    ../lukas/jetbrains.nix
    ../lukas/alacritty.nix
    ../lukas/obs.nix
    ../lukas/tmux.nix
  ]);
}
