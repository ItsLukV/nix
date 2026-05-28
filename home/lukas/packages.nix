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
    github-copilot-cli
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
    zed-editor
    newWallpaperScript
    vesktop
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
