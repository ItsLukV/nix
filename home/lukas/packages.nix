{pkgs, lib, isWSL, ...}: let
  default = with pkgs; [
    fastfetch
    tmux
    htop
    python3  
  ];
  gui = with pkgs; [
    discord
    prismlauncher
    waybar
    spotify
    pinta
    android-studio
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
