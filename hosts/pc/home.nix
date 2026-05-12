{
  config,
  pkgs,
  inputs,
	lib,
  ...
}: let
  monitorLayoutFix = pkgs.writeShellScriptBin "hyprland-monitor-layout-fix" ''
    apply_layout() {
      monitors_json="$(hyprctl -j monitors 2>/dev/null || true)"
      if [ -z "$monitors_json" ] \
        || ! echo "$monitors_json" | ${pkgs.jq}/bin/jq -e 'any(.[]; .name == "HDMI-A-1") and any(.[]; .name == "DP-2") and any(.[]; .name == "DP-3")' >/dev/null; then
        return
      fi

      left_width="$(echo "$monitors_json" | ${pkgs.jq}/bin/jq -r '.[] | select(.name == "DP-3") | .width' | head -n1)"
      center_width="$(echo "$monitors_json" | ${pkgs.jq}/bin/jq -r '.[] | select(.name == "HDMI-A-1") | .width' | head -n1)"

      [ -n "$left_width" ] && [ "$left_width" != "null" ] || left_width=1920
      [ -n "$center_width" ] && [ "$center_width" != "null" ] || center_width=1920

      hyprctl keyword monitor "HDMI-A-1,preferred,0x0,1"
      hyprctl keyword monitor "DP-3,preferred,-''${left_width}x0,1"
      hyprctl keyword monitor "DP-2,preferred,''${center_width}x0,1"
    }

    last_topology=""
    while true; do
      topology="$(hyprctl -j monitors 2>/dev/null | ${pkgs.jq}/bin/jq -r '[.[].name] | sort | join(",")' 2>/dev/null || true)"
      if [ -n "$topology" ] && [ "$topology" != "$last_topology" ]; then
        apply_layout
        last_topology="$topology"
      fi
      sleep 2
    done
  '';
in {
  programs.alacritty.settings.font.size = 20;
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,preferred,0x0,1"
      "DP-3,preferred,auto-left,1"
      "DP-2,preferred,auto-right,1"
    ];
    exec-once = lib.mkAfter [
      "${monitorLayoutFix}/bin/hyprland-monitor-layout-fix"
    ];
  };
}
