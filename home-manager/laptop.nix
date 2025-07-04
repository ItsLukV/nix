{

  config,
  pkgs,
  inputs,
  ...
}: {
	import = [
		./common.nix
	];
	wayland.windowManager.hyprland.settings.monitor = [",preferred,auto,1"];
}
