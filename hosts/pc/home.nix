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
      # LEFT: Samsung Odyssey G5 (DP-3)
      "DP-3, 2560x1440@180, 0x0, 1"
      # CENTER: Samsung Odyssey G52A (HDMI-A-1)
      "HDMI-A-1, 2560x1440@144, 2560x0, 1"
      # RIGHT: Dell 1908FP (DP-2)
      "DP-2, 1280x1024@60, 5120x0, 1"
    ];
  };
}
