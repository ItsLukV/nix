{ pkgs, ... }:
{
  home.packages = [ pkgs.micromamba ];

  # micromamba is a fast, NixOS-friendly drop-in for conda environments
  # (`micromamba create`, `micromamba activate`, etc.) without the FHS
  # hacks that real conda/Anaconda installers need.
  programs.bash.initExtra = ''
    export MAMBA_ROOT_PREFIX="$HOME/.local/share/mamba"
    eval "$(${pkgs.micromamba}/bin/micromamba shell hook --shell bash)"
  '';
}
