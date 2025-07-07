{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
		./packages.nix
    ./alacritty.nix
    ./bash.nix
    ./hyprland.nix
    ./waybar.nix
    ./git.nix
    ./vscode.nix
#    ./nixvim.nix
    ./hyprshot.nix
    ./wofi.nix
  ];
}
