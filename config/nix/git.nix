{
  programs.git = {
     enable = true; 
     #https://blog.gitbutler.com/how-git-core-devs-configure-git/
     settings = {
      alias = {
         st = "status";
         lone = "log --oneline --graph";
      };
      user = {
        name = "clvx";
        email = "michael.ibarra@gmail.com";
      };
      init = {
        defaultBranch = "master";
      };
      core = {
        ui = "auto";
      };
      branch = {
        sort = "-committerdate";
      };
      tag = {
        sort = "version:refname";
      };
      log = {
        decorate = "auto";
        date = "relative";
        graph = "auto";
        abbrevCommit = "true";
        abbrev = "true";
        format = "oneline";
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "zebra";
        mnemonicPrefix = "true";
        renams = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = "true";
        followTags = "true";
      };
      fetch = {
        prune = "true";
        pruneTags = "true";
        all = "true";
      };
      help = {
        autocorrect = "prompt";
      };
      commit = {
        verbose = "true";
      };
      rerere = {
        enabled = "true";
        autoUpdate = "true";
      };
      rebase = {
        autoStash = "true";
        autoSquash = "true";
        updateRefs = "true";
      };
      merge = {
        conflictStyle = "zdiff3";
        tool = "nvimdiff";
      };
      pull = {
        rebase = "true";
      };
     };
   };
 }
