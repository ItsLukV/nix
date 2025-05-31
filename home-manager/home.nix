{config, pkgs, ...}: {
	nixpkgs.config.allowUnfree = true;

	home = {
		username = "lukas";
		homeDirectory = "/home/lukas";
		stateVersion = "24.11";

/*
		file = {
			".config/awesome" = {
				recursive = true;
				source = ./dotfiles/awesome;
			};
		};
*/
		packages = with pkgs; [
			fastfetch
			discord
			wofi
			prismlauncher
			vscode
			pnpm
			nodejs
			spotify
		];
  	};

	xdg.configFile."river" = {
		source = ./dotfiles/river;
		# recursive = true;
		executable = true;
	};	
	
	imports = [
			./modules/wrapper.nix
	];
}
