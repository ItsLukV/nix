{
  programs.tmux = {
    enable = true;
    shortcut = "b";
    keyMode = "vi";
    mouse = true;
    
    extraConfig = ''
      bind -n M-Left switch-client -p
      bind -n M-Right switch-client -n

      set -g status-left "#{?client_prefix,#[fg=black]#[bg=yellow]#[bold] PREFIX }"
    '';
  };
}
