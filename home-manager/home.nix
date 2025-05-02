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
		./modules/git.nix
	];

}
