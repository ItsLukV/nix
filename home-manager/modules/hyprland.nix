{config, pkgs, inputs, ...}:
let 
	terminal = pkgs.alacritty + "/bin/alacritty";
	mod = "SUPER";
in 
{
	wayland.windowManager.hyprland = {
		enable = true;
    		package = inputs.hyprland.packages.${pkgs.system}.hyprland;
		plugins = [
			inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
		];

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
				"${mod}, Space, togglefloating," 
				"${mod}, S, exec, wofi --show drun"

				"${mod}, 1, split-workspace, 1"
				"${mod}, 2, split-workspace, 2"
				"${mod}, 3, split-workspace, 3"
				"${mod}, 4, split-workspace, 4"
				"${mod}, 5, split-workspace, 5"
				"${mod}, 6, split-workspace, 6"
				"${mod}, 7, split-workspace, 7"
				"${mod}, 8, split-workspace, 8"
				"${mod}, 9, split-workspace, 9"
			];

			bindm = [
				"${mod}, mouse:272, movewindow"
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
