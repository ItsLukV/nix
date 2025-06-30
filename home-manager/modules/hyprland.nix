{config, pkgs, ...}:
let terminal = pkgs.alacritty = "/bin/alacritty";
in 
{
	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			
			"$terminal" = "alacritty";
			"$mod" = "SUPER";

			bindm = [
				"$mod, i, exit"
				"$mod, Return, exec alacritty"
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
				"$mod ALT, mouse:272, resizewindow"
			];
		};
	

	};
}
