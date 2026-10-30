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
    github-copilot-cli
    lazygit
    gcc
    sqlite
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    nodejs
  ];
  gui = with pkgs; [
    # Force XWayland: native Wayland Electron can't grab global hotkeys, so
    # Discord's own keybinds (push-to-talk, mute, deafen) silently do nothing
    # while the app isn't focused. Running under X11 restores them.
    (discord.override {
      commandLineArgs = "--ozone-platform=x11";
    })
    vesktop
    prismlauncher
    # waybar
    spotify
    pinta
    # android-studio
    scrcpy
    gnomeExtensions.gsconnect
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
  xdg.mimeApps = lib.mkIf (!isWSL) {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "x-scheme-handler/jetbrains" = "jetbrainsd.desktop";
      "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
    };
  };
  # rustc/cargo from nixpkgs don't bundle the stdlib source; rust-analyzer
  # needs it to resolve std/core, so point it at rustPlatform's copy.
  home.sessionVariables.RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
}
