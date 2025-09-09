{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    file = {
      "${config.xdg.configHome}/satty/config.toml".text = ''
        [general]
        # Start Satty in fullscreen mode
        fullscreen = false
        # Exit directly after copy/save action
        early-exit = false
        # Select the tool on startup [possible values: pointer, crop, line, arrow, rectangle, text, marker, blur, brush]
        initial-tool = "pointer"
        # Configure the command to be called on copy, for example `wl-copy`
        copy-command = "${pkgs.wl-clipboard}/bin/wl-copy"
        # Increase or decrease the size of the annotations
        annotation-size-factor = 1
        # Filename to use for saving action: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
        output-filename = "${config.home.homeDirectory}/pictures/screenshots/screenshot-%Y%m%d-%H%M%S.png"
        save-after-copy = false
        default-hide-toolbars = false
        # The primary highlighter: block, freehand
        primary-highlighter = "block"
        disable-notifications = false

        # Font to use for text annotations
        [font]
        family = "Work Sans"
        style = "Bold"
      '';
    };
    packages = with pkgs; [
      hyprshot # screenshot grabber
      satty # screenshot editor
    ];
  };
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        ", Print, exec, ${lib.getExe pkgs.hyprshot} --mode output --raw | ${lib.getExe pkgs.satty} --filename -"
        "SHIFT, Print, exec, ${lib.getExe pkgs.hyprshot} --mode window --raw | ${lib.getExe pkgs.satty} --filename -"
        "SUPER_SHIFT, s, exec, ${lib.getExe pkgs.hyprshot} --mode region --raw | ${lib.getExe pkgs.satty} --filename -"
      ];
    };
  };
}
