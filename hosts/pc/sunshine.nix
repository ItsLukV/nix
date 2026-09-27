{
  config,
  pkgs,
  lib,
  ...
}: {
  # Use the Lenovo Android tablet as an extra screen: Sunshine captures one
  # monitor here and Moonlight on the tablet displays it, with the tablet's
  # touchscreen coming back as mouse input.
  #
  # This mirrors an existing monitor rather than extending onto a new one,
  # because GNOME 50 on Wayland can't hand out a virtual output: mutter's
  # ScreenCast RecordVirtual creates a PipeWire stream but never adds a
  # logical monitor, the NVIDIA driver ignores the kernel's
  # drm_kms_helper.edid_firmware / video=<connector>:e override knobs, and
  # GNOME no longer ships an X11 session for the old xrandr fake-display
  # trick. Plugging a DisplayPort EDID emulator ("dummy plug") into the free
  # DP-1 port would give the GPU a real 4th monitor that GNOME lays out
  # normally; point output_name at DP-1 then and this becomes a genuine extra
  # desktop instead of a copy.
  services.sunshine = {
    enable = true;

    # NVENC on Linux is only compiled in with CUDA; without this Sunshine
    # falls back to software x264.
    package = pkgs.sunshine.override { cudaSupport = true; };

    # DRM/KMS capture opens the scanout framebuffer directly, which the
    # kernel only permits with CAP_SYS_ADMIN. Without it Sunshine logs
    # "Couldn't get handle for DRM Framebuffer: Probably not permitted" and
    # then fails every encoder probe.
    capSysAdmin = true;

    openFirewall = true;

    settings = {
      sunshine_name = "pc";

      # KMS is the only working backend on GNOME: Sunshine's Wayland capture
      # needs wlroots' zwlr_export_dmabuf_v1, which mutter doesn't implement.
      capture = "kms";
      encoder = "nvenc";

      # Which monitor gets sent to the tablet. Connector names come from the
      # "Start of KMS monitor list" block in:
      #   journalctl --user -u sunshine -b
      # Currently DP-2 = Dell 1908FP 1280x1024, DP-3 and HDMI-1 = Samsung
      # Odyssey G5 2560x1440. The Dell is closest to the tablet's aspect, so
      # its content is what the tablet shows.
      output_name = "DP-2";
    };
  };
}
