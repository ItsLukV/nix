{
  config,
  pkgs,
  inputs,
	lib,
  ...
}: {
  programs.alacritty.settings.font.size = 20;
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,preferred,auto,1"
      "DP-2,preferred,auto-right,1"
      "DP-3,preferred,auto-left,1"
    ];
  };
}
