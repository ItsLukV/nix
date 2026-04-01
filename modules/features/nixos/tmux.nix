{ inputs, ...}: {
  flake.nixosModules.tmux = { pkgs, lib, ... }: {
    programs.tmux = {
      enable = true;
    };
  };
  perSystem = {pkgs, ... }: {
    packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;
      package = pkgs.tmux;


      prefix = "C-b";
      mouse = true;
      modeKeys = "vi";
      baseIndex = 1;

      configAfter = ''
        bind -n M-Left switch-client -p
        bind -n M-Right switch-client -n
        set -g status-left "#{?client_prefix,#[fg=black]#[bg=yellow]#[bold] PREFIX }"
      '';
    };
  };
}

