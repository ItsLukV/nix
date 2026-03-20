{
  programs.steam = {
    enable = true; # Master switch, already covered in installation
    remotePlay.openFirewall = true;  # For Steam Remote Play
    dedicatedServer.openFirewall = true; # For Source Dedicated Server hosting
  };
  # Tip: For improved gaming performance, you can also enable GameMode:
  programs.gamemode.enable = true;
}
