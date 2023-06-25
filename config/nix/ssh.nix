{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 30;
    controlMaster = "auto";
    controlPath = "/tmp/mux-%r@%h:%p";
    controlPersist = "4h";
    serverAliveCountMax = 120;
    matchBlocks = {
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
