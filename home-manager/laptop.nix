{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./common.nix
  ];
  wayland.windowManager.hyprland.settings.monitor = [",preferred,auto,1"];
  programs.waybar.settings.mainBar.modules-right = [
		"battery"
		"custom/divider"
  ];
}
