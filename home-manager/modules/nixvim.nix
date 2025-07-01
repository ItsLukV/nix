{
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

    plugins = {
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
