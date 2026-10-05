{ pkgs, ... }:
{
  home.packages = [ pkgs.micromamba ];

  # micromamba is a fast, NixOS-friendly drop-in for conda environments
  # (`micromamba create`, `micromamba activate`, etc.) without the FHS
  # hacks that real conda/Anaconda installers need.
  programs.bash.initExtra = ''
    export MAMBA_ROOT_PREFIX="$HOME/.local/share/mamba"
    eval "$(${pkgs.micromamba}/bin/micromamba shell hook --shell bash)" 2>/dev/null

    # Work around a nixpkgs packaging quirk: micromamba's shell hook tries to
    # detect its own executable name to decide whether to define the
    # `micromamba`/`mamba` activation functions, but nixpkgs wraps the real
    # binary as ".mamba-wrapped", which fails that check -- it prints a
    # bogus "unknown MAMBA_EXE" error on every shell start and silently
    # skips defining the functions. `__mamba_wrap` (what those functions
    # should call) is still defined correctly by the hook, so just wire the
    # names up ourselves instead of relying on the broken detection.
    micromamba() { __mamba_wrap "$@"; }
    mamba() { __mamba_wrap "$@"; }

    # micromamba's CLI is command-compatible with conda (activate, create,
    # install, list, ...), so alias the familiar name to it too.
    conda() { __mamba_wrap "$@"; }
  '';
}
