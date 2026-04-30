{pkgs, lib, isWSL, ...}: let
  newWallpaperScript = import ./wallPaper.nix { inherit pkgs; };
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
    newWallpaperScript
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
