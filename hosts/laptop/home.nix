{
  config,
  pkgs,
  inputs,
	lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    monitor = ["1920x1080@60,preferred,auto,1"];
    exec-once = [
      # Mute the default audio sink at startup
      "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1"
    ];
  };
  programs.waybar.settings.mainBar.modules-right = lib.mkAfter [
    "custom/divider"
    "battery"
  ];
}
