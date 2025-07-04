{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./common.nix
  ];
  wayland.windowManager.hyprland.settings.monitor = [",preferred,auto,1"];
#  programs.bash.shellAliases.hms = "home-manager switch --flake ~/nix#lukas@laptop";
}
