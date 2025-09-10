{pkgs, lib, isWSL, ...}: let
  default = with pkgs; [
    fastfetch
    tmux
    htop
  ];
  gui = with pkgs; [
    discord
    prismlauncher
    waybar
    spotify
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
