{self, ...}: {
  flake.homeModules.walker = { pkgs, ... }: {
    programs.walker = {
      enable = true;
      runAsService = true; # Note: this option isn't supported in the NixOS module only in the home-manager module

      config = {
        # theme = "";
        placeholders."default" = { input = "Search"; list = "Example"; };
        providers.prefixes = [
          {provider = "websearch"; prefix = "+";}
          {provider = "providerlist"; prefix = "_";}
        ];
        keybinds.quick_activate = ["F1" "F2" "F3"];
      };

      # Set `programs.walker.config.theme="your theme name"` to choose the default theme
      themes = {};
    }; 
  }; 
}
