{pkgs, ...}: let
  gitPromptColors = pkgs.writeText "git-prompt-colors.sh" ''
  override_git_prompt_colors() {
    GIT_PROMPT_THEME_NAME="Custom"

    GIT_PROMPT_PREFIX="''${Green}["
    GIT_PROMPT_SUFFIX="''${Green}]''${ResetColor}"
    GIT_PROMPT_SEPARATOR=" ''${Green}|''${ResetColor}"
    GIT_PROMPT_BRANCH="''${BoldCyan}"         
    GIT_PROMPT_MASTER_BRANCH="''${BoldCyan}" 
    GIT_PROMPT_STAGED=" ''${BoldGreen}● "
    GIT_PROMPT_CHANGED=" ''${BoldYellow}✚ "
    GIT_PROMPT_CONFLICTS=" ''${BoldRed}✖ "
    GIT_PROMPT_UNTRACKED=" ''${Magenta}… "
    GIT_PROMPT_STASHED=" ''${BoldBlue}⚑ "
    GIT_PROMPT_CLEAN=" ''${BoldGreen}✔"
  }
  reload_git_prompt_colors "Custom"
'';
in {
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
      PS1="\[\033[32m\][\u@\h:\w]\[\033[00m\] $ "

      GIT_PROMPT_ONLY_IN_REPO=1
      GIT_PROMPT_FETCH_REMOTE_STATUS=0
      GIT_PROMPT_START="\[\033[32m\][\u@\h:\w]\[\033[00m\]"
      GIT_PROMPT_END=" $ "
      GIT_PROMPT_THEME=Custom
      GIT_PROMPT_THEME_FILE="${gitPromptColors}"
      source ${pkgs.bash-git-prompt}/gitprompt.sh
    '';
  };
}
