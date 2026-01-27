{
  programs.bash = {
    enable = true;
    shellAliases = let
      flakePath = "~/nix";
    in {
      vim = "nvim";
      rebuild = "sudo nixos-rebuild switch --flake ${flakePath}#$(hostname)";
			hms = "home-manager switch --flake ${flakePath}#$(hostname)";
    };

    initExtra = ''
      parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
      }
      export PS1="\[\033[32m\][\u@\h:\w]\[\033[36m\]\$(parse_git_branch) \[\033[00m\]$ "
    '';
  };
}
