{ pkgs, ... }:
{
  home.packages = [ pkgs.wl-clipboard ];

  programs.tmux = {
    enable = true;
    shortcut = "b";
    keyMode = "vi";
    mouse = true;

    extraConfig = ''
      set -g set-clipboard on

      # Also push copy-mode selections straight to the Wayland clipboard,
      # since OSC 52 passthrough (set-clipboard above) isn't reaching it.
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"

      bind -n M-Left previous-window
      bind -n M-Right next-window
  
      # Create a new window (Workspace) with Super + Up
      bind -n M-Up new-window

      # Close a window (Workspace) with Super + Down
      bind -n M-Down confirm-before -p "Kill window? (y/n)" kill-window
      set -g status-left "#{?client_prefix,#[fg=black]#[bg=yellow]#[bold] PREFIX }"
    '';
  };
}
