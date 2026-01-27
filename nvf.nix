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
          
#          nix.enable = true;
          ts.enable = true;
          rust.enable = true;
          go.enable = true;
          clang.enable = true;
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
        };

        globals = {
          mapleader = " ";
        };

        keymaps = [
          {
            mode = "n"; # Normal mode
            key = "<leader>ff";
            action = "<cmd>Telescope find_files<cr>";
            desc = "Telescope: Find Files";
          }
          {
            mode = "n";
            key = "<leader>fg";
            action = "<cmd>Telescope live_grep<cr>";
            desc = "Telescope: Live Grep";
          }
          {
            mode = "n";
            key = "<leader>fb";
            action = "<cmd>Telescope buffers<cr>";
            desc = "Telescope: Find Buffers";
          }
        ];
      };
    };
  };
}
