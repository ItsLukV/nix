{config, pkgs, ...}:
let 
	terminal = pkgs.alacritty + "/bin/alacritty";
	mod = "SUPER";
in 
{
	wayland.windowManager.hyprland = {
		enable = true;


		settings = {
			monitor = [
				"HDMI-A-1,preferred,auto,1"
				"DP-1,preferred,auto-left,1"
				"DP-2,preferred,auto-right,1"
			];

			bind = [
				"${mod}, Q, exec, firefox"
				"${mod}_SHIFT, C, killactive"
				"${mod}, Return, exec, alacritty"
				"${mod}, mouse:272, movewindow"

			];

			bindm = [
				"${mod}, mouse:273, resizewindow"
				"${mod} ALT, mouse:272, resizewindow"
			];

			input = {
				kb_layout = "dk";
			};
		
			misc = {
				disable_hyprland_logo = true;
			};
		};
	
	};
}
