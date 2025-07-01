{pkgs, ...}: {
  programs.nixvim = {
    enable = true;

    opts = {
      updatetime = 100;
      number = true;
      relativenumber = true;

      autoindent = true;
      shiftwidth = 2;
      tabstop = 2;
    };
    extraConfigVim = ''
      command! Format lua vim.lsp.buf.format()
    '';

    plugins = {
      none-ls = {
        enable = true;
        sources = {
          formatting = {
            alejandra.enable = true; # Nix formatter
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          nixd.enable = true;
          ruff.enable = true;
        };
      };
    };
  };
}
