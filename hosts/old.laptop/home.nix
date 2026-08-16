{
  config,
  pkgs,
  inputs,
	lib,
  ...
}: {
  home = {
    username = "lukas";
    homeDirectory = "/home/lukas";
    stateVersion = "25.05";
		};
  wayland.windowManager.hyprland.extraConfig = ''
    hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

    hl.on("hyprland.start", function()
      -- Mute the default audio sink at startup
      hl.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ 1")
    end)
  '';
  programs.waybar.settings.mainBar.modules-right = [
    "battery"
    "custom/divider"
  ];
}
