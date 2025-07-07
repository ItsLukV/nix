{ pkgs, lib, ...}: 

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        visuals = {
          nvim-cursorline = {
            enable = true;
            setupOpts = {
              cursorline = {
                enable = true;
                highlight = "CursorLine";
                timeout = 0;
              };
            };
          };
        };
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        lsp.enable = true;
        languages = {
          enableTreesitter = true;
          
          nix.enable = true;
          ts.enable = true;
          rust.enable = true;
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
        };
      };
    };
  };
}
