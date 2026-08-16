{
  config,
  pkgs,
  inputs,
	lib,
  ...
}: {
  wayland.windowManager.hyprland.extraConfig = ''
    hl.monitor({ output = "1920x1080@60", mode = "preferred", position = "auto", scale = 1 })

    hl.on("hyprland.start", function()
      -- Mute the default audio sink at startup
      hl.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1")
    end)
  '';
  programs.waybar.settings.mainBar.modules-right = lib.mkAfter [
    "custom/divider"
    "battery"
  ];
}
