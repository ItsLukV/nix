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
    claude-code
    lazygit
    gcc
    sqlite
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
    gnome-text-editor
    dbeaver-bin
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
