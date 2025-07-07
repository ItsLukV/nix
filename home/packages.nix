{pkgs, ...}: let
  default = with pkgs; [
    fastfetch
    discord
    prismlauncher
    waybar
    spotify
		tmux
  ];
in {
  nixpkgs.config.allowUnfree = true;
  home.packages = default;
}
