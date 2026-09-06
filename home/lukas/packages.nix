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
    # Force XWayland: native Wayland Electron can't grab global hotkeys, so
    # Discord's own keybinds (push-to-talk, mute, deafen) silently do nothing
    # while the app isn't focused. Running under X11 restores them.
    (discord.override {
      commandLineArgs = "--ozone-platform=x11";
    })
    prismlauncher
    waybar
    spotify
    pinta
    android-studio
    kdePackages.dolphin
    ungoogled-chromium
    zed-editor
    newWallpaperScript
    gnome-text-editor
    dbeaver-bin
    sqlitebrowser
    shotcut
    vlc
  ];
in {
  home.packages = default ++ (lib.optionals (!isWSL) gui);
}
