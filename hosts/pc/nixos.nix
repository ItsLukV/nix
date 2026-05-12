{
  config,
  pkgs,
  inputs,
  ...
}: let
  sddmMonitorLayout = pkgs.writeShellScript "sddm-monitor-layout" ''
    for _ in $(seq 1 20); do
      connected_count="$(${pkgs.xrandr}/bin/xrandr --query 2>/dev/null | ${pkgs.gawk}/bin/awk '/ connected/ {c++} END {print c+0}')"
      [ "$connected_count" -gt 0 ] && break
      sleep 1
    done

    connected="$(${pkgs.xrandr}/bin/xrandr --query 2>/dev/null | ${pkgs.gawk}/bin/awk '/ connected/ {print $1}')"
    [ -n "$connected" ] || exit 0

    left="$(${pkgs.coreutils}/bin/echo "$connected" | ${pkgs.gnugrep}/bin/grep -x 'DP-3' | head -n1)"
    center="$(${pkgs.coreutils}/bin/echo "$connected" | ${pkgs.gnugrep}/bin/grep -x 'HDMI-A-1' | head -n1)"
    right="$(${pkgs.coreutils}/bin/echo "$connected" | ${pkgs.gnugrep}/bin/grep -x 'DP-2' | head -n1)"

    if [ -n "$center" ] && [ -n "$left" ]; then
      ${pkgs.xrandr}/bin/xrandr --output "$center" --auto --primary --pos 0x0 --output "$left" --auto --left-of "$center" >/dev/null 2>&1 \
        || ${pkgs.coreutils}/bin/echo "sddm-monitor-layout: failed to place $left left of $center" >&2
    fi

    if [ -n "$center" ] && [ -n "$right" ]; then
      ${pkgs.xrandr}/bin/xrandr --output "$center" --auto --primary --pos 0x0 --output "$right" --auto --right-of "$center" >/dev/null 2>&1 \
        || ${pkgs.coreutils}/bin/echo "sddm-monitor-layout: failed to place $right right of $center" >&2
    fi
  '';
in {
  networking.hostName = "pc";
  system.stateVersion = "25.05";
  imports = [
    ./hardware-pc.nix
    ../shared.nix
    ./libreoffice.nix
    ./steam.nix
  ];
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    xwayland.enable = true;
  };

  # Keep SDDM's X11 greeter monitor order consistent before login.
  services.xserver.displayManager.setupCommands = "${sddmMonitorLayout}";

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];

  environment.variables = {
    USE_WAYLAND_GRIM = 1;
  };
}
