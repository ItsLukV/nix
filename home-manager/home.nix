{config, pkgs, ...}: {
	home = {
		username = "lukas";
		homeDirectory = "/home/lukas";
		stateVersion = "24.11";

		file = {
				".config/awesome" = {
				recursive = true;
				source = ./dotfiles/awesome;
			};
		};

		packages = with pkgs; [
			neofetch
			discord
			wofi
			prismlauncher
			vscode
			pnpm
			nodejs
			spotify	
		];
		nixpkgs.config.allowUnfree = true;

		xdg.configFile."river" = {
			source = ./dotfiles/river;
			# recursive = true;
			executable = true;
		};	
	
  	};
	imports = [
			./modules/wrapper.nix
	];
}
