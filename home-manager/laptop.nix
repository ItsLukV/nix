{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./common.nix
  ];
  wayland.windowManager.hyprland.settings = {
    monitor = [",preferred,auto,1"];
    exec-once = [
      # Mute the default audio sink at startup
      "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1"
    ];
  };
  programs.waybar.settings.mainBar.modules-right = [
    "battery"
    "custom/divider"
  ];
}
