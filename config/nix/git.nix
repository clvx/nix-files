{
  programs.git = {
     enable = true;
     userName = "clvx";
     userEmail = "michael.ibarra@gmail.com";
     aliases = {
       st = "status";
       lone = "log --oneline --graph";
     };
     #https://blog.gitbutler.com/how-git-core-devs-configure-git/
     extraConfig = {
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
