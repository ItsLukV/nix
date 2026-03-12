{pkgs, lib, isWSL, ...}: let
  default = with pkgs; [
    fastfetch
    tmux
    htop
    python3  
    ripgrep
    unzip
  ];
  gui = with pkgs; [
    discord
    prismlauncher
    waybar
    spotify
    pinta
    android-studio
    kdePackages.dolphin
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
