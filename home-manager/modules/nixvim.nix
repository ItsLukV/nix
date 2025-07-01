{
  programs.nixvim = {
    enable = true;
    
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
