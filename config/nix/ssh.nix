{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        controlPersist = "4h";
        controlPath = "/home/clvx/.ssh/mux-%r@%h:%p";
        controlMaster = "auto";
        serverAliveInterval = 30;
        serverAliveCountMax = 120;
        forwardAgent = true;
      };
      "github.com" = {
        identityFile = "~/.ssh/id_vcs_rsa";
        identitiesOnly = true;
      };
      "gitlab.com" = {
        identityFile = "~/.ssh/id_vcs_rsa";
        identitiesOnly = true;
      };

    };

  };
}
