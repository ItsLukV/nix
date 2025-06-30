{config, pkgs, ...}: {
	home = {
		username = "lukas";
		homeDirectory = "/home/lukas";
		stateVersion = "24.11";

		packages = with pkgs; [
			neofetch
			discord
			wofi
			prismlauncher
			vscode
			pnpm
			nodejs
		];
	};
	nixpkgs.config.allowUnfree = true;

	xdg.configFile."river" = {
		source = ./dotfiles/river;
		# recursive = true;
		executable = true;
	};	

	
	imports = [
		./modules/alacritty.nix
		./modules/bash.nix
		./modules/hyprland.nix
		./modules/git.nix
	];
/*
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
*/
}
