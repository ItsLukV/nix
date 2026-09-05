{
  config,
  pkgs,
  inputs,
  lib,
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
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Secure Boot (needed for FACEIT AC when dual-booting into Windows).
  # systemd-boot itself is unsigned, so it's replaced with lanzaboote,
  # which signs the boot files with locally-generated keys.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  environment.systemPackages = [ pkgs.sbctl pkgs.kubectl ];

  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
  #   xwayland.enable = true;
  # };

  # Keep SDDM's X11 greeter monitor order consistent before login.
  services.xserver.displayManager.setupCommands = "${sddmMonitorLayout}";

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];

  # The B650 chipset's USB controller spuriously signals a wakeup a few
  # seconds into suspend ("xhci_hcd 0000:0a:00.0: xHC error in resume,
  # USBSTS 0x401, Reinit" in the journal), causing the system to sleep for
  # ~10-20s and then wake itself back up. Disable it as a wakeup source;
  # the CPU-attached USB controllers are untouched, so keyboard/mouse wake
  # still works on ports wired to those.
  services.udev.extraRules = ''
    SUBSYSTEM=="pci", ATTR{vendor}=="0x1022", ATTR{device}=="0x43f7", ATTR{power/wakeup}="disabled"
  '';

  environment.variables = {
    USE_WAYLAND_GRIM = 1;
  };
}
