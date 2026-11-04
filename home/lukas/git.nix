{
	programs.git = {
		enable = true;
    settings = {
      user = {
		    name = "Lukas";
		    email = "lukasvranic@gmail.com";
      };
      github.user = "itsLukV";
      color.ui = true;
      init.defaultBranch = "main";
      url."git@github.com:".insteadOf = "https://github.com/";
    };
	};
}
