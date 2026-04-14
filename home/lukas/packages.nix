{pkgs, lib, isWSL, ...}: let
  default = with pkgs; [
    fastfetch
    tmux
    htop
    python3  
    ripgrep
    unzip
    wget
  ];
  gui = with pkgs; [
    discord
    prismlauncher
    waybar
    spotify
    pinta
    android-studio
    kdePackages.dolphin
    ungoogled-chromium
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
