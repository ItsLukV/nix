{
  config,
  pkgs,
  inputs,
	lib,
  ...
}: {
  home = {
    username = "lukas";
    homeDirectory = "/home/lukas";
    stateVersion = "25.05";
		};
  imports = [
    ../../home
  ];
  wayland.windowManager.hyprland.settings = {
    monitor = [",preferred,auto,1"];
    exec-once = lib.mkAfter [
      # Mute the default audio sink at startup
      "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1"
    ];
  };
  programs.waybar.settings.mainBar.modules-right = [
    "battery"
    "custom/divider"
  ];
}
