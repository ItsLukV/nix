{pkgs, lib, isWSL, ...}: let
  default = with pkgs; [
    fastfetch
    tmux
  ];
  gui = with pkgs; [
    discord
    prismlauncher
    waybar
    spotify
  ];
in {
  nixpkgs.config.allowUnfree = true;
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
